Player.collection.drop
Game.collection.drop
Event.collection.drop


username = 'leon'
user = Player.new(
  email: username + '@koole.io',
  username: username,
  password: 'leonkoole',
  background_image: "default",
  mongoid_admin: true
)
user.skip_confirmation!
user.save!

23.times do |i|
  username = 'player' + i.to_s
  user = Player.new(
    email: username + '@koole.io',
    username: username,
    password: username,
    background_image: "default"
  )
  user.skip_confirmation!
  user.save!
end

games = 5

games.times do |i|
  endtime = i * 35
  game = Game.new(
    players: Player.all,
    started_at: (endtime + 30).minutes.ago,
    ended_at: endtime.minutes.ago,
    map: 'Biodomes',
    server: 'HS1'
  )
  game.save
  game.events.create(time: (endtime).minutes.ago, type: 'death', player: Player.skip(0).first, killer: Player.skip(1).first)
  game.events.create(time: (endtime).minutes.ago, type: 'death', player: Player.skip(0).first, killer: Player.skip(2).first)
  game.events.create(time: (endtime).minutes.ago, type: 'death', player: Player.skip(0).first, killer: Player.skip(3).first)
  game.events.create(time: (endtime).minutes.ago, type: 'death', player: Player.skip(0).first, killer: Player.skip(3).first)
  game.events.create(time: (endtime).minutes.ago, type: 'death', player: Player.skip(0).first, killer: Player.skip(4).first)
  game.events.create(time: (endtime).minutes.ago, type: 'death', player: Player.skip(0).first, killer: Player.skip(5).first)
  game.events.create(time: (endtime).minutes.ago, type: 'death', player: Player.skip(0).first, killer: Player.skip(6).first)
  game.events.create(time: (endtime).minutes.ago, type: 'death', player: Player.skip(0).first, killer: Player.skip(7).first)
  game.events.create(time: (endtime).minutes.ago, type: 'death', player: Player.skip(0).first, killer: Player.skip(8).first)
  game.events.create(time: (endtime).minutes.ago, type: 'death', player: Player.skip(0).first, killer: Player.skip(9).first)
  game.events.create(time: (endtime).minutes.ago, type: 'death', player: Player.skip(0).first, killer: Player.skip(10).first)
  game.events.create(time: (endtime).minutes.ago, type: 'death', player: Player.skip(0).first, killer: Player.skip(11).first)
  game.events.create(time: (endtime).minutes.ago, type: 'death', player: Player.skip(0).first, killer: Player.skip(12).first)
  game.events.create(time: (endtime).minutes.ago, type: 'death', player: Player.skip(0).first, killer: Player.skip(13).first)
  game.events.create(time: (endtime).minutes.ago, type: 'death', player: Player.skip(0).first, killer: Player.skip(14).first)
  game.events.create(time: (endtime).minutes.ago, type: 'death', player: Player.skip(0).first, killer: Player.skip(15).first)
  game.events.create(time: (endtime).minutes.ago, type: 'death', player: Player.skip(0).first, killer: Player.skip(16).first)
  game.events.create(time: (endtime).minutes.ago, type: 'death', player: Player.skip(0).first, killer: Player.skip(17).first)
  game.events.create(time: (endtime).minutes.ago, type: 'death', player: Player.skip(0).first, killer: Player.skip(18).first)
  game.events.create(time: (endtime).minutes.ago, type: 'death', player: Player.skip(0).first, killer: Player.skip(19).first)
  game.events.create(time: (endtime).minutes.ago, type: 'death', player: Player.skip(0).first, killer: Player.skip(20).first)
  game.events.create(time: (endtime).minutes.ago, type: 'death', player: Player.skip(0).first, killer: Player.skip(21).first)
  game.events.create(time: (endtime).minutes.ago, type: 'death', player: Player.skip(0).first, killer: Player.skip(22).first)
  game.events.create(time: (endtime).minutes.ago, type: 'death', player: Player.skip(0).first, killer: Player.skip(23).first)
end