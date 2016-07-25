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
    Event.create! time: Time.now.to_s, type: 'death', match: Match.find(params[:id]), user: User.find('578bd194b392e821f6cc859c'), killer: User.find('576fc3d8b392e86347bec086')
    render text: Time.now.to_s
  end

end