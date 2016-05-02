class MatchesController < ApplicationController

  def index
    @matches = Matches.all
  end

  def show
  end

end
