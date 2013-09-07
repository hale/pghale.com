---
layout: post
title: Working at FreeAgent
category: posts
description: My experience as an engineering intern at FreeAgent, Edinburgh.
---

[![FreeAgent](/images/freeagent_logo.png)][freeagent]

This summer I left [the silver city][aberdeen] to work for
[FreeAgent][freeagent], makers of online accountancy software in Edinburgh.

I was working with one other intern, and our first project was to add
[Stripe][stripe] integration for paying invoices.  There was already a structure
for other payment processors so this was easy - just copy the pattern and we're
done! ...Or not.  After years of minimal feedback, someone was looking at my code.

## Code Review

It's the job of the reviewer to [look for mistakes][code review comic], but
also to start a discussion about your design decisions. Some feedback I've
gotten:

> Does that method really belong here?

> You should really be mocking this object rather than Factory#create

> That isn't how you spell String

It passed review, let's ship it! Not so fast.  Unfortunately, people actually
use this stuff by clicking on buttons and things.  I know right?

## Quality Assurance

There's no dedicated QA team at FreeAgent so it's up to you to find someone to
run through the expected behaviour and try to break it.

At first this felt like a burden, having to wait for other people before you can
get your changes out.  After a while though it became obvious that the best way
to get someone to help you is to help them first. I got to examine parts of the
application I otherwise wouldn't have even known about, and even found a few
patterns which could be used in what I was working on.

## Deploy!

I found someone to deploy, we're done!  Well, not quite.  After your changes hit
production (usually alongside a few other branches that are also complete), it's
time to nervously watch for spikes in [response time][new relic] and any new
[exceptions][honeybadger] and hope you didn't screw up.

Now you're done :).

---

So thanks to everyone at FreeAgent for an amazing summer, it was a pleasure
working with you all.

Despite being interns, every effort was made to make us feel like equal members
of the team.  Our code was held to the same standards, we had similar
responsibilities and we were working on live projects under active use.

And I'm sure if it was one of our birthdays we would have gotten an awesome
cake, too...

[![FreeAgent Birthday Cake](/images/freeagent_cake.jpg)][the bfg]

[stripe]: https://stripe.com/
[freeagent]: http://www.freeagent.com/
[aberdeen]: https://encrypted.google.com/search?q=about+aberdeen+scotland
[code review comic]: http://www.explosm.net/comics/2083/
[code review]: https://github.com/thoughtbot/guides/tree/master/code-review
[new relic]: https://newrelic.com/
[honeybadger]: https://www.honeybadger.io/
[the bfg]: https://en.wikipedia.org/wiki/The_BFG
