class EventRelayJob < ApplicationJob
  queue_as :default

  # def perform(event)
  #   ActionCable.server.broadcast "matches:#{event.match_id}:events",
  #     event: CommentsController.render(partial: 'events/event', locals: { event: event })
  # end

  def perform(event)
    ActionCable.server.broadcast 'match_channel_' + event.match_id, event: render_event(event)
  end

  private
    def render_event(event)
      ApplicationController.renderer.render(partial: 'events/event', locals: { event: event })
    end
end
