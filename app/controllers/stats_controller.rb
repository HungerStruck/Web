class StatsController < ApplicationController

  def index
    @stats_users = case  params[:period]
      when "today"    #compare to 1
        get_stats_or_insert("today")
      when "week"    #compare to 2
        get_stats_or_insert("week")
      else
        get_stats_or_insert("all")
      end
  end

  private
  def get_stats_or_insert(period)
    ret_val = Array.new

    $redis.scan_each(match: "cache:stats_users_#{period}:*") do |resume_key_name|
        ret_val.push($redis.hgetall(resume_key_name))
    end

    if ret_val.empty? # Likely will not happen on eral server because the DB plugin will insert records and thus ret_val will NOT be empty. In the case it is, every user will be dumped into redis.
      User.all.each do |user|
        $redis.hmset("cache:stats_users_#{period}:#{user.uuid}", "username", user.username, "kills", user.kills, "deaths", user.deaths, "wins", user.wins, "losses", user.losses)
      end
    end

    ret_val
  end

end
