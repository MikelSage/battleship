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
end
