from dataclasses import dataclass, field
import sys

from avulto import DME, Path as p


@dataclass(frozen=True)
class MigrationPlan:
    target_path: p
    toggle_on: p
    additional_paths: list[p] = field(default_factory=list)


ASSISTED_PATHS = [
    p("/obj"),
    p("/obj/item"),
    p("/mob"),
    p("/mob/living"),
    p("/atom"),
]

IGNORE_PATHS = [
    p("/area"),
]


def has_legacy_procs(dme: DME, pth: p) -> bool:
    td = dme.types[pth]
    proc_names = td.proc_names(modified=True)
    return any([x for x in proc_names if "legacy__attackchain" in x])


def get_migration_plan(
    dme: DME, target_path: p, checked_types: set | None = None
) -> None | MigrationPlan:
    if checked_types is None:
        checked_types = set()
    td = dme.types[target_path]
    new_attack_chain = td.var_decl("new_attack_chain", parents=True)
    if new_attack_chain.const_val:
        return

    additional_paths = set()
    for subtype in dme.subtypesof(target_path):
        if has_legacy_procs(dme, subtype):
            additional_paths.add(subtype)
            if subtype not in checked_types:
                checked_types.add(subtype)
                migration_plan = get_migration_plan(dme, subtype, checked_types)
                if migration_plan:
                    additional_paths.update(migration_plan.additional_paths)

    toggle_on = target_path
    parent = target_path
    while not any([parent == x for x in ASSISTED_PATHS]):
        parent = parent.parent
        if not has_legacy_procs(dme, parent):
            continue
        if parent in ASSISTED_PATHS:
            continue

        toggle_on = parent
        if parent not in checked_types:
            checked_types.add(parent)
            migration_plan = get_migration_plan(dme, parent, checked_types)
            if migration_plan:
                additional_paths.update(migration_plan.additional_paths)

        additional_paths.add(parent)

    return MigrationPlan(
        target_path=target_path,
        toggle_on=toggle_on,
        additional_paths=additional_paths,
    )

def check_path(dme: DME, target_path: p, found_paths: set):
    if not target_path.child_of("/atom"):
        return
    if target_path in ASSISTED_PATHS:
        return
    if target_path in found_paths:
        return
    for ignore_path in IGNORE_PATHS:
        if target_path.child_of(ignore_path):
            return

    migration_plan = get_migration_plan(dme, target_path)
    if migration_plan:
        print(f"Migration Plan for Path {target_path}")
        if migration_plan.additional_paths:
            print("Required Additional Migrations:")
            for addl_path in sorted(migration_plan.additional_paths):
                print(f"\t{addl_path}")
        else:
            print("No Additional Migrations Required")
        print(f"Toggle `new_attack_chain = TRUE` on:\n\t{migration_plan.toggle_on}\n")

        for addl_path in migration_plan.additional_paths:
            found_paths.add(addl_path)
        for subpath in dme.subtypesof(target_path):
            found_paths.add(subpath)

    found_paths.add(target_path)



if __name__ == "__main__":
    dme = DME.from_file("paradise.dme")
    found_paths = set()

    for target_path in dme.subtypesof("/"):
        check_path(dme, target_path, found_paths)
