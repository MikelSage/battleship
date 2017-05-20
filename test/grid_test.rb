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
    expected = ['A1', 'A2', 'B1', 'B2']
    assert_equal ({}), grid.board

    grid.board_setup('B2')

    assert_equal expected, grid.board.keys
    assert_instance_of Cell, grid.board['A1']
  end

  def test_can_create_larger_boards
    grid.board_setup('D4')
    binding.pry
    assert_equal 16, grid.board.keys.length

    grid.board_setup('E5')
    assert_equal 25, grid.board.keys.length
  end
end
