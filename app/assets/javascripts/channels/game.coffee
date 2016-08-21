$(document).on 'turbolinks:load', ->
  if $('body').hasClass('games show')
    roomId = gameId
    App.room = App.cable.subscriptions.create({
      channel: 'GameChannel'
      roomId: roomId
    },
      connected: ->
        console.log 'connected'
      subscribed: ->
        console.log 'subscribed'
      disconnected: ->
      received: (data) ->
        console.log data
        $('#timeline-container').html data.event
    )