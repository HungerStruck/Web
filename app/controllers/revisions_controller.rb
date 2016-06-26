class RevisionsController < ApplicationController
  before_action :get_web_repos

  def index
  end

  private
  def get_web_repos
    commits = $github.repos.commits.all 'HungerStruck', 'Web'
    @webcommits = commits.select do |c|
      c.commit.message !~ /Merge/ && c.commit.message !~ /\[HIDE\]/
    end
  end

end
