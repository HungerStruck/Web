$(document).on 'turbolinks:load', ->
  if $('body').hasClass('games show')
    roomId = gameId
    App.room = App.cable.subscriptions.create({
      channel: 'GameChannel'
      roomId: roomId
    },
      connected: ->
      disconnected: ->
      received: (data) ->
        console.log data
        $('#game-timeline').prepend data.event
    )