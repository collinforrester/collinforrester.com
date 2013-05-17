---
layout: post
title: grunt-explainjs, First grunt plugin
tags: [javascript,gruntjs,explainjs]
date: '2013-05-15'
---

About two weeks ago [btford](https://twitter.com/briantford) tweeted about an [npm](http://npmjs.org) package called [ExplainJS](http://www.explainjs.com) by [bendytree](https://twitter.com/bendytree).  Looking into it some I found that it proved to be really useful for a couple of reasons.  One, it encourages you to have legitimate comments that actually explain and contribute to your code.  Two, it is super easy to use and outputs a really nice look page of annotated source code (similar to how you may have seen the [BackboneJS](http://backbonejs.org/docs/backbone.html) source code).

## Getting started
Actually getting started with the plugin was super easy.  Over on the [GruntJS](http://gruntjs.com) website, they have a great [guide](http://gruntjs.com/creating-plugins) for creating your own plugins.  The following, shamelessly stolen from the grunt website, is how it's done in 6 steps:

1. Install grunt-init with `npm install -g grunt-init`
2. Install the gruntplugin template with `git clone git://github.com/gruntjs/grunt-init-gruntplugin.git ~/.grunt-init/gruntplugin`
3. Run `grunt-init gruntplugin` in an empty directory.
4. Run `npm install` to prepare the development environment.
5. Author your plugin.
6. Run `npm publish` to publish the grunt plugin to npm!

One thing that wasn't completely obvious to me is that the plugin tests are already set up with grunt and all you need to run is `grunt test`.  For some reason when I looked at the test, I thought it was going to be more work to set them up.  So I've neglected to included them in this first releast.  But hey, that's what 0.0.1 releases are for.

## What It Does
You can get a full explanation [here](http://www.explainjs.com/).  But long story short, it parses your source code and formats your comments (block and inline) to side-by-side with your code.  Here's an [example](http://www.explainjs.com/explain?src=http://ajax.googleapis.com/ajax/libs/angularjs/1.0.6/angular.js) of ExplainJS ran on the [AngularJS](http://angularjs.org) source code.

The grunt plugin takes all that great functionality and wraps it in the build process that you know and love.  It uses the standard grunt file/src format that you're used to also.

```js
grunt.initConfig({
  explainjs: {
    files: {
      'dist/explainjs/explain.html': ['dist/scripts/scripts.js'],
    },
  },
})
```
If you're using [yeoman](http://yeoman.io) (which you should be) to scaffold your stuff, a good spot to put your explainjs task is after concatenation but before minification.

```js
grunt.registerTask('build', [
  'clean:dist',
  'jshint',
  'test',
  'compass:dist',
  'useminPrepare',
  'imagemin',
  'cssmin',
  'htmlmin',
  'concat', // concat files here, gives me dist/scripts/scripts.js (not minified)
  'explainjs', // explain here
  'copy',
  'usemin',
  'ngmin',
  'uglify'
]);
```

## What's Left
* I've completely neglected the unit tests as I was writing this.  Mostly due to the fact that at first I didn't realize that grunt-init-gruntplugin included the unit tests already working and set up.  I need to get test coverage.
* Look into what other options would be nice.  Currently it only supports toggling the file name on or off in the generated file.
* Support multiple source files that output to the corresponding destination specified in the `dest` property.

Overall the grunt community makes it extremely easy to contribute and add to the already amazing plugin repository.  Getting an initial plugin set up and scaffolded was painless.  It felt good contribute back to an open source project and I would/will do it again when I get a chance.