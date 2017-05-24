require_relative 'player'
require_relative 'computer_player'
require_relative 'grid'
require_relative 'validator'

class Game
  include Validator
  attr_reader :player, :computer, :player_grid, :computer_grid
  def initialize
    @player = nil
    @computer = nil
    @player_grid = Grid.new
    @computer_grid = Grid.new
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

      coords.each do |coord|
        player_grid.place_ship_at(coord, ship)
      end
    end
  end

  def coordinate_error(coords, ship, grid)
    if coords.length < ship.size
      'The ship is longer, yo.'
    elsif coords.length > ship.size
      "That's too many coordinates, yo."
    elsif any_occupied?(grid, coords)
      "That space is already occupied."
    elsif invalid_coordinates?(coords, ship, player_grid)
      "The coordinates have to be in order."
    # else
    #   ''
    end
  end
end
