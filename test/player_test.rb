require "minitest/autorun"
require "minitest/pride"
require_relative "../lib/player"
require_relative '../lib/grid'
require_relative '../lib/ship'

class PlayerTest < Minitest::Test
  attr_reader :player
  def setup
    cpu_grid = Grid.new
    player_grid = Grid.new
    @player = Player.new(player_grid, cpu_grid)
  end

  def test_it_exists_and_knows_its_possible_ships
    expected = {
      'frigate' => 2,
      'destroyer' => 3,
      'cruiser' => 4,
      'carrier' => 5
    }

    assert_instance_of Player, player
    assert_equal expected, player.possible_ships
  end
end
