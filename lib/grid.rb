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
end
