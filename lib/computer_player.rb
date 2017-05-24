# needs to know about how many ships it has
# needs to know about its own grid
# needs to place ships
# needs to shoot at random coordinates
# creates ships as vertical/horizontal

require_relative "ship"

class ComputerPlayer
  attr_reader :own_grid, :foe_grid, :lives, :ships, :shot_at

  def initialize(own_grid, foe_grid, lives=5)
    @own_grid = own_grid
    @foe_grid = foe_grid
    @lives = lives
    @ships = self.set_ships(lives)
    @shot_at = []
  end

  def possible_ships
    {
      'frigate' => 2,
      'destroyer' => 3,
      'cruiser' => 4,
      'carrier' => 5
    }
  end

  def open_cells
    own_grid.available_slots
  end

  def set_ships(lives)
    actual_ships = {}
    possible_ships.each do |ship_name, size|
      if size <= lives
        lives -= size
        actual_ships[ship_name] = Ship.new(size)
      end
    end
    actual_ships
  end

  def place_ships
    available_cells = own_grid.available_slots
    occupied_cells = []
    @ships.each do |name, ship|
      set_orientation(ship)
      if ship.orientation == 'vertical'
        place_vertical_ship(ship, available_cells, occupied_cells)
      else
        place_horizontal_ship(ship, available_cells, occupied_cells)
      end
    end
  end

  def set_orientation(ship)
    ship.orientation = ['horizontal', 'vertical'].sample
  end

  def place_vertical_ship(ship, available_cells, occupied_cells)
    head = generate_head_vertical(ship)
    next_coord = nil
    potential_coords = [head]
    potential_vertical_coordinates(ship, potential_coords)

    if (potential_coords & occupied_cells).empty?
      potential_coords.each do |coord|
        own_grid.place_ship_at(coord,ship)
        ship.coordinates << coord
        occupied_cells << available_cells.delete(coord)
      end
    else
      place_vertical_ship(ship, available_cells, occupied_cells)
    end
  end

  def generate_head_vertical(ship)
    rows = own_grid.board.keys
    lowest_point = rows.length - ship.size + 1
    possible_heads = rows.first(lowest_point)
    possible_heads.sample + rand(1..rows.length).to_s
  end

  def potential_vertical_coordinates(ship, potential_coords)
    (ship.size-1).times do
      next_coord = potential_coords[-1][0].next + potential_coords[-1][1..2]
      potential_coords << next_coord
    end
  end

  def generate_head_horizontal(ship)
    rows = own_grid.board.keys
    rightmost_point = rows.length - ship.size + 1
    column = rand(1..rightmost_point).to_s
    rows.sample + column
  end

  def potential_horizontal_coordinates(ship, potential_coords)
    (ship.size-1).times do
      next_coord = potential_coords[-1][0] + potential_coords[-1][1..2].next
      potential_coords << next_coord
    end
  end

  def place_horizontal_ship(ship, available_cells, occupied_cells)
    head = generate_head_horizontal(ship)
    next_coord = nil
    potential_coords = [head]
    potential_horizontal_coordinates(ship, potential_coords)
    if (potential_coords & occupied_cells).empty?
      potential_coords.each do |coord|
        own_grid.place_ship_at(coord, ship)
        ship.coordinates << coord
        occupied_cells << available_cells.delete(coord)
      end
    else
      place_horizontal_ship(ship, available_cells, occupied_cells)
    end
  end

  def shoot_at(player_grid, coord)
    player_grid.shoot_at(coord)
    shot_at << coord
  end

  def shoot_randomly(foe_grid, available_cells)
    coord = available_cells.delete(available_cells.sample)
    shoot_at(foe_grid, coord)
  end
end
