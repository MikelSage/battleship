require "minitest/autorun"
require "minitest/pride"
require_relative "../lib/validator"
require_relative "../lib/ship"
require_relative "../lib/grid"

class ValidatorTest < Minitest::Test
  include Validator
  attr_reader :validator
  def setup
    @validator = Object.new
    @validator.extend(Validator)
  end

  def test_it_knows_if_characters_are_within_one
    assert validator.within_one?('A', 'B')
    assert validator.within_one?('1', '2')
    assert validator.within_one?('3', '2')
    refute validator.within_one?('A', 'C')
    refute validator.within_one?('1', '3')
  end

  def test_know_if_next_coordinate_is_valid
    assert validator.valid_next_coordinate?('A1', 'A2')
    assert validator.valid_next_coordinate?('B2', 'C2')
    assert validator.valid_next_coordinate?('B2', 'C2', 'A2')
    refute validator.valid_next_coordinate?('A1', 'A4')
    refute validator.valid_next_coordinate?('B2', 'D2')
    refute validator.valid_next_coordinate?('B2', 'B3', 'A2')
  end

  def test_it_knows_valid_coordinates
    frigate = Ship.new
    destroyer = Ship.new
    grid = Grid.new
    grid.board_setup('D4')
    valid_frigate_coords = ['B2', 'C2']
    valid_destroyer_coords = ['D1', 'D2', 'D3']

    refute validator.invalid_coordinates?(valid_frigate_coords, frigate, grid)
  end

  def test_it_knows_invalid_coordinates
    frigate = Ship.new
    destroyer = Ship.new
    grid = Grid.new
    grid.board_setup('D4')
    invalid_frigate_coords = ['B2', 'D2']
    invalid_destroyer_coords = ['D1', 'D2', 'D4']
    horizontal_l = ['D1', 'D2', 'C2']
    vertical_l = ['A1', 'B1', 'B2']
    vertical_l_four = ['A1', 'B1', 'C1', 'C3']
    weird_vertical = ['A1', 'B1', 'C2', 'D4']


    assert validator.invalid_coordinates?(invalid_frigate_coords, frigate, grid)
    assert validator.invalid_coordinates?(invalid_destroyer_coords, destroyer, grid)
    assert validator.invalid_coordinates?(horizontal_l, destroyer, grid)
    assert validator.invalid_coordinates?(vertical_l, destroyer, grid)
    assert validator.invalid_coordinates?(vertical_l_four, destroyer, grid)
    assert validator.invalid_coordinates?(weird_vertical, destroyer, grid)
  end

  def test_knows_if_coordinate_invalid_format
    valid_format = ['A1', 'A2']
    invalid_format = ['AQ', '23']

    refute validator.invalid_format?(valid_format)
    assert validator.invalid_format?(invalid_format)
  end
end
