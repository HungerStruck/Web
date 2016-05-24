module ApplicationHelper
  def active_controller(controller)
    return 'active' if params[:controller] == controller
  end
  def title(page_title)
    content_for :title, "HungerStruck » #{page_title.to_s}"
  end
end
