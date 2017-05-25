
require 'minitest/autorun'
require "minitest/pride"
require "pry"
require_relative '../lib/computer_player'
require_relative '../lib/grid'
require_relative '../lib/ship'

class ComputerPlayerTest < Minitest::Test
  attr_reader :cpu
  def setup
    cpu_grid = Grid.new
    player_grid = Grid.new
    @cpu = ComputerPlayer.new(cpu_grid, player_grid)
    cpu.own_grid.board_setup('D4')
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
    cpu_grid = Grid.new
    player_grid = Grid.new
    hard_cpu = ComputerPlayer.new(cpu_grid, player_grid, 14)
    expected = ['frigate', 'destroyer', 'cruiser', 'carrier']
    actual = hard_cpu.ships.keys

    assert_equal 14, hard_cpu.lives
    assert_equal expected, actual
  end

  def test_computer_can_place_ships_not_overlapping
    cpu.place_ships
    frigate_coords = cpu.ships['frigate'].coordinates
    destroyer_coords = cpu.ships['destroyer'].coordinates

    assert (frigate_coords & destroyer_coords).empty?
  end

  def test_computer_can_place_more_ships_not_overlapping
    cpu_grid = Grid.new
    player_grid = Grid.new
    hard_cpu = ComputerPlayer.new(cpu_grid, player_grid, 14)
    cpu_grid.board_setup('L12')
    hard_cpu.place_ships
    frigate_coords = hard_cpu.ships['frigate'].coordinates
    destroyer_coords = hard_cpu.ships['destroyer'].coordinates
    cruiser_coords = hard_cpu.ships['cruiser'].coordinates
    carrier_coords = hard_cpu.ships['carrier'].coordinates
    assert (frigate_coords & destroyer_coords).empty?
    assert (frigate_coords & cruiser_coords).empty?
    assert (frigate_coords & carrier_coords).empty?
    assert (destroyer_coords & cruiser_coords).empty?
    assert (destroyer_coords & carrier_coords).empty?
    assert (cruiser_coords & carrier_coords).empty?
    binding.pry
  end

  def test_can_change_ship_orientation
    ship = Ship.new
    expected = ['horizontal', 'vertical']

    cpu.set_orientation(ship)

    assert expected.include?(ship.orientation)
  end

  def test_can_generate_vertical_head
    frigate = Ship.new
    destroyer = Ship.new(3)
    expected_frigate = [
      'A1', 'A2', 'A3', 'A4',
      'B1', 'B2', 'B3', 'B4',
      'C1', 'C2', 'C3', 'C4'
    ]

    expected_destroyer = [
      'A1', 'A2', 'A3', 'A4',
      'B1', 'B2', 'B3', 'B4'
    ]

    invalid_destroyer = [
      'C1', 'C2', 'C3', 'C4',
      'D1', 'D2', 'D3', 'D4'
    ]

    assert expected_frigate.include?(cpu.generate_head_vertical(frigate))
    assert expected_destroyer.include?(cpu.generate_head_vertical(destroyer))
    refute invalid_destroyer.include?(cpu.generate_head_vertical(destroyer))
  end

  def test_can_generate_potential_vertical_placement
    destroyer = Ship.new(3)
    expected = [
      ['A1', 'B1', 'C1'], ['A2', 'B2', 'C2'],
      ['A3', 'B3', 'C3'], ['A4', 'B4', 'C4'],
      ['B1', 'C1', 'D1'], ['B2', 'C2', 'D2'],
      ['B3', 'C3', 'D3'], ['B4', 'C4', 'D4']
    ]
    head = cpu.generate_head_vertical(destroyer)
    potential_coords = [head]
    cpu.potential_vertical_coordinates(destroyer, potential_coords)
    assert expected.include?(potential_coords)
  end

  def test_can_generate_horizontal_head
    frigate = Ship.new
    destroyer = Ship.new(3)
    expected_frigate = [
      'A1', 'A2', 'A3',
      'B1', 'B2', 'B3',
      'C1', 'C2', 'C3',
      'D1', 'D2', 'D3'
    ]

    expected_destroyer = [
      'A1', 'A2', 'B1', 'B2',
      'C1', 'C2', 'D1', 'D2'
    ]

    invalid_destroyer = [
      'A3', 'A4', 'B3', 'B4',
      'C3', 'C4', 'D3', 'D4'
    ]

    assert expected_frigate.include?(cpu.generate_head_horizontal(frigate))
    assert expected_destroyer.include?(cpu.generate_head_horizontal(destroyer))
    refute invalid_destroyer.include?(cpu.generate_head_horizontal(destroyer))
  end

  def test_can_generate_potential_horizontal_placement
    destroyer = Ship.new(3)
    expected = [
      ['A1', 'A2', 'A3'], ['A2', 'A3', 'A4'],
      ['B1', 'B2', 'B3'], ['B2', 'B3', 'B4'],
      ['C1', 'C2', 'C3'], ['C2', 'C3', 'C4'],
      ['D1', 'D2', 'D3'], ['D2', 'D3', 'D4']
    ]
    head = cpu.generate_head_horizontal(destroyer)
    potential_coords = [head]
    cpu.potential_horizontal_coordinates(destroyer, potential_coords)
    assert expected.include?(potential_coords)
  end

  def test_can_shoot_at_coordinate_on_player_grid
    player_grid = Grid.new
    player_grid.board_setup('D4')
    expected = [[' ', ' ', ' ', ' '],
                [' ', 'M', ' ', ' '],
                [' ', 'M', ' ', ' '],
                [' ', ' ', ' ', ' ']]

    cpu.shoot_at(player_grid, 'C2')
    cpu.shoot_at(player_grid, 'B2')

    assert_equal expected, player_grid.layout_board
  end

  def test_shoots_randomly_at_uniq_spaces
    player_grid = Grid.new
    player_grid.board_setup('D4')

    available_slots = player_grid.available_slots

    cpu.shoot_randomly(player_grid)
    cpu.shoot_randomly(player_grid)
    cpu.shoot_randomly(player_grid)
    cpu.shoot_randomly(player_grid)
    cpu.shoot_randomly(player_grid)
    cpu.shoot_randomly(player_grid)
    cpu.shoot_randomly(player_grid)
    cpu.shoot_randomly(player_grid)
    cpu.shoot_randomly(player_grid)
    cpu.shoot_randomly(player_grid)
    cpu.shoot_randomly(player_grid)
    cpu.shoot_randomly(player_grid)
    cpu.shoot_randomly(player_grid)
    cpu.shoot_randomly(player_grid)
    cpu.shoot_randomly(player_grid)
    cpu.shoot_randomly(player_grid)

    assert cpu.shot_at.uniq.length == cpu.shot_at.length
  end
end
