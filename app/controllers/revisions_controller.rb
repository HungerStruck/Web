class RevisionsController < ApplicationController
  before_action :get_web_repos

  def index
  end

  private
  def get_web_repos
    items = ($g.log).to_a
    items.delete_if { |c| c.message.start_with?('Merge', '[HIDE]')}
    @webcommits = Kaminari.paginate_array(items, total_count: items.count).page(params[:page]).per(10)
  end
end
