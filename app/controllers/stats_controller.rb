class StatsController < ApplicationController

  def index
    puts stats_params
    @stats_users = case  stats_params[:period]
      when "today"    #compare to 1
        get_stats_or_insert("today", stats_params[:sort])
      when "week"    #compare to 2
        get_stats_or_insert("week", stats_params[:sort])
      else
        get_stats_or_insert("all", stats_params[:sort])
      end
  end

  private
  def stats_params
    params.permit(:sort, :period)
  end


  def get_stats_or_insert(period, sort)
    ret_val = Array.new

    $redis.scan_each(match: "cache:stats_users_#{period}:*") do |resume_key_name|
        ret_val.push($redis.hgetall(resume_key_name).to_h)
    end

    if ret_val.empty? # Likely will not happen on eral server because the DB plugin will insert records and thus ret_val will NOT be empty. In the case it is, every user will be dumped into redis.
      User.all.each do |user|
        $redis.hmset("cache:stats_users_#{period}:#{user.uuid}", "username", user.username, "kills", user.kills, "deaths", user.deaths, "wins", user.wins, "losses", user.losses)
      end
    end
    ret_val.sort_by! { |hash| hash[sort].to_i }
  end

end
