## INSTALLATION

First-time installation should be fairly straightforward.
First, you'll need BYOND installed. We're going to assume you already did this

This is a sourcecode-only release, so the next step is to compile the server files.
Open paradise.dme by double-clicking it, open the Build menu, and click compile.
This'll take a little while, and if everything's done right,
you'll get a message like this:

```sh
    saving paradise.dmb (DEBUG mode)
    paradise.dmb - 0 errors, 0 warnings
```

If you see any errors or warnings,
something has gone wrong - possibly a corrupt download or the files extracted wrong,
or a code issue on the main repo.  Feel free to ask on Discord.

Once that's done, open up the config folder.
Firstly, you will want to copy `config.toml` from the example folder into the regular config folder.
You'll want to edit the `url_configuration` section of `config.toml` to set `reboot_url` to your server location,
so that all your players don't get disconnected at the end of each round.
It's recommended you don't turn on the gamemodes with probability 0,
as they have various issues and aren't currently being tested,
so they may have unknown and bizarre bugs.

You'll also want to edit the `admin_configuration` section of `config.toml` to remove the default admins and add your own.
If you are connecting from localhost to your own test server, you should automatically be admin.
"Head of Staff" is the highest level of access, and the other recommended admin levels for now are
"Game Admin".  The format is:

```toml
# Note that your ranks must be cased properly, usernames can be normal keys or ckey
admin_assignments = [
	{ckey = "Admin1", rank = "Hosting Provider"},
	{ckey = "Admin2", rank = "Game Admin"},
]
```

You can define your own ranks in the admin section of `config.toml`.

If you want to run a production scale server, we highly recommend using database administrators.

Finally, to start the server,
run Dream Daemon and enter the path to your compiled paradise.dmb file.
Make sure to set the port to the one you specified in the config.txt,
and set the Security box to 'Trusted'.
Then press GO and the server should start up and be ready to join.
