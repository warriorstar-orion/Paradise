#![crate_name = "rustdmm"]

/// How many Z levels we allow before being suspicious that the wrong number was sent.
pub(crate) const IMPORT_MAP_SUCCESS: i32 = 1;
pub(crate) const IMPORT_MAP_FAILURE: i32 = 1;

pub(crate) const AREA_TEMPLATE_NOOP: &str = "/area/template_noop";
pub(crate) const TURF_TEMPLATE_NOOP: &str = "/turf/template_noop";

use std::{
    collections::HashMap,
    path::PathBuf,
    sync::{Mutex, OnceLock, RwLock},
};

use eyre::eyre;
use eyre::Result;

use byondapi::{
    global_call::call_global,
    map::{byond_block, byond_locatexyz, ByondXYZ},
    prelude::*,
};

// #[derive(PartialEq)]
// enum MapStatus {
//     Unloaded,
//     Loading,
//     Loaded,
// }

use dmmtools::dmm;
use dreammaker::{ast::FormatTreePath, constants::Constant};

use crate::{logging::setup_panic_handler, mapmanip::internal_mapmanip_mutate_map};

pub(crate) struct MapCache {
    pub maps: HashMap<String, dmm::Map>,
    //     pub statuses: HashMap<String, MapStatus>,
}

// pub(crate) struct UniqueAreas {
//     pub unique_areas: HashMap<String, ByondValuePointer>,
// }

// impl UniqueAreas {
//     pub fn new() -> Self {
//         UniqueAreas {
//             unique_areas: Default::default(),
//         }
//     }
// }

#[derive(Debug)]
pub(crate) struct PendingVaredit {
    coords: (i16, i16, i16),
    path: String,
    // path_ref: ByondValue,
    varedits: ByondValue,
}

pub(crate) struct PendingVaredits {
    pending: Vec<PendingVaredit>,
}

// pub(crate) static PENDING_VAREDITS: RwLock<Vec<PendingVaredit>> = RwLock::new(Vec::new());
pub(crate) static PENDING_VAREDITS: RwLock<PendingVaredits> = RwLock::new(PendingVaredits {
    pending: Vec::new(),
});

pub(crate) static MAP_CACHE: OnceLock<MapCache> = OnceLock::new();

// pub(crate) static UNIQUE_AREAS: OnceLock<UniqueAreas> = OnceLock::new();

fn log_debug(msg: String) -> Result<ByondValue, byondapi::Error> {
    call_global("log_debug", &[ByondValue::new_str(msg).unwrap()])
}

fn const_to_byond(constant: &Constant) -> ByondValue {
    setup_panic_handler();
    match constant {
        Constant::Null(_) => ByondValue::null(),
        Constant::New { type_, args } => todo!("new not implemented"),
        Constant::List(l) => {
            let new_list = ByondValue::new_list();
            if let Ok(mut byond_list) = new_list {
                for (key, maybe_value) in l.iter() {
                    match maybe_value {
                        Some(val) => {
                            let _ = byond_list
                                .write_list_index(const_to_byond(key), const_to_byond(val));
                        }
                        None => {
                            let _ = byond_list.push_list(const_to_byond(key));
                        }
                    }
                }
                byond_list
            } else {
                ByondValue::null()
            }
        }
        Constant::Call(_, _) => todo!("call not implemented"),
        Constant::Prefab(p) => ByondValue::new_str(FormatTreePath(&p.path).to_string()).unwrap(),
        Constant::String(ref s) => ByondValue::new_str(s.as_str()).unwrap(),
        Constant::Resource(ref r) => ByondValue::new_str(r.as_str()).unwrap(),
        Constant::Float(f) => ByondValue::new_num(*f),
    }
}

