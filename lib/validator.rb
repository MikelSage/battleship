class Validator
  def within_one?(char1, char2)
    (char1.ord - char2.ord).abs == 1 unless char1.nil?
  end

  def valid_next_coordinate?(current_coord, next_coord, prev_coord=nil)
    letter0, num0 = prev_coord[0], prev_coord[1] unless prev_coord.nil?
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
end
