var initialState = {
    metrics: [{
        ec2_instance_id: "",
        cpu_usage: "",
        disk_usage: "",
        running_processes: []
    }],
}


var clone = function(obj) {
    if (obj === null || typeof (obj) !== 'object') { return obj; }
    let temp = new obj.constructor();
    for (let key in obj) {
        temp[key] = clone(obj[key]);
    }
    return temp;
};

var reducer = function(state, action) {
    switch (action.type) {
        case 'METRIC_RECEIVED':

            var old = state.metrics;
            var newstate = [action.value];
            for(i = 0; i < old.length; i++){
                if (old[i].ec2_instance_id != action.value.ec2_instance_id) {
                    newstate.push(clone(old[i]));
                }
            }
            return {metrics: newstate};
        default: return state;
    }
}

var devTools = window.devToolsExtension ? window.devToolsExtension() : undefined;
window.store = Redux.createStore(reducer, initialState, devTools);

var ProcessComponent = React.createClass({
    render: function(){
        var running_processes = "";
        if (this.props.running_processes.length > 0) {
            running_processes = this.props.running_processes.map(function(running_process){
                return <tr key={"rp-" + running_process.pid}>
                    <td>{running_process.user}</td>
                    <td>{running_process.pid}</td>
                    <td>{running_process.cpu}</td>
                    <td>{running_process.mem}</td>
                    <td>{running_process.command}</td>
                </tr>
            });
        }
        return <table>
            <thead>
            <tr>
                <td>user</td>
                <td>pid</td>
                <td>cpu</td>
                <td>mem</td>
                <td>command</td>
            </tr>
            </thead>
            <tbody>
            {running_processes}
            </tbody>
        </table>
    }
});
var RootComponent = React.createClass({
    render() {
        var {metrics} = this.props;
        var t = metrics.map(function(metric){
            if (metric.ec2_instance_id != ""){
                return <li key={metric.ec2_instance_id}>
                    <h1>Instance Id: {metric.ec2_instance_id}</h1>
                    <h2>CPU Usage: {metric.cpu_usage}%</h2>
                    <h2>Disk Usage: {metric.disk_usage} Gb</h2>
                    <h2>Running Processes:</h2>
                    <ProcessComponent running_processes={metric.running_processes} />
                </li>
            }
        });
        return (<ul>
            {t}
        </ul>);
    }
});


var mapStateToProps = state => ({
    metrics: state.metrics
})
App.metrics = App.cable.subscriptions.create("MetricsChannel", {
    received: function(event){
        var data = event.data;
        store.dispatch({type: 'METRIC_RECEIVED', value: data});
    }
})

window.ConnectedRootComponent = ReactRedux.connect(
    mapStateToProps
)(RootComponent)

ReactDOM.render(
    <ReactRedux.Provider store={store}>
        <ConnectedRootComponent />
    </ReactRedux.Provider>,
    document.getElementById('root')
)