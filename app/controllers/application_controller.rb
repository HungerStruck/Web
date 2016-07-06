class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :get_revision

  # Make this work before putting the website online
  # def peek_enabled?
  #   current_user.admin?
  # end

  private
  def get_revision
    if defined? $g
      i = 0
      while $g.log[i].message =~ /\[HIDE\]/i or $g.log[i].message =~ /Merge ?:(pull request|branch) #(.*)/
        i += 1
      end
      @revision = $g.log[i]
    end
  end
end
