# needs to know about how many ships it has
# needs to know about its own grid
# needs to place ships
# needs to shoot at random coordinates
require_relative "ship"

class ComputerPlayer
  attr_reader :lives, :ships

  def initialize(lives=5)
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
    score = lives
    shippies = {}

    possible_ships.each do |ship_name, size|
      if size <= score
        score -= size
        shippies[ship_name] = Ship.new(size)
      end
    end
    shippies
  end
end
