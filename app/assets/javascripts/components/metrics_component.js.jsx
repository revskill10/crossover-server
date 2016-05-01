var MetricComponent = React.createClass({
  render: function() {
    return <li>
      <h1>Instance Id: {this.props.ec2_instance_id}</h1>
      <h2>CPU Usage: {this.props.cpu_usage}%</h2>
      <h2>Disk Usage: {this.props.disk_usage} Gb</h2>
      <h2>Running Processes</h2>
      <ProcessComponent running_processes={this.props.running_processes} />
      </li>;
  }
});
var MetricsComponent = React.createClass({
  render: function(){
    var metrics = this.props.metrics.map(function(metric){
      return <MetricComponent key={"eii-" + metric.ec2_instance_id} ec2_instance_id={metric.ec2_instance_id} cpu_usage={metric.cpu_usage} disk_usage={metric.disk_usage}
                              running_processes={metric.running_processes} />
    })
    return (<ul>
          {metrics}
      </ul>

    )

  }
});
window.MetricsComponent = MetricsComponent;


