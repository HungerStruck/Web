module ApplicationHelper
  def active_controller(controller)
    return 'active' if params[:controller] == controller
  end

  def player_tooltip_element(username, link, strong)
    player = Player.where(username: username)

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

    if player.length > 0
      player_data = player.first
      kills = player_data.kills
      deaths = player_data.deaths
      rank = '??'
      background = player_data.background_image

      snippet = ""
      
      haml = start + '"data-toggle" => "popover", "title" => "' + username + '", "data-placement" => "top", "data-content" => "player_tooltip", "data-kills" => "' + kills.to_s + '", "data-deaths" => "' + deaths.to_s + '", "data-rank" => "' + rank.to_s + '", "data-bg" => "' + background.to_s + '"} ' + username
    else
      haml = start + '} ' + username
    end
    snippet = Haml::Engine.new(haml)
    return snippet.render
  end

  def player_avatar_tooltip(username, size)
    player = Player.where(username: username).first
    rank = 0
    haml = '%img.avatar{src: "https://mcapi.ca/avatar/2d/' + username + '/' + size.to_s + '", "data-toggle" => "popover", "title" => "' + username + '", "data-placement" => "top", "data-content" => "player_tooltip", "data-kills" => "' + player.kills.to_s + '", "data-deaths" => "' + player.deaths.to_s + '", "data-rank" => "' + rank.to_s + '", "data-bg" => "' + player.background_image.to_s + '"}'
    snippet = Haml::Engine.new(haml)
    return snippet.render
  end

  def player_avatar(username, size)
    haml = '%img.avatar{src: "https://mcapi.ca/avatar/2d/' + username + '/' + size.to_s + '"}'
    snippet = Haml::Engine.new(haml)
    return snippet.render
  end

  def title(page_title)
    content_for :title, "HungerStruck » #{page_title.to_s}"
  end
  def bootstrap_class_for flash_type
      { success: "alert-success", error: "alert-error", alert: "alert-warning", notice: "alert-info" }[flash_type.to_sym] || flash_type.to_s
  end
end
