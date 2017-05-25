class Cell
  attr_reader :occupied, :status, :ship
  def initialize
    @occupied = false
    @status = ' '
    @ship = nil
  end

  def place_ship(ship)
    @occupied = true
    @ship = ship
  end

  def shoot_at(coord)
    @occupied ? @status = 'H' : @status = 'M'
    @ship.hit(coord) if @ship
  end
end
