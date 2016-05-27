# gulp-react-render
# https://github.com/alexander/gulp-react-render

# Copyright (c) 2015 AlexMost
# Licensed under the MIT license.
path = require 'path'
through = require 'through2'
cheerio = require 'cheerio'
React = require 'react'
ReactDOMServer = require 'react-dom/server'
gutil = require 'gutil'

PluginError = gutil.PluginError

renderComponent = (componentPath, componentProps) ->
    component = require componentPath    
    props = componentProps or {}
    element = React.createElement(component, props)
    ReactDOMServer.renderToString(element)

module.exports = ->
    transform = (file, enc, cb) ->
        if file.isStream()
            return cb(new PluginError(
                'gup-react-render', 'Streaming is not supported'))

        $ = cheerio.load file.contents.toString('utf8')
    
        basedir = process.cwd()

        $('*[data-rcomp]').each (index, comp) ->
            comp_path = path.resolve(basedir, $(comp).data().rcomp)
            prop_json = $(comp).data().rpropfile
            if (prop_json) 
                props = require(path.resolve(basedir, prop_json))
            else
                props = $(comp).data().rprop
            $(comp).html(renderComponent(
                comp_path, props))

        file.contents = new Buffer $.html()

        cb null, file

    through.obj transform
