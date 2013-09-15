---
layout: post
title: Git shortcuts
category: posts
description: Change your workflow with easily repeatable git aliases.
published: false
---

Working in feature branches keeps you focussed on what you're doing and makes it
easier for your changes to be reviewed and tested.

Therefore, when thinking about development practices as you're righting code
it's instructive to consider the stage when you're ready to merge in your branch
and work back from there.

---

I find it's quite difficult to say in advance "I'm going to make these changes
and then stop and commit".  Typically, you follow a certain path not knowing
where it will take you.

So it's crucial to frequently check your unstaged changes as you are writing
code, so you can spot when you're going off track (what to do when you realise
this is a topic for another post).

I have the following aliases:

### `g`

    git status -sb

![alias g='...'](/images/git_alias_g.png)

The most used git command, and the shorter form gives you the same info using
less space.

### `gd` and `gdc`

`git diff` for seeing the diff and `git diff --cached` to see which changes
you've staged (added).

When I have the screen space, the diff is run in a clearing iTerm pane each time a
file change is detected:

    kicker -c -e "git diff --color" .

(Kicker is a platform-independent gem to monitor filechanges)

### `glg`

![alias glg='...'](/images/glg_good.png)

`glg` is the second most frequent command I use. It is aliased to:

    git log --graph --pretty=format:'%Cred%h%Creset %an: %s - %Creset %C(yellow)%d%Creset %Cgreen(%cr)%Creset' --abbrev-commit --date=relative master..HEAD

    # without colours
    git log --graph --pretty=format:'%h %an: %s - %d (%cr)' --abbrev-commit --date=relative master..HEAD

Of significance is the final argument, which  limits the log to show only
commits made that diverge from master.


