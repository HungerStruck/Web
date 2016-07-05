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

    @kaminari_stats_users = Kaminari.paginate_array(@stats_users).page(stats_params[:page])
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
    params.permit(:sort, :period, :direction, :page)
  end

  def initialize_user_redis_stats(user)
    $redis.hmset("cache:stats_users:#{user.uuid}", "username", user.username, "kills", user.kills, "deaths", user.deaths, "wins", user.wins, "losses", user.losses)
    $redis.hmset("cache:stats_users:#{user.uuid}", "username", user.username, "kills_week", user.kills, "deaths_week", user.deaths, "wins_week", user.wins, "losses_week", user.losses)
    $redis.hmset("cache:stats_users:#{user.uuid}", "username", user.username, "kills_today", user.kills, "deaths_today", user.deaths, "wins_today", user.wins, "losses_today", user.losses)
  end

  def get_stats_or_insert(period, sort)
    ret_val = Array.new

    $redis.scan_each(match: "cache:stats_users:*") do |resume_key_name|
        user_hash = $redis.hgetall(resume_key_name).to_h
        if user_hash["kills_#{period}"]
          user_hash["kills"] = user_hash.delete "kills_#{period}"
          user_hash["deaths"] = user_hash.delete "deaths_#{period}"
          user_hash["wins"] = user_hash.delete "wins_#{period}"
          user_hash["losses"] = user_hash.delete "losses_#{period}"
        end

        # Non redis cached, but avoid doing math in the view
        user_hash["kd"] = (user_hash["kills"].to_f / user_hash["deaths"].to_i).round(2)
        user_hash["wl"] = (user_hash["wins"].to_f / user_hash["losses"].to_i).round(2)

        ret_val.push(user_hash)
    end

    if ret_val.empty? # Likely will not happen on prod server because the DB plugin will insert records and thus ret_val will NOT be empty. In the case it is, every user will be dumped into redis.
      User.all.each do |user|
        initialize_user_redis_stats(user)
      end
    end

    ret_val.sort_by! { |hash| hash[sort].to_i }.reverse!
    if sort_direction == "asc"
      ret_val.reverse!
    end

    return ret_val
  end

end
