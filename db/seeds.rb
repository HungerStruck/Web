Player.collection.drop
Game.collection.drop
Event.collection.drop
Map.collection.drop

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

games = 20
starttime = 10
games.times do |i|

  time = rand(10..40)
  players = (time / 1.2).round
  feasts = (time / 5).floor

  if players > 24
    players = 24
  end

  live_players = Player.all.sample(players)

  game = Game.new(
    players: live_players,
    started_at: (starttime + time).minutes.ago,
    ended_at: starttime.minutes.ago,
    map: 'Mellow Forests',
    server: 'HS1'
  )

  if i == 1
    game = Game.new(
      players: live_players,
      started_at: (starttime + time).minutes.ago,
      ended_at: starttime.minutes.ago,
      map: 'Mellow Forests',
      server: 'HS1',
      name: 'The Best Event',
      event: true
    )
  end

  game.save

  times = []

  (players - 1).times do
    times << rand(0..(60*time))
  end

  times.sort!
  times.reverse!

  (players - 1).times do |pi|
    dead = live_players.pop
    killer = live_players.sample
    game.events.create(time: (starttime * 60 + times[pi]).seconds.ago, type: 'death', player: dead, killer: killer)
  end

  feasts.times do |fi|
    game.events.create(time: (starttime + time - 5 * (fi + 1)).minutes.ago, type: 'feast')
  end

  starttime += time + 5
end