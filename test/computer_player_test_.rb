
require 'minitest/autorun'
require "minitest/pride"
require "pry"
require_relative '../lib/computer_player'
require_relative '../lib/grid'
require_relative '../lib/ship'

class ComputerPlayerTest < Minitest::Test
  attr_reader :cpu
  def setup
    cpu_grid = Grid.new
    player_grid = Grid.new
    @cpu = ComputerPlayer.new(cpu_grid, player_grid)
    cpu.own_grid.board_setup('D4')
  end

  def test_it_exists_and_knows_its_possible_ships
    expected = {
      'frigate' => 2,
      'destroyer' => 3,
      'cruiser' => 4,
      'carrier' => 5
    }

    assert_instance_of ComputerPlayer, cpu
    assert_equal expected, cpu.possible_ships
  end

  def test_set_ships_gives_correct_results
    expected = ['frigate', 'destroyer']
    actual = cpu.set_ships(5).keys

    assert_equal expected, actual
    assert_instance_of Ship, cpu.set_ships(5)['frigate']
  end

  def test_can_initialize_with_lives_and_some_ships
    expected = ['frigate', 'destroyer']
    actual = cpu.ships.keys

    assert_equal 5, cpu.lives
    assert_equal expected, actual
    assert_instance_of Ship, cpu.ships[actual.sample]
  end

  def test_can_initialize_with_more_lives_and_ships
    cpu_grid = Grid.new
    player_grid = Grid.new
    hard_cpu = ComputerPlayer.new(cpu_grid, player_grid, 14)
    expected = ['frigate', 'destroyer', 'cruiser', 'carrier']
    actual = hard_cpu.ships.keys

    assert_equal 14, hard_cpu.lives
    assert_equal expected, actual
  end

  def test_possible_next_placement_returns_expected
    expected = ['A2', 'C2', 'B1', 'B3']
    actual = cpu.possible_next_placement('B2')

    assert_equal expected, actual
  end

  def test_computer_can_place_ships
    skip
    expected = [[' ', ' ', ' ', ' '],
                [' ', ' ', ' ', ' '],
                [' ', ' ', ' ', ' '],
                [' ', ' ', ' ', ' ']]
    cpu.place_ships

    assert_equal expected, cpu.own_grid.layout_board
  end

  def test_can_change_ship_orientation
    ship = Ship.new
    expected = ['horizontal', 'vertical']

    cpu.set_orientation(ship)

    assert expected.include?(ship.orientation)
  end
end
