require "minitest/autorun"
require "minitest/pride"
require_relative "../lib/cell"
require_relative "../lib/ship"

class CellTest < Minitest::Test
  attr_reader :cell, :ship
  def setup
    @cell = Cell.new
    @ship = Ship.new
  end

  def test_cell_exists_and_is_unoccupied_by_default
    assert_instance_of Cell, cell
    refute cell.occupied
  end

  def test_cell_can_become_occupied
    cell.place_ship(ship)
    assert cell.occupied
  end

  def test_status_is_space_by_default
    assert_equal ' ', cell.status
  end

  def test_knows_when_shot_was_a_miss
    cell.shoot_at('A4')
    assert_equal 'M', cell.status
  end

  def test_know_when_shot_is_a_hit
    cell.place_ship(ship)
    cell.shoot_at('A4')

    assert_equal 'H', cell.status
  end

  def test_knows_when_shot_was_a_miss_for_ten_or_greater
    cell.shoot_at('A10')
    assert_equal ' M', cell.status
  end

  def test_know_when_shot_is_a_hit_for_ten_or_greater
    cell.place_ship(ship)
    cell.shoot_at('A10')

    assert_equal ' H', cell.status
  end
end
