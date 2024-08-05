# Guide to Mapping

The purpose of this guide is to familiarize you with the technical aspects of
mapping for Paradise Station, as well as lay out the rules we have in place for
making mapping changes that meet our standards.

<!-- toc -->

## Tooling

Once you have set up your [development environment][env], you will need several
other tools to edit maps and publish your changes for Pull Requests.

### Mapmerge

If you have a map change published as a PR, and someone else makes a change to
that map which is merged before yours, it is likely that there will be a merge
conflict. Because of the way map files are formatted, using git to resolve these
merge conflicts directly will result in a broken map.

To deal with this, a separate tool, *Mapmerge*, is integrated into git. Mapmerge
has the ability to look at the changes between two maps, merge them together
correctly, and provide markers on the map where it requires a contributor to
make a manual change.

To install Mapmerge, run `\tools\hooks\Install.bat`. Further usage of Mapmerge
is documented in the [Guide to Mapmerge]().

<div class="warning">

Unless you know how to use git effectively, install Mapmerge **before** having
to deal with a map merge conflict.

</div>

[env]: ../getting_started.md

### StrongDMM

[StrongDMM][] is the recommended tool for editing maps by a wide margin. It is
fast, provides easy searching for both objects on maps and objects in the
codebase, an intuitive var-editing system, the ability to hide categories of
objects on the map while editing, and more.

When using StrongDMM, the following options must be enabled. They can be found under _File -> Preferences_:

  - "Sanitize Variables" must be checked. This removes variables that are
    declared on the map, but are the same as their initial value.. (For example:
    A standard floor turf that has `dir = 2` declared on the map will have that
    variable deleted as it is redundant.)
  - "Save Format" must be set to "TGM".
  - "Nudge Mode" must be set to "pixel_x/pixel_y".

[StrongDMM]: https://github.com/SpaiR/StrongDMM/releases

## Technical Standards

In order for mapping changes to comply with our existing codebase, conventions,
and in-game systems, there are several requirements that must be followed.

### Room/Area Changes

1. Unless absolutely necessary, do not run atmospherics pipes or disposals pipes
   under wall turfs. **NEVER** run cables under wall turfs.

2. Every station area (`/area/station` subtypes) should contain only one APC and
   air alarm.

3. Critical infrastructure rooms (such as the engine, arrivals, and medbay
   areas) should be given an APC with a larger power cell. Use the
   `/obj/machinery/power/apc/important` and `/obj/machinery/power/apc/critical`
   mapping helpers for this purpose.

4. Every room should contain at least one air vent and scrubber. Use the
   following "on" subtype of vents and scrubbers as opposed to varediting:
   `/obj/machinery/atmospherics/unary/vent_scrubber/on` and
   `/obj/machinery/atmospherics/unary/vent_pump/on`.

