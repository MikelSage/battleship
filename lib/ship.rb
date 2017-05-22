class Ship
  attr_reader :size, :coordinates, :orientation
  def initialize(size=2)
    @size   = size
    @coordinates = []
    @orientation = 'horizontal'
  end

  def add_coordinate(coord)
    coordinates << coord
  end

  def make_vertical
    @orientation = 'vertical'
  end
end
