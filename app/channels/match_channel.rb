# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class MatchChannel < ApplicationCable::Channel
  def subscribed
    stream_from "match_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    Event.create! content: data['event']
  end
end
