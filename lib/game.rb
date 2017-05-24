require_relative 'player'
require_relative 'computer_player'
require_relative 'grid'

class Game
  attr_reader :player, :computer
  def initialize
    @player = nil
    @computer = nil
  end

  def setup
    @player = Player.new
    @computer = ComputerPlayer.new
  end
end
