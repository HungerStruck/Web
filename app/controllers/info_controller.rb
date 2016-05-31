class InfoController < ApplicationController
  def index
    expires_in 90.seconds, :public => true
  end
end
