require_relative 'fleet_generator'

class Player
  include FleetGenerator
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
