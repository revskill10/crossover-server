var ConfigComponent = React.createClass({
    getInitialState: function(){
      return {threshold: 100}
    },
    onClick: function(){
        console.log(this.refs.threshold.value);
        this.setState({threshold: this.refs.threshold.value});
        App.config.update(this.refs.threshold.value);
    },
    onChange: function(event){
        this.setState({threshold: event.target.value});
    },
    render: function() {
        return <div>
            <input ref="threshold" onChange={this.onChange} value={this.state.threshold}></input>
            <button onClick={this.onClick}>Update</button>
        </div>;
    }
});


