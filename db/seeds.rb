matches = 5

matches.times do |i|
  matches_left = matches - i
  match = Match.new(
    # users: User.all,
    started_at: (matches_left*10 + 9).minutes.ago,
    ended_at: (matches_left*10).minutes.ago,
    map: 'Biodomes',
    server: 'HS1'
  )
  match.save
  20.times do |i|
    match.events.create(time: Time.now.to_s, type: 'death', user: User.first, killer: User.last)
  end
end