require "minitest/autorun"
require "minitest/pride"
require_relative "../lib/validator"

class ValidatorTest < Minitest::Test
  attr_reader :validator
  def setup
    @validator = Validator.new
  end

  def test_it_exists
    assert_instance_of Validator, validator
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
end