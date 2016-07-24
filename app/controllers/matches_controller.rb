class MatchesController < ApplicationController

  def index
    @matches = Match.all
    expires_in 2.minutes, :public => true
  end

  def show
    @match = Match.find(params[:id])
    @events = @match.events.reverse
    # expires_in 2.minutes, :public => true
  end

  def newevent
    Event.create! content: Time.now.to_s, match: Match.find(params[:id])
    render text: Time.now.to_s
  end

end
