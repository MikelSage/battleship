class Player
  attr_reader :own_grid,
              :foe_grid,
              :lives,
              :ships,
              :shot_at

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

  def place_ship(coords,ship)
    coords.each do |coord|
      own_grid.place_ship_at(coord, ship)
      ship.coordinates << coord
      occupied_cells << coord
    end
  end

  def shoot_at(coord)
    foe_grid.shoot_at(coord)
    shot_at << coord
  end
end
