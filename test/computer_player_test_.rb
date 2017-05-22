require 'minitest/autorun'
require "minitest/pride"
require "pry"
require_relative '../lib/computer_player'

class ComputerPlayerTest < Minitest::Test
  attr_reader :cpu
  def setup
    @cpu = ComputerPlayer.new
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
    hard_cpu = ComputerPlayer.new(14)
    expected = ['frigate', 'destroyer', 'cruiser', 'carrier']
    actual = hard_cpu.ships.keys

    assert_equal 14, hard_cpu.lives
    assert_equal expected, actual
  end
end
