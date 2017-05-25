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
    if @ship
      @status = 'H'
      @ship.hit(coord)
    else
      @status = 'M'
    end
  end
end
