# gulp-react-render
# https://github.com/alexander/gulp-react-render

# Copyright (c) 2015 AlexMost
# Licensed under the MIT license.

gulp_react_render = require '../tasks/gulp_react_render'
gulp = require 'gulp'
cheerio = require 'cheerio'


exports.test_component_render = (test) ->
    gulp.src('./test/fixtures/render1comp.html')
    .pipe(gulp_react_render())
    .on('data', (result) ->

        $ = cheerio.load result.contents.toString()

        test.ok(
            $('#comp1').length is 1
            "React component1 must be rendered"
        )

        test.ok(
            $('#comp2').length is 1
            "React component2 must b rendered"
        )
        
        test.ok(
            $('#comp1').text() is 'testDiv p1=val1'
            "React component1 props must be rendered"
        )
            
        test.done()
    )
