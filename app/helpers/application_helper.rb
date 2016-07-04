module ApplicationHelper
  def sortable(column, title=nil)
    title ||= column.titleize
    direction = column.downcase == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to title, request.query_parameters.merge(:sort => column.downcase, :direction => direction)
  end

  def active_controller(controller)
    return 'active' if params[:controller] == controller
  end

  def active_by_param_match(param, target, default = false, css = "active")
    if params[param] == target or !params[param] && default
        return css
    end
  end

  def user_tooltip_element(username, link, strong)
    user = User.where(username: username)

    start = ""
    if strong == true && link == false
      start = '%strong{ '
    elsif strong == true && link == true
      start = '%a.text-bold{ href: "/p/' + username + '", '
    elsif strong == false && link == false
      start = '%span{ '
    else
      start = '%a{ href: "/p/' + username + '", '
    end

    if user.length > 0
      userData = user.first
      kills = userData.kills
      deaths = userData.deaths
      rank = '??'
      background = userData.background_image

      snippet = ""

      haml = start + '"data-toggle" => "popover", "title" => "' + username + '", "data-placement" => "top", "data-content" => "player_tooltip", "data-kills" => "' + kills.to_s + '", "data-deaths" => "' + deaths.to_s + '", "data-rank" => "' + rank.to_s + '", "data-bg" => "' + background.to_s + '"} ' + username
    else
      haml = start + '} ' + username
    end
    snippet = Haml::Engine.new(haml)
    return snippet.render
  end

  def user_avatar(username, size)
    haml = '%img.avatar{src: "https://mcapi.ca/avatar/2d/' + username + '/' + size.to_s + '"}'
    snippet = Haml::Engine.new(haml)
    return snippet.render
  end

  def title(page_title)
    content_for :title, "HungerStruck » #{page_title.to_s}"
  end
end
