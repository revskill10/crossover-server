//= require ./process_component
var MetricsComponent = React.createClass({
  render: function() {
    return <div>
      <h1>Instance Id: {this.props.ec2_instance_id}</h1>
      <h2>CPU Usage: {this.props.cpu_usage}%</h2>
      <h2>Disk Usage: {this.props.disk_usage} Gb</h2>
      <h2>Running Processes</h2>
      <ProcessComponent running_processes={this.props.running_processes} />
      </div>;
  }
});


