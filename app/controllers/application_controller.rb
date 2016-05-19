class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_filter :get_revision

  private
  def get_revision
    if defined? $g
      @revision = $g.log[0]
    end
  end
  
end
