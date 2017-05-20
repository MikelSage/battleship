require "minitest/autorun"
require "minitest/pride"
require_relative "../lib/cell"

class CellTest < Minitest::Test
  attr_reader :cell
  def setup
    @cell = Cell.new
  end

  def test_cell_exists_and_is_unoccupied_by_default
    assert_instance_of Cell, cell
    refute cell.occupied
  end

  def test_cell_can_become_occupied
    cell.place_ship
    assert cell.occupied
  end

  def test_status_is_empty_string_by_default
    assert_equal '', cell.status
  end

  def test_knows_when_shot_was_a_miss
    cell.shot_at
    assert_equal 'M', cell.status
  end

  def test_know_when_shot_is_a_hit
    cell.place_ship
    cell.shot_at
    
    assert_equal 'H', cell.status
  end
end
