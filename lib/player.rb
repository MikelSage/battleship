# needs to know ships
# needs to place ships
# validate coordinates
# needs to shoot at enemy


class Player
  def initialize(own_grid, foe_grid, lives=5)
    @own_grid = own_grid
    @foe_grid = foe_grid
    @lives = lives
  end

  def possible_ships
    {
      'frigate' => 2,
      'destroyer' => 3,
      'cruiser' => 4,
      'carrier' => 5
    }
  end
end
