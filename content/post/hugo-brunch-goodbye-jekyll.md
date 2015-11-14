---
date: "2015-11-10T23:25:20Z"
title: "hugo + brunch: goodbye jekyll"

---

My search for a better static site generator started when I sought help with asset minification in
Jekyll and all the results were from 2012.

I expect to be able to write Coffescript, HAML and SCSS etc. and have the build tool compile and
minify this as simply as `rake assets:precompile`.

With that in mind I decided to expand my horizons a little and reimplement this site using a
newer set of tools.

## hugo

I was attracted to Hugo because of its great documentation and large selection of well designed
sites in the showcase.

I also love how it uses context and convention over configuration.  To get started you need only
install a theme and write content in markdown.  Then you can ease into customizing the layouts by
adding snippets of content that override the theme defaults.

It's easier to see than explain, so I'll leave it at that and encourage you to read the
documentation for more details.

One problem: [Hugo doesn't minify assets or support SCSS/Coffescript][hugo_preprocessors].

The solution offered in the support ticket is to "bring your own build tool". Leaving aside whether
this a good move for the project, the idea does appeal to me. "Do one thing, and do it well".

## brunch

Brunch is one of many "`make`for the web" tools floating around (if you thought indie band names
were ridiculous...). They are all basically the same:

1. Include CSS, JS packages (bootstrap, jquery);
2. Compile sugar languages like Coffescript and SCSS;
3. Compact and concatenate CSS and JS and
4. Image optimization.

I have some unfavourable experience using Grunt, and Gulp didn't look much better. Brunch has been
around for a while, also has excellent documentation and favours convention over configuration.

It was surprisingly easy to make Brunch work with Hugo. Understanding how they all play together
does have a learning curve, but there is almost no configuration or customization which is a very
good sign: as both projects mature they should continue to work together.

## hugo + brunch

Here's how it works:

Hugo manages your content. Its job is to render HTML using themes, layouts and content. You give it
assets, layouts and markdown and it spits out a folder ready to upload and serve.

Brunch manages your assets. Its job is to turn your styles, javascript and static assets into
web-optimized compiled versions ready to be served. You give it SCSS, Coffescript and assorted
binary files and it spits out a folder of compiled files.

We will daisy chain them together like so.

Write your HTML and Markdown according to Hugo defaults. Instead of putting your static files in
'static' though, we will put them somewhere else and let Brunch output to 'static'. All Hugo will do
to static is copy the files, so this is safe.

Assets instead should be places in a new folder called `app`, which in accordance with Brunch
recommendations should look something like this:

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

(See also: [this part of the Brunch guide][just_a_couple_files].)

## content creation

1. By convention `app/assets` will get copied without processing, so put things here like images,
   favicon.ico, CNAME.

2. Remove any reference to libraries like Bootstrap, jQuery from your HTML templates and install
   these with Bower. `bower install --save jquery`

3. Tell Brunch to compile into `static` so that your assets are picked up by Hugo:

    ```coffee
    # brunch-config.coffee
    module.exports = config:
      paths:
        public: 'static'
      files:
        javascripts: joinTo: 'app.js'
        stylesheets: joinTo: 'app.css'
    ```

4. Create content with `hugo new post/post-title`

## deployment

For development, run `brunch watch` and `hugo server -w --buildDrafts` in separate windows.  As you
edit files in `app`, Brunch spits them into `static` and Hugo copies the output into `public`.

To deploy:

```bash
brunch build
hugo
rsync -chavz --delete --stats public/ username@sever.com:/home/public/
```

And that's it!

![brunch hugo server](/images/hugo_brunch_server.png)


## closing thoughts

I suspect this is a very Rails-y way of thinking. In my view, that the locations of files inform how
they are processed isn't magical or brittle. This way of thinking ensures alignment between what we
see on disk and what we see in the address bar.

It will be interesting to see how static site generators mature.  I suspect we will be waiting for
advancements in browser standards before they really come into their own.

[hugo_preprocessors]: http://discuss.gohugo.io/t/support-for-html-css-js-preprocessors/127/11
[techpeace]: https://github.com/techpeace
[just_a_couple_files]: https://github.com/brunch/brunch-guide/blob/master/content/en/chapter04-starting-from-scratch.md#just-a-couple-files
