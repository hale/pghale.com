---
layout: post
title: SRP applied to git workflows
category: posts
description: Using feature-branches and pull requests for a better commit history
published: false
---

GitHub's pull-requests are so good because they really hammer home the idea of a
branch being an isolated piece of work which review and apply to your code.

This encourages you to monitor the scope of each change during development, and
how far-reaching the changes are.

The big win with isolated chunks of work is it allows you to change direction.
You never really know how a piece of work is going to shape up until it's being
written, and being able to redefine your objectives at will is hugely
beneficial. You know when you're getting in a mess, or when you're drifting from
requirements.

Github is great because it gives you a nice big title and an easily formatted
description box to explain the requirements and what it should do.  If there's a
mismatch between the title and the commits, or if the title is vague and
far-reaching, it's like a canary down a mineshaft.

## Rewriting history

Achieving these goals requires thinking about git a little differently.  When
you're in a feature branch, as far as I'm concerned Anything Goes.

* If you spot two similar commits, reorder so they're next to each other and
squash.
* If a commit message isn't any good, go back and change it.
* If some commits don't belong here, remove them and put them elsewhere.

Git is a time machine, not a canonical record of your activity.



* The first line of a commit message encapsulates the change

You shoudln't have to look at the long description (or worse, the diff) in order
to know what the commit changes.  

* SRP applies to commit messagesEqually this means don't sneak in other
changes in the commit!  Better to have an extra commit with a single line change
than a commit that's doing too many things

## Real world example

The screenshot above shows something I'm working on at the moment with Honolulu
Answers: 

> Articles have multiple versions so that changes can be made without
> unpublishing the article.

If you look closely at the commit history, it becomes apparent that things
started to go wrong.  First the #preview functionality broke, then we're messing
with authorization, and then slugs too.

This isn't too surprising - breaking the expectation that Article#find returns
the article we want to show is bound to have knock-on effects.

It's worth asking what you would like a branch called `47-article-versioning` to
look like.  I wouldn't expect much more than the first few commits - integrate
the library, tweak it to our needs, and at some point during this work on the UI
to support the new functionality.

I don't want to add versioning, modify behaviour of slugs, adjust authorixation,
change the implementation of preview and refactor the articles controllers all
in one go.

    ### Aside

    You probably noticed my branches and commit messages are prefixed by a number,
    in this case 47.  This number refers to a Trello card ID on a board used to
    manage the lifecycle of bugs and feature requests.

At this point I took a step back and fleshed out the requirements in a spec.
There were too many open questions about how we wanted this to behave - how much
versioning we really needed - and I wanted to check back in with the other
stakeholders.

Once I had a better idea of what was required, I could begin to think about how
it might be implemented.  A common pattern is you identify the high level
behaviour, and then infer the implicated changes which must be made to support
it.

A great practice now is to flip it on it's head.  Rather than add the window
dressing and then build the house, build the house first.

47-article-versioning becomes a mothership story, spawning smaller stories which
are required before this can go in.

The great thing about this is you can get code written, tested and in production
- sort of like saying "bank" in the weakest link.

Now we have a new branch with a much narrower focus, that takes some emphasis
off this.

    64-article-status-separate-fields

    Articles should have three flags for their status rather than one status field.
    This allows us to say an article is both Published and Draft.








