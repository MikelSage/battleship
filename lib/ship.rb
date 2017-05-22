class Ship
  attr_reader :size, :coordinates
  def initialize(size=2)
    @size   = size
    @coordinates = []
  end

  def add_coordinate(coord)
    coordinates << coord
  end
end
