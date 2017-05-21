require "pry"
require_relative "cell"

class Grid
  attr_reader :board

  def initialize
    @board = {}
  end

  def board_setup(bottom_right)
    ('A'..bottom_right[0]).to_a.each do |letter|
      board[letter] = Hash.new
      ('1'..bottom_right[1]).to_a.each do |num|
        board[letter][num] = Cell.new
      end
    end
  end

  def layout_board
    board.map do |key, value|
      value.map do |key, value|
        value.status
      end
    end
  end

  def space_occupied?(coord)
    board[coord[0]][coord[1]].occupied
  end

  def place_ship_at(coord)
    return nil if space_occupied?(coord)
    space = board[coord[0]][coord[1]]
    space.place_ship
  end

  def shoot_at(coord)
    board[coord[0]][coord[1]].shoot_at
  end
end
