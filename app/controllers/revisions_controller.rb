class RevisionsController < ApplicationController
  before_action :get_web_repos

  def index
  end

  private
  def get_web_repos
    @webcommits = Kaminari.paginate_array(($g.log).to_a, total_count: $g.log.count).page(params[:page])
  end
end
