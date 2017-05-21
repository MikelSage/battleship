class Cell
  attr_reader :occupied, :status
  def initialize
    @occupied = false
    @status = ' '
  end

  def place_ship
    @occupied = true
  end

  def shoot_at
    @occupied ? @status = 'H' : @status = 'M'
  end
end
