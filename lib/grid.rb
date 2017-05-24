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
      ('1'..bottom_right[1..2]).to_a.each do |num|
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

  def place_ship_at(coord, ship)
    return nil if space_occupied?(coord)
    space = board[coord[0]][coord[1..2]]
    space.place_ship(ship)
  end

  def shoot_at(coord)
    board[coord[0]][coord[1]].shoot_at
  end

  def available_slots
    slots = board.map do |row, value|
      value.map do |key, value|
        row+key
      end
    end
    slots.flatten
  end
end
