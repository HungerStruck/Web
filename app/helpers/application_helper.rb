module ApplicationHelper
  def active_controller(controller)
    return 'active' if params[:controller] == controller
  end
end
