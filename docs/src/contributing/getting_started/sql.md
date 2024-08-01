# Configuring a Local Database

## Initial setup and Installation

1. Download and install [MariaDB](https://mariadb.com/downloads/mariadb-tx) for
   your operating system. The default installation settings should work. You
   need TCP enabled and to set a root password. If it offers, do _not_ set it up
   to use Windows authentication. If you've ticked Install as a Windows Service
   (should be ticked by default), it will run whenever you boot up your
   computer, so there's no need to worry about starting it manually.

2. Open HeidiSQL (comes with MariaDB) and connect it to the database. Click on
   *New* to create a new session, check *prompt for credentials* and leave the
   rest as default.

3. Click *Save*, then click open and enter in `root` for the username and the
   password you set up during the installation.

4. Select the database you just created and then select *File -> Load SQL File*,
   and open the `paradise_schema.sql` file found in the `SQL/` directory of the
   game.

5. Press the blue "play" icon in the topic bar of icons. If the schema imported
   correctly you should have no errors in the message box on the bottom.

6. Refresh the panel on the left by right clicking it and ensure there's a new
   database called `paradise_gamedb` created.

7. Create a new user account for the server by going to *Tools -> User Manager*.
   'From Host' should be `127.0.0.1`, not `localhost` if hosted locally.
   Otherwise, use the IP of the game server. For permissions, do not give it any
   global permissions. Instead click *Add Object*,  select the database you
   created for the server, click *OK*, then give it `SELECT`, `DELETE`,
   `INSERT`, and `UPDATE` permissions on that database.

8. You can click the arrow on the password field to get a randomly generated
   password of certain lengths. copy the password before saving as it will be
   cleared the moment you hit *Save*.

9. Open the file `config/config.toml` in your text editor (such as VSCode)
   scroll down to the `[database_configuration]` section. You should've copied
   the file over from the `config/example` folder beforehand.

10. Make sure that these settings are changed:
    -   `sql_enabled` is set to `true`.
    -   `sql_version` to the correct version. By starting the server
        with a mismatched version here and all the other settings set
        up, the chat box will tell you the current version in red text,
        between the messages for all the subsystems initializing. Set
        this to the current version.
    -   `sql_address` is set to `"127.0.0.1"`. (Replace with the
        database server's IP if not hosted locally)
    -   `sql_port` is set to whatever port was selected during the
        MariaDB install, usually `3306`.
    -   `sql_database` is set to the name of your database, usually
        `"paradise_gamedb"`.
    -   `sql_username` is set to the 'User name' of the user you
        created above.
    -   `sql_password` is set to the randomly generated 'Password' of
        the user you created above.
-   The database is now set up for death logging, population logging,
    polls, library, privacy poll, connection logging and player logging.
    There are two more features which you should consider. And it's
    best to do so now, since adopting them later can be a pain.

## Database based administration

Offers a changelog for changes done to admins, which increases
accountability (adding/removing admins, adding/removing permissions,
changing ranks); allows admins with +PERMISSIONS to edit other admins'
permissions ingame, meaning they don't need remote desktop access to
edit admins; Allows for custom ranks, with permissions not being tied to
ranks, offering a better ability for the removal or addition of
permissions to certain admins, if they need to be punished, or need
extra permissions. Enabling this can be done any time, it's just a bit
tedious the first time you do it, if you don't have direct access to
the database.

To enable database based administration:

-   Open \\config\\config.toml and scroll to the `[admin_configuration]`
    section.
-   Set `use_database_admins` to `true`.
-   Add a database entry for the first administrator (likely yourself).
-   Done! Note that anyone set in the `admin_assignments` list will no
    longer be counted.
-   If your database ever dies, your server will revert to the old admin
    system, so it is a good idea to have `admin_assignments` and
    `admin_ranks` set up with some admins too, just so that the loss of
    the database doesn't completely destroy everything.
