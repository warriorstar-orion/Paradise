First, let's talk about **branches**. First thing to do is to make a new
branch on your fork. This is important because you should never make
changes to the default(master) branch of your fork. It should remain as
a clean copy of the main ParadiseSS13 github.

**For every PR you make, make a new branch.** This way, each of your
individual projects have their own branch. A commit you make to one
branch will not affect the other branches, so you can work on multiple
projects at once.

### Branching

To make a new branch, open up the source control sidebar. Navigate to
the Branches section and open it. You should only have the master
branch. You can create a new branch by going and clicking on the Create
Branch button.

![](VSCodeBranching.png "VSCodeBranching.png")

It will then prompt you at the top of your screen to name your new
branch, then select Create Branch and Switch. For this guide, I'll be
creating a new hat, so I'll name my branch `hat-landia`. If you look at
the bottom left hand corner, you'll see that VS Code has automatically
checked out our
branch:![](VSCodeBranchExample.png "VSCodeBranchExample.png")\
Remember, **never commit changes to your master branch!** You can work
on any branch as much as you want, as long as you commit the changes to
the proper branch.\
Go wild! Make your code changes! This is a guide on how to contribute,
not what to contribute. So, I won't tell you how to code, make sprites,
or map changes. If you need help, try asking in the `#spriting` or the
`#coding_chat` Discord channels.

### Changing Code

You'll find your code to edit in the Explorer sidebar of VS Code; if you
need to find something, the Search sidebar is just below that.\

    Old-school style: If you want to use DreamMaker instead, go ahead and edit your files there - once you save them, VS Code will detect what you’ve done and you’ll be able to follow the guide from there.

If you do anything mapping related, it is highly recommended you use
StrongDMM and check out the [Guide to
Mapping](Guide_to_Mapping "wikilink").

Now, save your changes. If we look at the Source Control tab, we'll see
that we have some new changes. Git has found every change you made to
your fork's repo on your computer! Even if you change a single space in
a single line of code, Git will find that change. Just make sure you
save your files.

### Testing Your Code

The easiest way to test your changes is to press **F5**. This compiles
your code, runs the server and connects you to it, as well as
automatically giving you admin permissions. It also starts a debugger
that will let you examine what went wrong when a runtime error happens.
If you want to avoid the debugger press **Ctrl + F5** instead.

If F5 does not automatically start a local server, you might have
installed BYOND on a custom path and VSC did not find it. In this case,
try the following:

1.  Press \"Ctrl - ,\" to open VSC settings.
2.  Type \"DreamMaker\", select \"DreamMaker language client
    configuration\".
3.  Under \"DreamMaker: Byond Path\", add your path to BYOND (for
    example, `D:\Program Files (x86)\BYOND`).
4.  Press OK and close the tab.
5.  Press F5 to run the server.

If that does not work, you can compile it into a dmb file and run it in
Dream Daemon. To do so, select the dmb file, set security to Trusted and
hit GO to run the server. After the server starts you can press the
button above the GO / STOP button (now red) to connect.

Do note that if you compile the game this way, you need to manually make
yourself an admin. For this, you will need to copy everything from
`/config/example` into `/config`. Then you will need to edit the
`/config/config.toml` file by adding a
`{ckey = "Your Name Here", rank = "Hosting Provider"}` line to the
`admin_assignments` list.

![](DreamDaemon.png "DreamDaemon.png")

Be sure to always test not only if your changes work, but also if you
didn't actually break something else that might be related.

### Committing to Your Branch

Hover over the word **Changes** and press the plus sign to stage all
modified files. It should look like this:

![](VSCodeStageChanges.png "VSCodeStageChanges.png")

Or, pick each file you want to change individually. Staged files are the
changes you are going to be submitting in commit, and then in your pull
request. Once you've done that, they'll appear in a new tab called
Staged Changes.

![](VSCodeStagedChanges.png "VSCodeStagedChanges.png")

Click on one of the code files you've changed now! You'll see a compare
of the original file versus your new file pop up. Here you can see, line
by line, every change that you made. Red lines are lines you removed or
changed, and green lines are the lines you added or updated. You can
even stage or unstage individual lines, by using the More Actions
`(...)` menu in the top right.

Now that you've staged your changes, you're ready to make a commit. At
the top of the panel, you'll see the Message section. Type a descriptive
name for you commit, and a description if necessary. Be concise!

Make sure you're checked out on the new branch you created earlier, and
click the checkmark! This will make your commit and add it to your
branch. It should look like this:

![](VSCodeCommit.png "VSCodeCommit.png")

There you go! You have successfully made a commit to your branch. This
is still 'unpublished', and only on your local computer, as indicated by
the little cloud and arrow icon in the bottom left corner.

![](VSCodePublishBranch.png "VSCodePublishBranch.png")

Once you have it committed, you\'ll need to push/publish to your github.
You can do that by pressing the small cloud icon called \"publish
branch\".

### Publishing to GitHub

Go to the [Main repository](https://github.com/ParadiseSS13/Paradise/)
once your branch is published, Github should then prompt you to create a
pull request. This should automatically select the branch you just
published and should look something like this.

![](GithubCreatePR.png "GithubCreatePR.png")

If not, you\'ll need to open a Pull Request manually. You\'ll need to
select \`compare across forks\`, then select the upstream repo and
target the master branch.

Then, you'll be able to select the title of your PR. The extension will
make your PR with your selected title and a default description.
**BEFORE SUBMITTING:** ensure that you have properly created your PR
summary and followed the description template.

A note on changelogs. Changelogs should be player focused, meaning they
should be understandable and applicable to your general player. keep it
simple,

    fix: fixed a bug with X when you Y
    tweak: buffed X to do Y more damage.

Avoid coding lingo heavy changelogs and internal code changes that
don\'t visibly affect player gameplay. These are all examples of what
you shouldn\'t add:

    tweak: added the NO_DROP flag to X item.
    tweak: refactored DNA to be more CPU friendly

ShareX is a super useful tool for contributing as it allows you to make
gifs to display your changes. you can download it,
[here](https://getsharex.com/)

if all goes well, your PR should look like this:

![](ExamplePR.png "ExamplePR.png"){width="600"}

If you want to add more commits to your PR, all you need to do is just
push those commits to the branch.

</div>
<div class="toccolours mw-collapsible" style="width:99%">
