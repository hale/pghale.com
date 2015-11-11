---
date: "2015-11-10T23:25:20Z"
title: "migrating from jekyll to hugo and brunch"

---

### jekyll-assets

v3.0.0 of Jekyll was released 15 days ago. It's a nice update, but something
didn't feel right.

jekyll-assets brings the asset pipeline (Sprockets) from Rails to your static
site. Great - I wanted to write in coffeescript, HAML, SASS; I want this all to
be compressed and minified before publishing. I'd like this to happen
seamlessly, akin to `rake assets:precompile`.

I couldn't get this to work - and it looks like you have to add extra tags to
your HTML, which is a bit of a chore.

More significantly the web just felt a bit quiet as I searched for help. Lots
of posts from 2012, which was when I first started using Jekyll.

Where did everyone go?

## hugo

I chose `hugo` because I'm not a designer and its theme gallery had the nicest
looking themes `¯\_(ツ)_/¯`.

I also love how it uses context and convention over configuration. Content in
`/posts` automatically looks for templates in `/layouts/posts` and
`/themes/:theme/posts`.

A template is just like a layout file in Rails - and instead of declaring types
everywhere, just put the content where it belongs and Hugo will do the rest.

One problem.

[Hugo doesn't really handle asset minification, CSS/JS preprocessing][hugo_preprocessors].

I'm all-in on the UNIX philosophy of "do one thing and do it well", so
on we go...


## brunch

These kooky names are fine, until:

![brunch images](/images/images_for_brunch.png)

Brunch is one of many "`make`for the web" tools floating around. They are all
basically the same:

1. Include CSS, JS packages into your project (bootstrap, jquery);
2. Convert things like Coffescript and SCSS into JavaScript and CSS;
3. Compact and concatenate everything into 1 or 2 files;
4. Image optimization.

## vim -> brunch -> hugo -> www

Here's how they all play together:

Hugo will render your `/content` using `/templates`, then copy this along
with everything in `/static` into `/public`.

Don't put your assets in `/static`. (In fact, `.gitignore` it)

Instead, put your static assets in a new folder that Hugo doesn't know about.
We will use Brunch to process everything here and spit out the results to
`static`.

Brunch convention is to call this directory `app`.  It should look like this:

```
.
├── app
│   ├── application.js
│   ├── assets
│   │   ├── CNAME
│   │   ├── favicon.ico
│   │   └── images
│   │       ├── arms.jpg
│   │       └── avatar.jpg
│   └── styles
│       └── main.scss
└── package.json
```

More info available in [this part of the Getting Started guide][use_a_couple_files].

By convention `app/assets` will get copied without processing, so put things
here like images, favicon.ico, CNAME.

Remove any reference to libraries like Bootstrap, jQuery from your HTML
templates and install these with Bower. `bower install --save jquery`

One bit of configuration: tell Brunch to compile into `static` so that your
assets are picked up by Hugo:

```
# brunch-config.coffee
module.exports = config:
  paths:
    public: 'static'
  files:
    javascripts: joinTo: 'app.js'
    stylesheets: joinTo: 'app.css'
```

(The `files` argument is the 'minimal configuration')

And that's it!

![brunch hugo server](/images/hugo_brunch_server.png)

As you edit files in `app`, Brunch spits them into `static` and in turn Hugo
copies them to `public`.

There is a learning curve for both these tools, but once it's set up the
workflow is super simple.

[hugo_preprocessors]: http://discuss.gohugo.io/t/support-for-html-css-js-preprocessors/127/11
[techpeace]: https://github.com/techpeace
[just_a_couple_files]: https://github.com/brunch/brunch-guide/blob/master/content/en/chapter04-starting-from-scratch.md#just-a-couple-files
