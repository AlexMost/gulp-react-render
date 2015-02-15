React = require('react');

Comp1 = React.createClass({
    render: function(){
    	var span = React.createFactory('span');
        return span({id: "comp2", className: "test2"}, "testSpan")
    }
});

module.exports = Comp1