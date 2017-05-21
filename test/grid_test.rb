require "minitest/autorun"
require "minitest/pride"
require_relative "../lib/grid"
require "pry"

class GridTest < Minitest::Test
  attr_reader :grid
  def setup
    @grid = Grid.new
  end

  def test_grid_exists_and_board_is_empty_by_default
    assert_instance_of Grid, grid
    assert_equal ({}), grid.board
  end

  def test_can_create_two_by_two_board_with_cells
    expected = ['A', 'B']
    assert_equal ({}), grid.board

    grid.board_setup('B2')

    assert_equal expected, grid.board.keys
    assert_instance_of Cell, grid.board['A']['1']
  end

  def test_can_create_larger_boards
    grid.board_setup('D4')
    assert_equal 4, grid.board.keys.length
    assert_equal 4, grid.board['D'].keys.length

    grid.board_setup('E5')
    assert_equal 5, grid.board.keys.length
    assert_equal 5, grid.board['E'].keys.length
  end

  def test_can_layout_board
    grid.board_setup('D4')
    expected = [[' ', ' ', ' ', ' '],
                [' ', ' ', ' ', ' '],
                [' ', ' ', ' ', ' '],
                [' ', ' ', ' ', ' ']]

    assert_equal expected, grid.layout_board
  end

  def test_grid_knows_if_space_is_occupied
    grid.board_setup('D4')

    refute grid.space_occupied?('B3')

    grid.board['B']['3'].place_ship

    assert grid.space_occupied?('B3')
  end

  def test_can_place_ship_on_grid
    grid.board_setup('D4')
    grid.place_ship_at('D3')

    refute grid.space_occupied?('B3')
    assert grid.space_occupied?('D3')
  end

  def test_place_ship_returns_nil_if_space_occupied
    grid.board_setup('D4')
    grid.place_ship_at('D3')
    assert grid.space_occupied?('D3')

    assert_nil grid.place_ship_at('D3')
  end

  def test_can_shoot_at_coordinate
    grid.board_setup('D4')
    grid.place_ship_at('B3')
    grid.place_ship_at('C4')
    grid.shoot_at('B2')
    grid.shoot_at('B3')
    grid.shoot_at('C4')

    assert_equal 'M', grid.board['B']['2'].status
    assert_equal 'M', grid.board['B']['2'].status
    assert_equal 'M', grid.board['B']['2'].status
  end

  def test_can_display_a_miss
    grid.board_setup('D4')
    expected_raw = [[' ', ' ', ' ', ' '],
                    [' ', ' ', ' ', ' '],
                    [' ', ' ', ' ', ' '],
                    [' ', ' ', ' ', ' ']]

    expected_mod = [[' ', ' ', ' ', ' '],
                    [' ', ' ', ' ', ' '],
                    [' ', 'M', ' ', ' '],
                    [' ', ' ', ' ', ' ']]

    assert_equal expected_raw, grid.layout_board

    grid.shoot_at('C2')

    assert_equal expected_mod, grid.layout_board
  end

  def test_can_display_a_hit
    grid.board_setup('D4')
    expected_raw = [[' ', ' ', ' ', ' '],
                    [' ', ' ', ' ', ' '],
                    [' ', ' ', ' ', ' '],
                    [' ', ' ', ' ', ' ']]

    expected_mod = [[' ', ' ', ' ', ' '],
                    [' ', ' ', 'H', 'M'],
                    [' ', ' ', ' ', ' '],
                    [' ', ' ', ' ', ' ']]

    assert_equal expected_raw, grid.layout_board

    grid.place_ship_at('B3')
    grid.shoot_at('B3')
    grid.shoot_at('B4')

    assert_equal expected_mod, grid.layout_board
  end
end