5. Run air pipes together where possible. The first example below is to be
   avoided, the second is optimal:

    ![image](https://user-images.githubusercontent.com/12197162/120011088-d22c7400-bfd5-11eb-867f-7b137ac5b1b2.png) ![image](https://user-images.githubusercontent.com/12197162/120011126-dfe1f980-bfd5-11eb-96b2-c83238a9cdcf.png)

   Pipe layouts should be logical and predictable, easy to understand at a
   glance. Always avoid complex layouts like in this example:

    ![image](https://user-images.githubusercontent.com/12197162/120619480-ecda6f00-c453-11eb-9d9f-abf0d1a99c34.png)

6. Every room should contain at least one fire alarm. Fire alarms should not be
   placed next to expected heat sources.

7. Every room should contain at least one station intercom. Intercoms should be
   set to frequency `145.9`, and be speaker ON Microphone OFF. This is so radio
   signals can reach people even without headsets on. Larger rooms will require
   more than one at a time.

8. Every room should have at least one security camera with the caveats listed
   in the [Design Guide](design.md). Larger rooms may require more than one
   security camera. All security cameras should have a descriptive name that
   makes it easy to find on a camera console. A good example would be the
   template \[Department name\] - \[Area\], so Brig - Cell 1, or Medbay -
   Treatment Center. Consistency is key to good camera naming.

9. Every room should have at least one light switch. When possible, light
   switches should be placed in such a position that a player can activate them
   while standing on the same tile as the room's airlock. Players should not
   have to wander through a dark room to find the light switch.


10. Head of Staff offices should contain a requests console, using the
    `/obj/machinery/requests_console/directional` helpers. Console department names and types should not be varedited.

11. Electrochromic windows (`/obj/structure/window/reinforced/polarized`) and
    doors/windoors (using the `/obj/effect/mapping_helpers/airlock/polarized`
    helper) are preferred over shutters as the method of restricting view to a
    room through windows. Shutters are sill appropriate in industrial/hazardous
    areas of the station (engine rooms, HoP line, science test chamber, etc.).
    Electrochromic window/windoor/door sets require a unique ID var, and a
    window tint button (`/obj/machinery/button/windowtint`) with a matching ID
    var. The default `range` of the button is 7 tiles but can be amended with a
    varedit.

12. Tiny fans (`/obj/structure/fans/tiny`) can be used to block airflow into
    problematic areas, but are not a substitute for proper door and firelock
    combinations. They are useful under blast doors that lead to space when
    opened.

13. Firelocks should be used at area boundaries over doors and windoors, but not
    windows. Firelocks can also be used to break up hallways at reasonable
    intervals. Double firelocks are not permitted. Maintenance access doors
    should never have firelocks placed over them.

14. Windows to secure areas or external areas should be reinforced. Windows in
    engine areas should be reinforced plasma glass. Windows in high security
    areas, such as the brig, bridge, and head of staff offices, should be
    electrified by placing a wire node under the window.

15. Use lights sparingly. They draw a significant amount of power.

16. Door and windoor access must be correctly set by the
    `/obj/effect/mapping_helpers/airlock/access` and
    `/obj/effect/mapping_helpers/airlock/windoor/access` [helpers][],
	respectively. Pay attention to the `any` and `all` subtypes; the `any`
    subtype allows someone with any of the accesses on the airlock to use it,
    and the `all` subtypes requires the user to have all of the access on the
    airlock to use it.

	For example, on the Cerebron (Metastation), miners must walk through the
    Cargo Bay to access the Mining Dock. They do not have Cargo Bay access,
    rather the Cargo Bay airlocks have two access helpers on them:

	- `/obj/effect/mapping_helpers/airlock/access/any/supply/cargo_bay`
	- `/obj/effect/mapping_helpers/airlock/access/any/supply/mining`

    This allows both cargo technicians and miners to use those airlocks.

    Old doors that use var edited access should be updated to use the correct
    access helper, and the var edit on the door should be cleaned.

17. Edits in mapping tools should almost always be possible to replicate
    in-game. For this reason, avoid stacking multiple structures on the same
    tile (e.g. placing a light and an APC on the same wall).

18. Engine areas, or areas with a high probability of receiving explosions,
    should use reinforced flooring if appropriate.

19. External areas, or areas where depressurisation is expected and normal, should use airless turf variants to prevent additional atmospherics load.

[helpers]: https://github.com/ParadiseSS13/Paradise/blob/master/code/modules/mapping/access_helpers.dm

### Varedits

*Varediting*, or variable editing, is the term for modifying a variable of an
object on the map, instead of in code. There are many legitimate reasons to do
so. For example, since nearly all floor tiles on the station are the same
object, their `icon_state` and `dir` variables need to be edited to modify their
appearance.

However, there are also cases when varediting is not appropriate. In general,
when modifying the behavior of an object, creating a subtype in code is almost
always the better option. For example, let's say you have an `/obj/helmet` with
a variable, `strength`, which defines how much damage it can take. The default
is 10. You want to create a stronger helmet, so you add one into a map, and
varedit its `strength` to be 20. This may work for now, but what if the strength
of a helmet no longer is based off that variable? Your helmet will no longer
work as expected. If you instead made an `/obj/helmet/strong`, and made the
variable change there, then if the implementation for `/obj/helmet` changes,
your object will benefit from those changes.

Another example of inappropriate varediting is doing it to an object with many
instances on a map, or multiple instances across maps. If you need to change the
variable, you will then have to find every instance of it across all of the
maps, and change them all.

Areas should **never** be var-edited on a map. All areas of a single type,
altered instance or not, are considered the same area within the code, and
editing their variables on a map can lead to issues with powernets and event
subsystems which are difficult to debug.

Subtypes only intended to be used on ruins should be contained within an .dm file with a name corresponding to that map within `code\modules\ruins`. This is so in the event that the map is removed, that subtype will be removed at the same time as well to minimize leftover/unused data within the repo.

When not using StrongDMM (which handles the following automatically) please attempt to clean out any dirty variables that may be contained within items you alter through var-editing. For example changing the `pixel_x` variable from 23 to 0 will leave a dirty record in the map's code of `pixel_x = 0`.

Unless they require custom placement, when placing the following items use the
relevant directional mapper, as it has predefined pixel offsets and directions
that are standardised: APC, Air alarm, Fire alarm, station intercom, newscaster,
extinguisher cabient, light switches.

## Mapper Contribution Guidelines

These guidelines apply to **all** mapping contributors.

For mapping PRs, we do not accept 'change for the sake of change' remaps, unless
you have very good reasoning to do so. Maintainers reserve the right to close
your PR if we disagree with your reasoning. Large remaps, such as those to a department, must be justified with clear, specific reasons.

Before committing a map change, you **MUST** run mapmerge2 to normalise your
changes. You can do this manually before every commit with
`"\tools\mapmerge2\Run Before Committing.bat"` or automatically by installing
the hooks at `"\tools\hooks\Install.bat"`. Failure to run Map Merge on a map
after editing greatly increases the risk of the map's key dictionary becoming
corrupted by future edits after running map merge. Resolving the corruption
issue involves rebuilding the map's key dictionary;

If you are making non-minor edits to an area or room, (non-minor being anything
more than moving a few objects or fixing small bugs) then you should ensure the
entire area/room is updated to meet these standards.
