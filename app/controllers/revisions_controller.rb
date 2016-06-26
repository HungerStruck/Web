class RevisionsController < ApplicationController
  before_action :get_web_repos

  def index
  end

  private
  def get_web_repos
    @webcommits = $g.log
  end
end
