# Glossary

Below is a glossary of common used terms along with their meanings relating to
the coding side of SS13. If you notice any missing terms of discrepancies in
descriptions, feel free to contribute to the list! Feel free to ask any
questions in `#coding-chat` on the discord. Non-coding related Glossary can be
found on the [wiki][]. More in depth information can be found at BYOND's
official [documentation][].

[wiki]: https://paradisestation.org/wiki/index.php?title=Glossary
[documentation]: https://secure.byond.com/docs/ref/#/DM/

#### Pull Request
A request to the Paradise Github Repository for certain
changes to be made to the code of the game. This includes maps and sprites.

#### Commit
A record of files changed and how they were changed, they are each assigned a
special ID called a hash that specifies the changes it makes.

#### Pushing code
Pushing is how you transfer commits from your repository to the Upstream repo.

#### Pulling code
Pulling is transferring commits from the main repo to your remote repo, or from
your remote repository to your local repository.

#### Repo
Short for [repository](#repository).

#### Repository
A collection of code which tracks the commits and changes to it. There are three
main types you will find the upstream repository, your remote repository, and
your local repository.

#### Upstream
The original repo that you have forked your remote repository from. For us, it
is [ParadiseSS13/Paradise](https://github.com/ParadiseSS13/Paradise/).

#### Remote
Your forked copy of the upstream repo that you have complete access over. your
clean copy of master and any published branches you've made can be found here.

#### Local
Your copy of your remote repository on your local machine or computer. Commits
need to be published to your remote repo before they can be pushed to the
upstream repo for a pull request.

#### Publish
Uploading your code from your local machine.

#### Origin
Typically another name for your [remote repo](#remote).

#### Runtime
Runtimes most often refer to runtime errors, which are errors that happen after
compiling and happen in game.

#### Merge Master
The process of merging master into your PR's branch, often to update it.

#### WYCI
"When You Code It", a joking response to someone asking when something will be
added to the game.

#### VSC
Short for [Visual Studio Code](https://code.visualstudio.com/).

#### PR
Short for [Pull Request](#pull-request).

#### Map merge
Tools that automatically attempt to merge maps when merging master or
committing. Map merge is a work in progress and may require manual editing too.

#### Icondiffbot
A tool on GitHub that renders before and after images of BYOND icons. It can be
viewed on any PR by scrolling down to the checks section and clicking details
next to it.

#### LGTM
"Looks Good To Me", used during code reviews.

#### Mapdiffbot
A tool on GitHub that renders before and after images of BYOND maps. It can be
viewed on any PR by scrolling down to the checks section and clicking details
next to it.

#### NPFC
"No Player-Facing Changes", used in the changelog of a PR, most often in
refractors and exploit fixes.

## Basic SS13 Definitions

#### StrongDMM
A [robust mapping tool](https://github.com/SpaiR/StrongDMM/) that is highly
recommended over BYOND's DMM editor, as it is much quicker and has much more
options. Using any version below 2.0 makes your PR very unlikely to be accepted
as it messes with variables.

#### View Variables
An admin tool that can be used in game to view the variables of anything, giving
you more information about them. Very useful for debugging.

#### Fastmos
Fast atmos, usually featuring explosive decomposition and lots of in game death.
Fastmos is not used on Paradise.

#### Atmos
The atmospherics system in SS13, which is very often old and confusing and/or
broken code.

#### Config
The config.toml file for changing things about your local server. You will need
to copy this from the config/example folder if you haven't already.

#### .DMM
DreamMaker maps or DMM files is how BYOND stores maps. These can be edited with
BYOND's tools or something like [StrongDMM](#strongdmm)

#### .DMI
DreamMaker images or DMI files is how BYOND stores images (also known as icons),
these can be edited with BYOND's tools or external tools.

#### .DM
DreamMaker code files, or .dm files are the file format for BYOND source code.
These files must be "ticked" in the .dme file for them to be included in the
game.

#### .DME
"DreamMaker Environment" or DME files are what BYOND uses to compile the game.
It is a list of all .dm files used in the game, if you add a new file you will
need to "Tick" it or add it to this file manually.

#### .DMB
"DreamMaker Build" or DMB files are compiled DME files and are
used with Dream Daemon to run the server.

#### VV
Short for [View Variables](#view-variables).

#### Maintainer
A no longer used title, previously used for people who made sure code is
quality. Maintainers were split up into the Balance Team, Design Team, and several
other groups . Check \[[PR
#18000](https://github.com/ParadiseSS13/Paradise/pull/18000/) for more
information.

#### Head Admin
Head of the admin team and overseeing overall changes and the direction for the
entire Paradise codebase and server. Contact them or the Balance team about
large changes or balance changes before making a PR, including map additions,
new roles, new antagonists, and other similar things.

**Runechat -** Chat appearing above peoples head, a feature added by
[#14141](https://github.com/ParadiseSS13/Paradise/pull/14141/). Often a
joke about players now missing important things in the chat window since
they no longer have to look there for reading messages from people.

**TGUI -** A javascript based format for displaying an interface. It is
used for our user interfaces (except OOC stuff like admin panels), or
are planned to be converted to TGUI. TGUI uses InfernoJS(based off of
reactJS) which is an extension to javascript. More information can be
found at [Guide to
Contributing](Guide_to_Contributing#Learning_how_to_use_TGUI "wikilink")
and [Guide to TGUI](Guide_to_TGUI "wikilink").

**Proc -** Procs or Procedures is a block of code that only runs when it
is called. These are similar to something like functions in python.

**Verb -** A special type of Proc, which is available to mobs.

**Var -** A variable, used for temporarily storing data. For more
permanent data, check out [#DEFINE](Github_Glossary#DEFINE "wikilink").

**Datum -** "The datum object is the ancestor of all other data types
in DM. (The only exceptions are currently /world, /client, /list, and
/savefile, but those will be brought into conformance soon.) That means
that the variables and procedures of /datum are inherited by all other
types of objects."([Byond documentation
excerpt](https://secure.byond.com/docs/ref/#/datum/)) This often used
for things like spells and abilities.

**Atom -** "The /atom object type is the ancestor of all mappable
objects in the game. The types /area, /turf, /obj, and /mob are all
derived from /atom. You should not create instances of /atom directly
but should use /area, /turf, /obj, and /mob for actual objects. The
/atom object type exists for the purpose of defining variables or
procedures that are shared by all of the other "physical" objects.
These are also the only objects for which verbs may be accessible to the
user.

/atom is derived from /datum, so it inherits the basic properties that
are shared by all DM objects."([Byond documentation
excerpt](https://secure.byond.com/docs/ref/#/atom/))

**Area -** "Areas are derived from /area. Regions on the map may be
assigned to an area by painting it onto the map. Areas off the map serve
as rooms that objects may enter and exit.

For each area type defined, one area object is created at runtime. So
for areas on the map, all squares with the same area type belong to the
same instance of the area."([Byond documentation
excerpt](https://secure.byond.com/docs/ref/#/area/)) In SS13, this is
often used for stuff like APCs, Air alarms, and atmos.

**Turf -** Turfs are floors, stuff like space, floors, carpets, or lava,
or walls. This does not include windows, as they are objects.

**Object -** Objects are things you can interact with in game, including
things that do not move. This includes weapons, items,
machinery(Consoles and machines), and several other things.

**Mob -** Mobs are "mobile objects", these include players and
animals. This does not include stuff like conveyors.

### Advanced Definitions {#advanced_definitions}

```{=mediawiki}
{{anchor|DEFINE}}
```
**#DEFINE -** A way of declaring variable either global(across the whole
game) or in a whole file. They should always be found at the beginning
of a file. Defines should always be capitalized (LIKE_THIS) and if not
global should undefined at the end of a file.

**Baseturf -** An SS13 variable that saves the data of what is
underneath if that that is removed. For example, under station floors
there would be a space turf and under lavaland turfs there would be
lava.

```{=mediawiki}
{{anchor|Master Controller}}
```
**Master Controller -** The Master Controller controls all subsystems of
the game, such as the [garbage
collector](Github_Glossary#Garbage "wikilink").

**MC -** Short for Short for [Master
Controller](Github_Glossary#Master_Controller "wikilink").

```{=mediawiki}
{{anchor|Garbage}}
```
**Garbage -** The garbage collector handles items being deleted and
allows them to clean up references, this allows objects to delete much
more efficiently.

```{=mediawiki}
{{anchor|qdel}}
```
**qdel() -** A delete function which tells the [garbage
collector](Github_Glossary#Garbage "wikilink") to handle this object.
This should always be used over del().

**QDEL_NULL() -** A [qdel](Github_Glossary#qdel "wikilink") function
which first nulls out a variable before telling the garbage collector to
handle it.