#[byondapi::bind]
fn dmm_import_apply_varedits(mut src: ByondValue, srctype: ByondValue) {
    setup_panic_handler();

    if PENDING_VAREDITS.read().unwrap().pending.is_empty() {
        return Ok(Default::default());
    }

    if let ValueType::Area = ValueType::try_from(src.get_type())? {
        return Ok(Default::default());
    }

    let x = src.read_number("x")? as i16;
    let y = src.read_number("y")? as i16;
    let z = src.read_number("z")? as i16;

    // Consistently, trying to get the type as a string from the atom itself
    // results in complaints that the value isn't a valid UTF-8 string, so
    // we just pass it along in a separate argument.
    let type_path = srctype.get_string()?;

    // call_global(
    //     "log_chat_debug",
    //     &[ByondValue::new_str(format!("got coords=({}, {}, {})", x, y, z)).unwrap()],
    // )?;

    // call_global(
    //     "log_chat_debug",
    //     &[ByondValue::new_str(format!("got type_path={}", type_path)).unwrap()],
    // )?;

    match PENDING_VAREDITS.try_write() {
        Ok(mut lock) => {
            if let Some(pos) = lock
                .pending
                .iter()
                .position(|pending| pending.coords == (x, y, z) && pending.path == type_path)
            {
                lock.pending
                    .remove(pos)
                    .varedits
                    .iter()?
                    .for_each(|(key, value)| {
                        src.write_var(key.get_string().unwrap().as_bytes(), &value);
                    });
                return Ok(ByondValue::new_num(1f32));
            }
        }
        Err(e) => {
            log_debug(format!("failed to acquire write to return varedits: {}", e));
        }
    }

    Ok(ByondValue::new_num(0f32))
}

// #[byondapi::bind]
// fn rustmap_import(byond_mappath: ByondValue) {
//     setup_panic_handler();
//     let mappath = byond_mappath.get_string().unwrap();
//     let dmm = dmm::Map::from_file(PathBuf::from(mappath).as_path());
//     if let Ok(dmm) = dmm {
// 		let map_cache = MAP_CACHE.get().ok_or(eyre!("MAP_CACHE not initialized."));
//     } else {
//         log_debug(format!("failed to open dmm {}", mappath));
//     }
// }

