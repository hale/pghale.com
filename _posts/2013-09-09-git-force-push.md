---
layout: post
title: It's okay to git push -f
category: posts
description: In most situations, git push -f is fine.
---

When people first start using git, they usually end up running git push -f
because "it won't let me push my changes".  This has led to a kind of
commandment in the popular imagination that you should never force-push your
changes to a remote branch.

It's okay to force-push when:

* You're on a feature branch that nobody else is using, or
* You're on a feature branch and the people who are using it don't mind.

Force-pushing can be dangerous because you might overwrite someone's changes,
but this rarely happens and is nothing some git-fu with the reflog can't sort
out.

The reason to shoot people down for using 'git push -f' is it saves having to
learn git. Force push all your changes and treat git like it's FTP.

If you're force-pushing because of a rebase and your colleagues are happy to
replay their changes on top of the new history, then what's the problem?
