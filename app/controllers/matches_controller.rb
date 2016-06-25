class MatchesController < ApplicationController

  def index
    @matches = Match.all
    expires_in 2.minutes, :public => true
  end

  def show
    # @match = Match.find(params[:id])
    # expires_in 2.minutes, :public => true
  end

end
