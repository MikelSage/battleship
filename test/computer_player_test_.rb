require 'minitest/autorun'
require "minitest/pride"
require_relative '../lib/computer_player'

class ComputerPlayerTest < Minitest::Test
  attr_reader :cpu
  def setup
    @cpu = ComputerPlayer.new
  end

  def test_it_exists
    assert_instance_of ComputerPlayer, cpu
  end
end
