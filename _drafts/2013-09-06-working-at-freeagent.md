---
layout: post
title: Working at Freeagent
category: posts
---

This summer I left [the silver city][aberdeen] to work for
[FreeAgent][freeagent], makers of online accountancy software in Edinburgh.

I was working with one other intern, and our first project was to add
[Stripe][stripe] integration for paying invoices.  There was already a structure
for other payment processors so this was easy - just copy the patterns elsewhere
and we're done!

....Or not.  After years of minimal feedback, someone was looking at my code.
And it sucked (kinda).

## Code Review

It's the job of the reviewer to look for mistakes, but also to start a
discussion about particular implementation details. Some feedback I've gotten:

> Does that method really belong here?

> Hm, looks like this is the third time we're doing this.  Maybe something can
> be done to reduce the duplication, like moving these shared methods into an
> included module

> You should really be mocking this object rather than Factory.create()

> That isn't how you spell String

Thoughtbot have a great post about code review [here][code review].

So, it passed review.  Ship it! Ship it! Ship it!

Not so fast. Unfortunately, people actually end up using this stuff by clicking
on buttons and things.  I know right?

## Quality Assurance

There's no dedicated QA team in FreeAgent so it's up to you to find someone to
run through the expected behaviour and try and break it.

When you're responsible for finding someone to review or test your code, don't you
end up wasting time pinging people to see if they're free?

Yes.  But I think it's worth it.

### 1. You are responsible for your branch from inception to deployment

If you ask someone to test something for you and it breaks because of something
simple, you've wasted their time and by extension yours.  If you put your code
in some black-box that comes back pass/fail, the temptation is to treat it like
a compiler and waste everyones time catching simple mistakes.

### 2. Developers get to see other parts of the application

In my time as an intern I worked on two projects, which each touched a different
parts of the app.  When QAing other people's branches , I touched on the
tax engine, payroll, VAT returns and a bunch of other things I've now forgotten.

---

Despite being interns, every effort was made to make us feel like equal members
of the engineering team.  Our code was held to the same standards, we had
similar responsibilities and we were working on live projects under active use.

I had some concerns that we would be working on something periphery and safe
which would then be either merged or scrapped at the end of summer as they saw
fit. This couldn't be further from the truth.

And I'm sure if it was one of our birthdays we would have gotten an awesome
cake, too...

![FreeAgent Birthday Cake](/images/freeagent_cake.jpg)

So thanks to everyone at FreeAgent for an amazing summer, it was a pleasure
working with all of you. Looking forward to v0.1 of the snozcumber gem ;)

[stripe]: https://stripe.com/
[freeagent]: http://www.freeagent.com/
[aberdeen]: https://encrypted.google.com/search?q=about+aberdeen+scotland
[code review]: https://github.com/thoughtbot/guides/tree/master/code-review
