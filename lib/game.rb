require_relative 'player'
require_relative 'computer_player'
require_relative 'grid'
require_relative 'validator'
require_relative 'messages'
require "pry"

class Game
  include Validator, Messages
  attr_reader :player,
              :computer,
              :player_grid,
              :computer_grid,
              :start_time

  def initialize(fleet_size=5)
    @player_grid = Grid.new
    @computer_grid = Grid.new
    @player = Player.new(player_grid, computer_grid, fleet_size)
    @computer = ComputerPlayer.new(computer_grid, player_grid, fleet_size)
    @start_time = nil
    @shots_fired = 0
  end

  def setup(lower_right)
    player_grid.board_setup(lower_right)
    computer_grid.board_setup(lower_right)
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
    @start_time = Time.now
    until (computer_grid.occupied_cells.length == 0 || player_grid.occupied_cells.length == 0)
      computer_grid.print_results
      puts ''
      player_grid.print_results
      ships_sunk_this_round(ships_sunk)

      puts 'Pick a coordinate to shoot at: '
      coordinate = gets.chomp.upcase
      while invalid_format?(coordinate.split)
        puts "Invalid format, please choose again"
        coordinate = gets.chomp.upcase
      end

      player.shoot_at(coordinate)
      computer.shoot_randomly(player_grid)
      @shots_fired += 1

      puts ''
      puts divider
    end
    ships_sunk_this_round(ships_sunk)
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
    puts "You took #{time_taken.round(2)} seconds to vanquish your enemy."
    puts "Your logistics officer laments the use of #{shots_fired} shells to win."
  end

  def time_taken
    endgame_time = Time.now
    endgame_time - start_time
  end

  def shots_fired
    @shots_fired
  end
end
