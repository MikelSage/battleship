require_relative 'player'
require_relative 'computer_player'
require_relative 'grid'
require_relative 'validator'
require "pry"

class Game
  include Validator
  attr_reader :player,
              :computer,
              :player_grid,
              :computer_grid,
              :start_time

  def initialize
    @player = nil
    @computer = nil
    @player_grid = Grid.new
    @computer_grid = Grid.new
    @start_time = nil
  end

  def setup
    player_grid.board_setup('D4')
    computer_grid.board_setup('D4')
    @player = Player.new(player_grid, computer_grid)
    @computer = ComputerPlayer.new(computer_grid, player_grid)
  end

  def computer_place_ships
    computer.place_ships
  end

  def player_place_ship
    player.ships.each do |ship_name, ship|
      puts "Place your #{ship_name}, it is #{ship.size} units long"
      coords = gets.chomp.upcase.split
      while invalid_coordinates?(coords, ship, player_grid)
        puts coordinate_error(coords, ship, player_grid)
        coords = gets.chomp.upcase.split
      end

      player.place_ship(coords, ship)
    end
  end

  def coordinate_error(coords, ship, grid)
    if invalid_format?(coords)
      "That's not a valid format, dude"
    elsif coords.length < ship.size
      'The ship is longer, yo.'
    elsif coords.length > ship.size
      "That's too many coordinates, yo."
    elsif any_occupied?(grid, coords)
      "That space is already occupied."
    elsif invalid_coordinates?(coords, ship, player_grid)
      "The coordinates have to be in order."
    end
  end

  def players_take_shots
    ships_sunk = {}
    start_time = Time.now
    until (computer_grid.occupied_cells.length == 0 || player_grid.occupied_cells.length == 0)
      computer_grid.print_results
      puts ''
      player_grid.print_results
      ships_sunk_this_round(ships_sunk)

      puts 'Pick a coordinate to shoot at: '
      coordinate = gets.chomp.upcase

      player.shoot_at(coordinate)
      computer.shoot_randomly(player_grid)

      puts ''
      puts ''
      puts ''
    end
  end

  def ships_sunk_this_round(ships_sunk)
    player.ships.each do |ship_name, ship|
      next if ships_sunk.has_key?('your ' + ship_name)
      if ship.sunk?
        puts "The computer sunk your #{ship_name}!"
        ships_sunk['your ' + ship_name] = ship
      end
    end

    computer.ships.each do |ship_name, ship|
      next if ships_sunk.has_key?('enemy ' + ship_name)
      if ship.sunk?
        puts "You sunk the enemy's #{ship_name}!"
        ships_sunk['enemy ' + ship_name] = ship
      end
    end
  end

  def winner
    if computer_grid.occupied_cells.empty?
      player
    else
      computer
    end
  end

  def endgame_stats
    puts time_taken
    puts shots_fired
  end
end