#[byondapi::bind]
fn dmm_import_materialize(mappath: ByondValue, x: ByondValue, y: ByondValue, z: ByondValue) {
    setup_panic_handler();
    let origin_x = x.get_number()? as i16;
    let origin_y = y.get_number()? as i16;
    let origin_z = z.get_number()? as i16;

    let dmm = internal_mapmanip_mutate_map(mappath);
    if let Ok(dmm) = dmm {
        for (i, z) in dmm.iter_levels() {
            for (coord, key) in z.iter_top_down() {
                for (idx, prefab) in dmm.dictionary[&key].iter().enumerate() {
                    if prefab.path == AREA_TEMPLATE_NOOP {
                        continue;
                    }
                    if prefab.path == TURF_TEMPLATE_NOOP {
                        continue;
                    }

                    let loc_coords = ByondXYZ::with_coords((
                        origin_x + coord.x as i16 - 1,
                        origin_y + coord.y as i16 - 1,
                        origin_z + i as i16 - 1,
                    ));
                    // call_global(
                    //     "log_chat_debug",
                    //     &[ByondValue::new_str(format!("loc_coords={:?}", loc_coords)).unwrap()],
                    // )?;

                    let loc = match byond_locatexyz(loc_coords) {
                        Ok(l) => l,
                        Err(e) => call_global(
                            "log_chat_debug",
                            &[ByondValue::new_str(format!("failed to create loc e={}", e))
                                .unwrap()],
                        )?,
                    };

                    if !prefab.vars.is_empty() {
                        let mut varedit_args = ByondValue::new_list()?;
                        prefab.vars.iter().for_each(|(var_name, var_value)| {
                            let val = const_to_byond(var_value);
                            if let Err(e) = varedit_args.write_list_index(
                                ByondValue::new_str(var_name.as_bytes()).unwrap(),
                                val,
                            ) {
                                let _ = call_global(
                                    "log_chat_debug",
                                    &[ByondValue::new_str(format!(
                                        "failed to create prefab_vars e={}",
                                        e
                                    ))
                                    .unwrap()],
                                );
                            }
                        });
                        let pending_varedit = PendingVaredit {
                            coords: loc_coords.coordinates(),
                            path: prefab.path.clone(),
                            varedits: varedit_args,
                        };
                        // let _ = call_global(
                        //     "log_chat_debug",
                        //     &[ByondValue::new_str(format!(
                        //         "pushing pending varedit {:?}",
                        //         &pending_varedit
                        //     ))?],
                        // );

                        match PENDING_VAREDITS.try_write() {
                            Ok(mut lock) => {
                                lock.pending.push(pending_varedit);
                            }
                            Err(e) => {
                                let _ = call_global(
                                    "log_chat_debug",
                                    &[ByondValue::new_str(format!(
                                        "failed to acquire write to push pending: {}",
                                        e
                                    ))
                                    .unwrap()],
                                );
                            }
                        }
                    }

                    if !prefab.vars.is_empty()
                        && (prefab.path.starts_with("/turf/") || prefab.path.eq("/turf"))
                    {
                        // How do you pass positional and named args together? Who knows!
                        // Better hope this signature doesn't change, asshole!
                        let args: [ByondValue; 5] = [
                            ByondValue::new_str(prefab.path.as_bytes())?, // path
                            ByondValue::new_num(1f32),                    // defer_change = TRUE
                            ByondValue::new_num(0f32),                    // keep_icon = FALSE
                            ByondValue::new_num(0f32),                    // ignore_air = FALSE
                            ByondValue::new_num(0f32), // copy_existing_baseturf = FALSE
                        ];
                        if let Err(e) = loc.call("ChangeTurf", &args) {
                            log_debug(format!("ChangeTurf failed: {}", e));
                        }
                    } else if let Err(e) =
                        ByondValue::builtin_new(ByondValue::try_from(prefab.path.clone())?, &[loc])
                    {
                        log_debug(format!("failed to create {}: {}", prefab.path, e));
                    }
                }
            }
        }

        let (width, height, _) = dmm.dim_xyz();
        let mut bounds =
            ByondValue::builtin_new(ByondValue::new_str("/datum/dmm_import_load_rect")?, &[])?;

        let bottom_left_coords = ByondXYZ::with_coords((origin_x, origin_y, origin_z));
        let top_right_coords =
            ByondXYZ::with_coords((origin_x + width as i16, origin_y + height as i16, origin_z));

        let bottom_left = byond_locatexyz(bottom_left_coords)?;
        let top_right = byond_locatexyz(top_right_coords)?;

        // if let Ok(turfs) = byond_block(bottom_left_coords, top_right_coords) {
        //     for turf in turfs {
        //         if let Ok(changing_turf) = turf.read_number("changing_turf") {
        //             if changing_turf != 0f32 {
        //                 let args: [ByondValue; 2] = [
        //                     ByondValue::new_num(1f32), // ignore_air = TRUE
        //                     ByondValue::new_num(1f32), // keep_cabling = TRUE
        //                 ];
        //                 if let Err(e) = turf.call("AfterChange", &args) {
        //                     let _ = call_global(
        //                         "log_chat_debug",
        //                         &[ByondValue::new_str(format!("AfterChange failed: e={}", e))
        //                             .unwrap()],
        //                     );
        //                 }
        //             }
        //         }
        //     }
        // }

        let smoothing_bottom_left = byond_locatexyz(ByondXYZ::with_coords((
            origin_x - 1,
            origin_y - 1,
            origin_z,
        )))?;
        let smoothing_top_right = byond_locatexyz(ByondXYZ::with_coords((
            origin_x + width as i16 + 1,
            origin_y + height as i16 + 1,
            origin_z,
        )))?;
        let _ = bounds.write_var("bottom_left", &bottom_left);
        let _ = bounds.write_var("top_right", &top_right);
        let _ = bounds.write_var("smoothing_bottom_left", &smoothing_bottom_left);
        let _ = bounds.write_var("smoothing_top_right", &smoothing_top_right);
        return Ok(bounds);
    }

    Ok(Default::default())
}

#[byondapi::bind]
fn test_thing(x: ByondValue, y: ByondValue, z: ByondValue) {
    setup_panic_handler();
    let loc = byond_locatexyz(ByondXYZ::with_coords((
        x.get_number()? as i16,
        y.get_number()? as i16,
        z.get_number()? as i16,
    )))?;
    let obj = ByondValue::builtin_new(ByondValue::try_from("/mob/living/carbon/human")?, &[loc])?;

    Ok(obj)
}
