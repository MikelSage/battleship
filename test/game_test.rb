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
end
