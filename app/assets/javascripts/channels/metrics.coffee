App.metrics = App.cable.subscriptions.create "MetricsChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (event) ->
    data = event.data
    elem = React.createElement(MetricsComponent, ec2_instance_id: data.ec2_instance_id, cpu_usage:data.cpu_usage, disk_usage: data.disk_usage, running_processes:data.running_processes)
    if data.ec2_instance_id && ($("#metrics-" + data.ec2_instance_id).length == 0)
      elm = "<div id='metrics-" + data.ec2_instance_id + "'></div>"
      $(elm).appendTo $('#metrics')
      ReactDOM.render(elem, document.getElementById("metrics-#{data.ec2_instance_id}"))
    # Called when there's incoming data on the websocket for this channel
