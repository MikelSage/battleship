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
      first_letter = ('A'..'D').to_a.sample
      first_num = rand(1..4)
      next_coord = nil
      ship.size.times do |time|
        # binding.pry
        if time > 0
          own_grid.place_ship_at(next_coord)
          # binding.pry
          if first_letter == next_coord[0]
            next_coord = first_letter+([first_num-1, first_num+1].sample.to_s) unless first_num == 1
          else
            next_coord = first_letter.next+first_num.to_s
          end
        else
          own_grid.place_ship_at(first_letter+first_num.to_s)
          next_coord = possible_next_placement(first_letter, first_num).sample
        end
      end
    end
  end

  def possible_next_placement(last_letter, last_num)
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
