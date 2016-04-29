App.metrics = App.cable.subscriptions.create "MetricsChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    console.log data
    $("#metrics").text(JSON.stringify(data.data))
    # Called when there's incoming data on the websocket for this channel
