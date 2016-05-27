var PluginError, React, ReactDOMServer, cheerio, gutil, path, renderComponent, through;

path = require('path');

through = require('through2');

cheerio = require('cheerio');

React = require('react');

ReactDOMServer = require('react-dom/server');

gutil = require('gutil');

PluginError = gutil.PluginError;

renderComponent = function(componentPath, componentProps) {
  var component, element, props;
  component = require(componentPath);
  props = componentProps || {};
  element = React.createElement(component, props);
  return ReactDOMServer.renderToString(element);
};

module.exports = function() {
  var transform;
  transform = function(file, enc, cb) {
    var $, basedir;
    if (file.isStream()) {
      return cb(new PluginError('gup-react-render', 'Streaming is not supported'));
    }
    $ = cheerio.load(file.contents.toString('utf8'));
    basedir = process.cwd();
    $('*[data-rcomp]').each(function(index, comp) {
      var comp_path, prop_json, props;
      comp_path = path.resolve(basedir, $(comp).data().rcomp);
      prop_json = $(comp).data().rpropfile;
      if (prop_json) {
        props = require(path.resolve(basedir, prop_json));
      } else {
        props = $(comp).data().rprop;
      }
      return $(comp).html(renderComponent(comp_path, props));
    });
    file.contents = new Buffer($.html());
    return cb(null, file);
  };
  return through.obj(transform);
};
