React = require('react');

Comp1 = React.createClass({
    render: function(){
    	var div = React.createFactory('div');
        return div({id: "comp1", className: "test"}, "testDiv p1="+this.props.p1)
    }
});

module.exports = Comp1