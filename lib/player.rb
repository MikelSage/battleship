class Player
  attr_reader :own_grid,
              :foe_grid,
              :fleet_size,
              :ships,
              :shot_at

  def initialize(own_grid, foe_grid, fleet_size=5)
    @own_grid = own_grid
    @foe_grid = foe_grid
    @fleet_size = fleet_size
    @ships = self.set_ships(fleet_size)
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

  def set_ships(fleet_size)
    actual_ships = {}
    possible_ships.each do |ship_name, size|
      if size <= fleet_size
        fleet_size -= size
        actual_ships[ship_name] = Ship.new(size)
      end
    end
    actual_ships
  end

  def place_ship(coords,ship)
    coords.each do |coord|
      own_grid.place_ship_at(coord, ship)
      ship.coordinates << coord
    end
  end

  def shoot_at(coord)
    foe_grid.shoot_at(coord)
    shot_at << coord
  end
end
