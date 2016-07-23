App.match = App.cable.subscriptions.create "MatchChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    console.log data
    $('#match-timeline').prepend data.event[0]

    # msg = new SpeechSynthesisUtterance();
    # window.speechSynthesis.onvoiceschanged = ->
    #   voices = window.speechSynthesis.getVoices();
    #   console.log voices
    #   msg.text = data.event[1];
    #   speechSynthesis.speak(msg);
    #   return

  speak: (event) ->
    @perform 'speak', event: event