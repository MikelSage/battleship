class Validator
  def within_one?(char1, char2)
    (char1.ord - char2.ord).abs == 1
  end
end
