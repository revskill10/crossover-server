App.metrics = App.cable.subscriptions.create "MetricsChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (event) ->
    data = event.data
    console.log "Test"
    store.dispatch(metrics_received_action(data))


