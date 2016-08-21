class GamesController < ApplicationController

  def index
    @finished_games = Game.all
    expires_in 2.minutes, :public => true
  end

  def events
    @finished_games = Game.where(event: true)
  end

  def show
    col_width = 29

    @game = Game.find(params[:id])

    player_count = @game.players.count

    # This part sorts the players in to the correct order
    @players_sorted = []
    @game.events.asc(:time).each do |event|
      if event.type == 'death'
        @players_sorted << event.player
      end
    end

    @game.players.each do |player|
      unless @players_sorted.include?(player)
        @players_sorted << player
      end
    end

    @players_sorted.reverse!
    players_hash = Hash[@players_sorted.map.with_index.to_a] 

    # Creates the events for the timeline
    @timeline_events = []
    spacing = 0
    @timeline_events << {
      time: @game.started_at,
      type: 'start',
      width: (col_width * player_count + col_width)
    }
    old_time = @game.started_at
    @game.events.asc(:time).each do |event|
      timeline_event = {
        time: event.time,
        type: event.type,
        player: event.player,
        killer: event.killer,
        width: (col_width * player_count + col_width),
        spacing: spacing,
        killer_row: players_hash[event.killer].to_i * col_width + col_width + 9,
        killer_line: (players_hash[event.player].to_i - players_hash[event.killer].to_i) * col_width
      }
      time_difference = ((event.time - old_time) * 24 * 60 * 60).to_i
      # if time_difference > 120
      #   spacing = 60
      # end
      # if time_difference > 300
      #   spacing = 80
      # end
      spacing = time_difference
      old_time = event.time
      @timeline_events << timeline_event
      if event.type == 'death'
        player_count -= 1
      end
    end

    if player_count == 1
      @timeline_events << {
        type: 'win',
        player: @players_sorted.first,
          width: (col_width * player_count + col_width)
      }
    else
      @timeline_events << {
        type: 'blank',
        width: (col_width * player_count + col_width)
      }
    end

    @timeline_events.reverse!

    # expires_in 2.minutes, :public => true
  end

  def newevent
    Event.create! time: Time.now.to_s, type: 'death', game: Game.find(params[:id]), player: Player.find('578bd194b392e821f6cc859c'), killer: Player.find('576fc3d8b392e86347bec086')
    render text: Time.now.to_s
  end

end