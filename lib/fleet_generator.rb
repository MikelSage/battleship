require_relative "ship"

module FleetGenerator
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
end
