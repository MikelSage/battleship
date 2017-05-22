require "minitest/autorun"
require "minitest/pride"
require_relative "../lib/ship"
require "pry"

class ShipTest < Minitest::Test
  attr_reader :frigate, :destroyer, :battleship, :carrier
  def setup
    @frigate = Ship.new
    @destroyer = Ship.new(3)
    @battleship = Ship.new(4)
    @carrier = Ship.new(5)
  end

  def test_it_exists_and_size_is_two_by_default
    assert_instance_of Ship, frigate
    assert_equal 2, frigate.size
  end

  def test_it_can_be_a_bigger_ship
    assert_equal 3, destroyer.size
    assert_equal 4, battleship.size
    assert_equal 5, carrier.size
  end

  def test_knows_its_coordinates
    expected = ['A2', 'B2', 'C2']

    destroyer.add_coordinate('A2')
    destroyer.add_coordinate('B2')
    destroyer.add_coordinate('C2')

    assert_equal expected, destroyer.coordinates
  end
end
