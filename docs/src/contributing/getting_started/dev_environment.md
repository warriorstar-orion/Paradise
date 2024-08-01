# Development Environment Setup

This guide will walk you through the basic steps of installing Git, the program
that tracks changes to the Paradise codebase, as well as Visual Studio Code, the
recommended editor for working with Paradise.

## Setting Up Visual Studio Code

Visual Studio Code is the recommended editor for working with Paradise and other
SS13 codebases.

1. Go to VSCode's website: <https://code.visualstudio.com/>
2. Download the appropriate build for your system and install it.

## Setting Up Git

Git is the program that allows you to share your code changes with the Paradise
codebase. It is a command line program, but Visual Studio Code provides nearly
all of its functionality within its editor.

### Installing Git

1. Go to the [Git][] website and download the installer for your operating system.
2. Run the installer, leaving all the default installation settings.

[Git]: https://git-scm.com/downloads

### Registering a GitHub Account

GitHub is the service where the Paradise codebase is stored. You'll need a
GitHub account to contribute to Paradise. Go to the [GitHub signup page][] and
register with a username and e-mail account.

[GitHub signup page]: https://github.com/signup

### Hiding Your Email Address

Changes to Git repositories include the e-mail address of the person who made
the change. If you don't wish your email address to be associated with your
development on Paradise, you can choose to hide your email when interacting with
repositories on GitHub:

1. Log into your GitHub account.
2. Go to <https://github.com/settings/emails>.
3. Select the _Keep my email addresses private_ checkbox.

This means that while your e-mail address is associated with your GitHub
account, any changes you make will only be keyed to a generic e-mail address
with your username.

### Additional Help

For instructional videos on Visual Studio Code's GitHub integration, see <https://vscode.github.com/>.

For introductory videos on Git, see:

- [Introduction to Git with Scott Chacon of GitHub](https://www.youtube.com/watch?v=ZDR433b0HJY)
- [Git From Bits Up](https://www.youtube.com/watch?v=MYP56QJpDr4)
- [Linus Torvalds (inventor of Linux and Git) on Git](https://www.youtube.com/watch?v=4XpnKHJAok8)

## Installing Recommended Visual Studio Code Extensions

When you first open the Paradise repository in Visual Studio Code, you will also
get a notification to install some recommended extensions. These plugins are
extremely useful for programming with BYOND and should be considered essential.
If you don't see the prompt to install the recommended extensions, they can be
installed from the list below.

- [DreamMaker Syntax Highlighting](https://marketplace.visualstudio.com/items?itemName=gbasood.byond-dm-language-support)
- [BYOND Language Support](https://marketplace.visualstudio.com/items?itemName=platymuus.dm-langclient)
- [EditorConfig](https://marketplace.visualstudio.com/items?itemName=EditorConfig.EditorConfig)
- [ESLint](https://marketplace.visualstudio.com/items?itemName=dbaeumer.vscode-eslint)
- [GitLens](https://marketplace.visualstudio.com/items?itemName=eamodio.gitlens)
- [ErrorLens](https://marketplace.visualstudio.com/items?itemName=usernamehw.errorlens)
- [DreamMaker Icon Editor](https://marketplace.visualstudio.com/items?itemName=anturk.dmi-editor)
- [Prettier Code Formatter](https://marketplace.visualstudio.com/items?itemName=esbenp.prettier-vscode)
- [ZipFS](https://marketplace.visualstudio.com/items?itemName=arcanis.vscode-zipfs)

## Installation for Linux Users

The code is fully able to run on Linux, however Windows is still the recommended
platform. The libraries we use for external functions (rust-g and MILLA) require
some extra dependencies.

### Building rust-g for Debian-based Distributions

1. Download the latest release from <https://github.com/ParadiseSS13/rust-g>
2. Run the following command:
```sh
apt-get install libssl-dev:i386 pkg-config:i386 zlib1g-dev:i386
```
3. After installing these packages, rust-g should be able to build and function
   as intended. Build instructions are on the rust-g GitHub. We assume that if
   you are hosting on Linux, you know what you are doing.
4. Once you've built rust-g, you can build MILLA similarly. Change into the
   `milla/` directory and run:
```sh
cargo build --release --target=i686-unknown-linux-gnu
```
