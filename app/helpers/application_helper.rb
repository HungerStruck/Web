module ApplicationHelper
  def active_controller(controller)
    if(params[:controller] == controller)
      return 'active'
    end
  end
end
