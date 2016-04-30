App.config = App.cable.subscriptions.create "ConfigChannel",
  connected: ->
    # Called when the subscription is ready for use on the server
    elem = React.createElement(ConfigComponent)
    ReactDOM.render(elem, document.getElementById("config"))

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel
    console.log data


  update: ->
    @perform 'update'
