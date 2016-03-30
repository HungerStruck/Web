class RevisionsController < ApplicationController
  before_filter :get_web_repos

  def index
  end

  private
  def get_web_repos
    @webcommits = $github.repos.commits.all 'HungerStruck', 'Web'
  end
end
