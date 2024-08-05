# Mapping Guidelines

## Mapping Standards

- For map edit PRs, we do not accept 'change for the sake of change' remaps, unless you have very good reasoning to do so. Maintainers reserve the right to close your PR if we disagree with your reasoning.

- Map Merge

  - The following guideline for map merging applies to **ALL** mapping contributers.
    - Before committing a map change, you **MUST** run mapmerge2 to normalise your changes. You can do this manually before every commit with `"\tools\mapmerge2\Run Before Committing.bat"` or automatically by installing the hooks at `"\tools\hooks\Install.bat"`.
    - Failure to run Map Merge on a map after editing greatly increases the risk of the map's key dictionary becoming corrupted by future edits after running map merge. Resolving the corruption issue involves rebuilding the map's key dictionary;

- StrongDMM

  - [We strongly encourage use of StrongDMM version 2 or greater, available here.](https://github.com/SpaiR/StrongDMM/releases)
  - When using StrongDMM, the following options must be enabled. They can be found under `File > Preferences`.
    - Sanitize Variables - Removes variables that are declared on the map, but are the same as initial. (For example: A standard floor turf that has `dir = 2` declared on the map will have that variable deleted as it is redundant.)
    - Save format - `TGM`.
    - Nudge mode - pixel_x/pixel_y

- Variable Editing (Var-edits)

  - While var-editing an item within the editor is fine, it is preferred that when you are changing the base behavior of an item (how it functions) that you make a new subtype of that item within the code, especially if you plan to use the item in multiple locations on the same map, or across multiple maps. This makes it easier to make corrections as needed to all instances of the item at one time, as opposed to having to find each instance of it and change them all individually.
    - Subtypes only intended to be used on ruin maps should be contained within an .dm file with a name corresponding to that map within `code\modules\ruins`. This is so in the event that the map is removed, that subtype will be removed at the same time as well to minimize leftover/unused data within the repo.
  - When not using StrongDMM (which handles the following automatically) please attempt to clean out any dirty variables that may be contained within items you alter through var-editing. For example changing the `pixel_x` variable from 23 to 0 will leave a dirty record in the map's code of `pixel_x = 0`.
  - Areas should **never** be var-edited on a map. All areas of a single type, altered instance or not, are considered the same area within the code, and editing their variables on a map can lead to issues with powernets and event subsystems which are difficult to debug.
  - Unless they require custom placement, when placing the following items use the relevant "[direction] bump" instance, as it has predefined pixel offsets and directions that are standardised: APC, Air alarm, Fire alarm, station intercom, newscaster, extinguisher cabient, light switches.

- If you are making non-minor edits to an area or room, (non-minor being anything more than moving a few objects or fixing small bugs) then you should ensure the entire area/room is updated to meet these standards.

- When making a change to an area or room, follow these guidelines:

  - Unless absolutely necessary, do not run pipes (including disposals) under wall turfs.
  - **NEVER** run cables under wall turfs.
  - Keep floor turf variations to a minimum. Generally, more than 3 floor turf types in one room is bad design.
  - Run air pipes together where possible. The first example below is to be avoided, the second is optimal:

    ![image](https://user-images.githubusercontent.com/12197162/120011088-d22c7400-bfd5-11eb-867f-7b137ac5b1b2.png) ![image](https://user-images.githubusercontent.com/12197162/120011126-dfe1f980-bfd5-11eb-96b2-c83238a9cdcf.png)

  - Pipe layouts should be logical and predictable, easy to understand at a glance. Always avoid complex layouts like in this example:

    ![image](https://user-images.githubusercontent.com/12197162/120619480-ecda6f00-c453-11eb-9d9f-abf0d1a99c34.png)

  - Decals are to be used sparingly. Good map design does not require warning tape around everything. Decal overuse contributes to maptick slowdown.
  - Every **area** should contain only one APC and air alarm.
    - Critical infrastructure rooms (such as the engine, arrivals, and medbay areas) should be given an APC with a larger power cell.
  - Every **room** should contain at least one fire alarm, air vent and scrubber, light switch, station intercom, and security camera.
    - Intercoms should be set to frequency 145.9, and be speaker ON Microphone OFF. This is so radio signals can reach people even without headsets on. Larger room will require more than one at a time.
    - Exceptions can be made to security camera placement for certain rooms, such as the execution room. Larger rooms may require more than one security camera. All security cameras should have a descriptive name that makes it easy to find on a camera console.
      - A good example would be the template [Department name] - [Area], so Brig - Cell 1, or Medbay - Treatment Center. Consistency is key to good camera naming.
    - Fire alarms should not be placed next to expected heat sources.
    - Use the following "on" subtype of vents and scrubbers as opposed to var-editing: `/obj/machinery/atmospherics/unary/vent_scrubber/on` and `/obj/machinery/atmospherics/unary/vent_pump/on`
  - Head of staff offices should contain a requests console.
  - Electrochromic windows (`/obj/structure/window/reinforced/polarized`) and doors/windoors (using the `/obj/effect/mapping_helpers/airlock/polarized` helper) are preferred over shutters as the method of restricting view to a room through windows. Shutters are sill appropriate in industrial/hazardous areas of the station (engine rooms, HoP line, science test chamber, etc.).
    - Electrochromic window/windoor/door sets require a unique ID var, and a window tint button (`/obj/machinery/button/windowtint`) with a matching ID var. The default `range` of the button is 7 tiles but can be amended with a var edit.
  - Tiny fans (`/obj/structure/fans/tiny`) can be used to block airflow into problematic areas, but are not a substitute for proper door and firelock combinations. They are useful under blast doors that lead to space when opened.
  - Firelocks should be used at area boundaries over doors and windoors, but not windows. Firelocks can also be used to break up hallways at reasonable intervals.
    - Double firelocks are not permitted.
    - Maintenance access doors should never have firelocks placed over them.
  - Windows to secure areas or external areas should be reinforced. Windows in engine areas should be reinforced plasma glass.
    - Windows in high security areas, such as the brig, bridge, and head of staff offices, should be electrified by placing a wire node under the window.
  - Lights are to be used sparingly, they draw a significant amount of power.
  - Ensure door and windoor access is correctly set, this is now done by using access helpers.

    - Multiple accesses can be added to a door by placing multiple access helpers on the same tile. Be sure to pay attention so as to avoid mixing up `all` and `any` subtypes.
    - Old doors that use var edited access should be updated to use the correct access helper, and the var edit on the door should be cleaned.
      - See [`code\modules\mapping\access_helpers.dm`](../code/modules/mapping/access_helpers.dm) for a list of all access helpers.
    - Subtypes of `/obj/effect/mapping_helpers/airlock/access/any` lets anyone with ONE OF THE LISTED ACCESSES open the door.
    - Subtypes of `/obj/effect/mapping_helpers/airlock/access/all` requires ALL ACCESSES present to open the door.

  - Departments should be connected to maintenance through a back or side door. This lets players escape and allows antags to break in.
    - If this is not possible, departments should have extra entry and exit points.
  - Engine areas, or areas with a high probability of receiving explosions, should use reinforced flooring if appropriate.
  - External areas, or areas where depressurisation is expected and normal, should use airless turf variants to prevent additional atmospherics load.
  - Edits in mapping tools should almost always be possible to replicate in-game. For this reason, avoid stacking multiple structures on the same tile (i.e. placing a light and an APC on the same wall.)
