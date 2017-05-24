require "minitest/autorun"
require "minitest/pride"
require_relative "../lib/game"

class GameTest < Minitest::Test
  attr_reader :game
  def setup
    @game = Game.new
  end

  def test_it_exists_and_players_are_nil_by_default
    assert_instance_of Game, game
  end

  def test_it_can_setup_game
    expected = [[' ', ' ', ' ', ' '],
                [' ', ' ', ' ', ' '],
                [' ', ' ', ' ', ' '],
                [' ', ' ', ' ', ' ']]

    game.setup

    assert_instance_of Player, game.player
    assert_instance_of ComputerPlayer, game.computer
    assert_equal expected, game.player_grid.layout_board
    assert_equal expected, game.computer_grid.layout_board
  end

  def test_coordinate_error_returns_correct_message
    too_short = ['A1']
    too_long = ['A1', 'A2', 'A3']
    occupied = ['A1', 'B1']
    invalid = ['A1', 'B2']

    game.setup
    ship = game.player.ships['frigate']
    grid = game.player_grid
    grid.place_ship_at('B1', ship)

    assert_equal 'The ship is longer, yo.', game.coordinate_error(too_short, ship, grid )
    assert_equal "That's too many coordinates, yo.", game.coordinate_error(too_long, ship, grid )
    assert_equal "That space is already occupied.", game.coordinate_error(occupied, ship, grid )
    assert_equal "The coordinates have to be in order.", game.coordinate_error(invalid, ship, grid )
  end

  def test_player_can_place_ships
    game.setup

    game.player_place_ship

    assert_instance_of Ship, game.player_grid.board['A']['1'].ship
    assert_instance_of Ship, game.player_grid.board['A']['2'].ship
  end
end
