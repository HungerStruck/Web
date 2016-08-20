Player.collection.drop
Game.collection.drop
Event.collection.drop

usernames = ['Komp', 'trevin', 'Hpt', 'skreem', 'Skipper_', 'TeddyTheTeddy', 'Halftone', 'molenzwiebel', 'ollyj', 'snatimal', 'ElMeegaBassKK', 'Mannrrys', 'InLoc', 'Snuskenmaxi', 'Picajoluna', 'FuriosoD1', 'Pebble', 'Zegita', 'lordblox', 'Saaturn', 'Koro_', 'xDutch', 'thesus101', 'Rauuh']

24.times do |i|
  username = 'player' + i.to_s
  user = Player.new(
    email: usernames[i] + '@koole.io',
    username: usernames[i],
    password: 'securepassword',
    background_image: "default"
  )
  user.skip_confirmation!
  user.save!
end

games = 1

endtime = 0

games.times do |i|
  time = rand(10..40)
  players = (time / 1.2).round
  feasts = (time / 5).floor

  if players > 24
    players = 24
  end

  livePlayers = Player.all.sample(players)

  game = Game.new(
    players: livePlayers,
    started_at: (endtime + time).minutes.ago,
    ended_at: endtime.minutes.ago,
    map: 'Mellow Forests',
    server: 'HS1'
  )
  game.save

  times = []

  (players - 1).times do
    times << rand(0..(60*time))
  end

  times.sort!
  times.reverse!

  (players - 1).times do |pi|
    dead = livePlayers.pop
    killer = livePlayers.sample
    game.events.create(time: times[pi].seconds.ago, type: 'death', player: dead, killer: killer)
  end

  feasts.times do |fi|
    game.events.create(time: (endtime + time - 5 * (fi + 1)).minutes.ago, type: 'feast')
  end

  endtime += time
end