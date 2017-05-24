require "minitest/autorun"
require "minitest/pride"
require_relative '../lib/player'
require_relative '../lib/computer_player'
require_relative '../lib/grid'
require_relative '../lib/ship'

class PlayerTest < Minitest::Test
  attr_reader :player, :cpu_grid, :player_grid
  def setup
    @cpu_grid = Grid.new
    @player_grid = Grid.new
    player_grid.board_setup('D4')
    @player = Player.new(player_grid, cpu_grid)
  end

  def test_it_exists_knows_its_possible_ships_and_has_5_lives_by_default
    expected = {
      'frigate' => 2,
      'destroyer' => 3,
      'cruiser' => 4,
      'carrier' => 5
    }

    assert_instance_of Player, player
    assert_equal expected, player.possible_ships
    assert_equal 5, player.lives
  end

  def test_set_ships_gives_correct_results
    expected = ['frigate', 'destroyer']
    actual = player.set_ships(5).keys

    assert_equal expected, actual
    assert_instance_of Ship, player.set_ships(5)['frigate']
  end

  def test_can_initialize_with_more_lives_and_ships
    cpu_grid = Grid.new
    player_grid = Grid.new
    hard_player = Player.new(player_grid, cpu_grid, 14)
    expected = ['frigate', 'destroyer', 'cruiser', 'carrier']
    actual = hard_player.ships.keys

    assert_equal 14, hard_player.lives
    assert_equal expected, actual
  end

  def test_player_can_place_ships
    player.place_ship(['A1', 'A2'], player.ships['frigate'])
    board = player.own_grid.board

    assert_instance_of Ship, board['A']['1'].ship
    assert_instance_of Ship, board['A']['2'].ship
    assert_nil board['B']['3'].ship
  end

  def test_player_can_shoot_at_enemy_ships
    frigate = Ship.new
    cpu_grid.board_setup('D4')
    cpu_grid.place_ship_at('B3', frigate)
    cpu_grid.place_ship_at('B4', frigate)
    expected = [[' ', ' ', ' ', ' '],
                [' ', ' ', 'H', ' '],
                [' ', ' ', 'M', ' '],
                [' ', ' ', ' ', ' ']]

    player.shoot_at('B3')
    player.shoot_at('C3')

    assert_equal expected, cpu_grid.layout_board
  end
end
