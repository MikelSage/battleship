require "pry"
module Validator
  def within_one?(char1, char2)
    (char1.ord - char2.ord).abs == 1 unless char1.nil?
  end

  def valid_next_coordinate?(current_coord, next_coord, prev_coord=nil)
    letter0 = prev_coord[0] unless prev_coord.nil?
    letter1, num1 = current_coord[0], current_coord[1]
    letter2, num2 = next_coord[0], next_coord[1]
    if (letter0 == letter1 && !within_one?(num1, num2))
      return false
    elsif (within_one?(letter0, letter1) && !(num1 == num2))
      return false
    elsif (letter1 == letter2 && within_one?(num1, num2))
      return true
    elsif (within_one?(letter1, letter2) && num1 == num2)
      return true
    end
  end

  def invalid_coordinates?(coordinates, ship, grid)
    return true if invalid_format?(coordinates)
    return true if coordinates.length != ship.size
    ((coordinates.length) - 1).times do |time|
      coord = coordinates[time]
      next_coord = coordinates[time + 1]
      prev_coord = coordinates[time - 1]
      return true unless valid_next_coordinate?(coord, next_coord, prev_coord)
      return true if already_occupied?(grid, coordinates[time])
    end
    return false
  end

  def already_occupied?(grid, coord)
    grid.space_occupied?(coord)
  end

  def any_occupied?(grid, coords)
    coords.any? { |coord| grid.space_occupied?(coord) }
  end

  def invalid_format?(coords)
    coords.any? { |coord| (/[A-Z]/.match(coord[0]).nil? || coord[1].to_i == 0) }
  end
end
