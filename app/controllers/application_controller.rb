class ApplicationController < ActionController::Base

  def mongoid_forums_user
    current_user
  end
  helper_method :mongoid_forums_user
  protect_from_forgery with: :exception
end
