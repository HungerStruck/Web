module ApplicationHelper
  def active_controller(controller)
    return 'active' if params[:controller] == controller
  end

  def user_tooltip_element(username, link, strong)
    # Needs to get these values from database
    kills = 50
    deaths = 40
    rank = 30
    background = 1

    snippet = ""
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
    
    haml = start + '"data-toggle" => "popover", "title" => "' + username + '", "data-placement" => "top", "data-content" => "player_tooltip", "data-kills" => "' + kills.to_s + '", "data-deaths" => "' + deaths.to_s + '", "data-rank" => "' + rank.to_s + '", "data-bg" => "' + background.to_s + '"} ' + username
    snippet = Haml::Engine.new(haml)
    return snippet.render
  end
end
