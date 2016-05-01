var ConfigComponent = React.createClass({
    onClick: function(){
        this.props.onUpdateThreshold(this.refs.threshold.value);
    },
    onChange: function(){
        this.props.onUpdateThreshold(this.refs.threshold.value);
    },
    render: function() {
        return <div>
            <input ref="threshold" onChange={this.onChange} value={this.props.threshold}></input>
            <button onClick={this.onClick}>Update</button>
        </div>;
    }
});

window.ConfigComponent = ConfigComponent;