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

    grid.board['C']['2'].shot_at

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

    grid.board['B']['3'].place_ship
    grid.board['B']['3'].shot_at
    grid.board['B']['4'].shot_at

    assert_equal expected_mod, grid.layout_board
  end
end
