class EventRelayJob < ApplicationJob
  queue_as :default
  
  def perform(event)
    puts 'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'
    puts 'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'
    puts 'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'
    puts 'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'
    puts 'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'
    puts 'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'
    puts 'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'
    puts 'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'
    puts 'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'
    puts 'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'
    ActionCable.server.broadcast 'game_channel_' + event.game_id, event: render_event(event)
  end

  private
    def render_event(event)
      ApplicationController.renderer.render(partial: 'events/event', locals: { event: event })
    end
end
