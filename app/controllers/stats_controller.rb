class StatsController < ApplicationController

  def index
    @stats_users = case  params[:period]
      when "today"    #compare to 1
        Rails.cache.fetch("stats_users_today", expires_in: 1.day) do
         User.only([:username, :kills, :deaths, :wins, :losses]).to_a.each do |user|
          zero_stats(user)
         end
        end
      when "week"    #compare to 2
        Rails.cache.fetch("stats_users_week", expires_in: 1.week) do
          User.only([:username, :kills, :deaths, :wins, :losses]).to_a.each do |user|
           zero_stats(user)
          end
        end
      else
        Rails.cache.fetch("stats_users", expires_in: 30.minutes) do
         User.only([:username, :kills, :deaths, :wins, :losses]).to_a
        end
      end
  end

  private
  def zero_stats(user)
    user.kills = 0
    user.deaths = 0
    user.wins = 0
    user.losses = 0
  end

end
