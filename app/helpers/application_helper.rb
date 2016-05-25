module ApplicationHelper
  def active_controller(controller)
    return 'active' if params[:controller] == controller
  end
  def title(page_title)
    content_for :title, "HungerStruck » #{page_title.to_s}"
  end
  def bootstrap_class_for flash_type
      { success: "alert-success", error: "alert-error", alert: "alert-warning", notice: "alert-info" }[flash_type.to_sym] || flash_type.to_s
  end
end
