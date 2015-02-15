[![Build Status](https://travis-ci.org/AlexMost/abs.js.svg?branch=master)](https://travis-ci.org/AlexMost/gulp-react-render)
# gulp-react-render
Gulp plugin for rendering reactjs components in existing markup

## Installation
```
npm install gulp-react-render
```

## Usage
```javascript
var react_render = require('gulp-react-render');

gulp.task('prerender', function() {
  gulp.src('./src/*.html')
    .pipe(react_render())
    .pipe(gulp.dest('./public/'))
});
```

## Overview

Lets assume you creating some static site with html pages and have some react component:


```js
//path - ./component/component1.js
React = require('react');

Comp1 = React.createClass({
    render: function(){
        return React.DOM.div({id: "comp1", className: "test"}, "testDiv")
    }
});

module.exports = Comp1
```


Here is our source markup:

```html
<!DOCTYPE html>
<html lang="en">
    <head></head>
    <body>
      <h1>Header ...</h1>
      <!-- placing path to component file in data-rcomp attribute -->
      <div data-rcomp="./component/component1.js" id="container"></div>
      <script type="javascript">
        //some init logic
      </script>
    </body>
</html>
```

After processing we will recieve:
```html
<!DOCTYPE html>
<html lang="en">
    <head></head>
    <body>
      <h1>Header ...</h1>
      <!-- placing path to component file in data-rcomp attribute -->
      <div data-rcomp="./component/component1.js" id="container">
      <div id="comp1" class="test" data-reactid=".1vufboq169s" data-react-checksum="1034950555">testDiv</div>
      </div>
      <script type="javascript">
        //some init logic
      </script>
    </body>
</html>
```

So, as you may understood this plugin will iterate through all over the components and will call React.renderComponentToString for each component.

### Using props

You can pass props to React object adding json to the data-rprop attribute, exe:

```html
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
    </head>
    <body>
        <div class="container">
            <div data-rcomp="./test/fixtures/comp1" data-rprop="{&quot;p1&quot;:&quot;val1&quot;}" id="container"></div>            
        </div>
</body></html>
```

Rember to encode HTML special chars.


