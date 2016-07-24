$(document).on 'turbolinks:load', ->
  if $('body').hasClass('matches show')
    roomId = '5794d72ab392e86326670900'
    App.room = App.cable.subscriptions.create({
      channel: 'MatchChannel'
      roomId: roomId
    },
      connected: ->
      disconnected: ->
      received: (data) ->
        console.log data
        $('#match-timeline').prepend data.event[0]
    )