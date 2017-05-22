# needs to know about how many ships it has
# needs to know about its own grid
# needs to place ships
# needs to shoot at random coordinates
# creates ships as vertical/horizontal

require_relative "ship"

class ComputerPlayer
  attr_reader :own_grid, :foe_grid, :lives, :ships

  def initialize(own_grid, foe_grid, lives=5)
    @own_grid = own_grid
    @foe_grid = foe_grid
    @lives = lives
    @ships = self.set_ships(lives)
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

  def place_ships
    available_cells = own_grid.available_slots
    @ships.each do |name, ship|

    end
  end

  def possible_next_placement(current_coord)
    last_letter = current_coord[0]
    last_num = current_coord[1].to_i
    possile_letters = [(last_letter.ord - 1).chr, last_letter.next]
    possible_nums = [last_num - 1, last_num + 1]

    [
     possile_letters[0]+last_num.to_s,
     possile_letters[1]+last_num.to_s,
     last_letter+possible_nums[0].to_s,
     last_letter+possible_nums[1].to_s
    ]
  end
end
