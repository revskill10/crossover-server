var ProcessComponent = React.createClass({
    render: function(){
        var running_processes = this.props.running_processes.map(function(running_process){
            return <tr>
                <td>{running_process.user}</td>
                <td>{running_process.pid}</td>
                <td>{running_process.cpu}</td>
                <td>{running_process.mem}</td>
                <td>{running_process.command}</td>
            </tr>
        });
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