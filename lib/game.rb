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

  def player_place_ship
    player.ships.each do |ship_name, ship|
      puts "Place your #{ship_name}, it is #{ship.size} units long"
      coords = gets.chomp.upcase.split
      while invalid_coordinates?(coords, ship, player_grid)
        if coords.length < ship.size
          puts 'The ship is longer, yo.'
        elsif coords.length > ship.size
          puts "That's too many coordinates, yo."
        elsif any_occupied?(player_grid, coords)
          puts "That space is already occupied."
        else
          puts "The coordinates have to be in order."
        end
        coords = gets.chomp.upcase.split
      end

      coords.each do |coord|
        player_grid.place_ship_at(coord, ship)
      end
    end
  end
end
