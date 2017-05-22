# needs to know about how many ships it has
# needs to know about its own grid
# needs to place ships
# needs to shoot at random coordinates
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
    @ships.each do |name, ship|
      current_letter = ('A'..'D').to_a.sample
      current_num = rand(1..4)
      current_coord = current_letter+current_num.to_s
      ship.size.times do
        binding.pry
        if ship.coordinates.empty?
          own_grid.place_ship_at(current_coord)
          ship.coordinates << current_coord
          current_coord = possible_next_placement(current_coord).sample
        else
          own_grid.place_ship_at(current_coord)
          if current_coord[0] == ship.coordinates.first[0]
            if current_coord[1] == '1'
            current_coord = current_coord[0]+current_coord[1].next
            end
          end
        end
      end
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
