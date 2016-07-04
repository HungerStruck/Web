class StatsController < ApplicationController
  helper_method :sort_column, :sort_direction, :period

  def index
    @stats_users = case period
      when "today"
        get_stats_or_insert("today", sort_column)
      when "week"
        get_stats_or_insert("week", sort_column)
      when "all"
        get_stats_or_insert("all", sort_column)
      end
  end

  private
  def period
    %w[all today week].include?(params[:period]) ? params[:period] : "all"
  end

  def sort_column
    %w[kills deaths kd wins losses wl].include?(params[:sort])  ? params[:sort]: "kd"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
  end

  def stats_params
    params.permit(:sort, :period, :direction)
  end


  def get_stats_or_insert(period, sort)
    ret_val = Array.new

    $redis.scan_each(match: "cache:stats_users_#{period}:*") do |resume_key_name|
        user_hash = $redis.hgetall(resume_key_name).to_h
        # Non redis cached, but avoid doing math in the view
        user_hash["kd"] = (user_hash["kills"].to_f / user_hash["deaths"].to_i).round(2)
        user_hash["wl"] = (user_hash["wins"].to_f / user_hash["losses"].to_i).round(2)
        ret_val.push(user_hash)
    end

    if ret_val.empty? # Likely will not happen on prod server because the DB plugin will insert records and thus ret_val will NOT be empty. In the case it is, every user will be dumped into redis.
      User.all.each do |user|
        $redis.hmset("cache:stats_users_#{period}:#{user.uuid}", "username", user.username, "kills", user.kills, "deaths", user.deaths, "wins", user.wins, "losses", user.losses)
      end
    end

    ret_val.sort_by! { |hash| hash[sort].to_i }.reverse!
    if sort_direction == "asc"
      ret_val.reverse!
    end

    return ret_val
  end

end
