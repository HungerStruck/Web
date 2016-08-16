games = 5

games.times do |i|
  games_left = games - i
  game = Game.new(
    # users: User.all,
    started_at: (games_left*10 + 9).minutes.ago,
    ended_at: (games_left*10).minutes.ago,
    map: 'Biodomes',
    server: 'HS1'
  )
  game.save
  20.times do |i|
    game.events.create(time: Time.now.to_s, type: 'death', user: User.first, killer: User.last)
  end
end