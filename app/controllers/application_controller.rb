
class ApplicationController < ActionController::Base
  before_filter :get_revision

  def mongoid_forums_user
    current_user
  end
  helper_method :mongoid_forums_user
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end

  private
  def get_revision
    if defined? $g
      @revision = $g.log[0]
    end
  end

end
