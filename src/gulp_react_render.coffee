# gulp-react-render
# https://github.com/alexander/gulp-react-render

# Copyright (c) 2015 AlexMost
# Licensed under the MIT license.

path = require 'path'
through = require 'through2'
cheerio = require 'cheerio'
React = require 'react'
gutil = require 'gutil'

PluginError = gutil.PluginError

renderComponent = (componentPath, componentProps) ->
    component = require componentPath    
    props = componentProps or {}
    React.renderToString(React.createElement(component, props))


module.exports = ->
    transform = (file, enc, cb) ->
        if file.isStream()
            return cb(new PluginError(
                'gup-react-render', 'Streaming is not supported'))

        $ = cheerio.load file.contents.toString('utf8')
    
        basedir = process.cwd()

        $('*[data-rcomp]').each (index, comp) ->
            comp_path = path.resolve(basedir, $(comp).data().rcomp)
            $(comp).html(renderComponent(
                comp_path, $(comp).data().rprop))

        file.contents = new Buffer $.html()

        cb null, file

    through.obj transform
