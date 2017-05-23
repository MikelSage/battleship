class Ship
  attr_reader :size, :coordinates
  attr_accessor :orientation
  def initialize(size=2)
    @size   = size
    @coordinates = []
    @orientation = 'horizontal'
  end

  def add_coordinate(coord)
    coordinates << coord
  end
end
