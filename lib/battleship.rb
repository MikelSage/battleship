require_relative 'player'
require_relative 'computer_player'
require_relative 'grid'
require_relative 'ship'
require_relative 'validator'
require_relative 'game'
puts 'Welcome to Battleship!'

include Validator
game = Game.new

while true
  puts 'Would you like to (p)lay, read the (i)nstructions, or (q)uit?'
  answer = gets.chomp.downcase

  if answer == 'p'
    break
  elsif answer == 'i'
    puts 'Here are the instructions.'
    puts '=' * 10
  elsif answer == 'q'
    puts 'Goodbye!'
    exit 1
  else
    puts 'Invalid selection'
    puts '=' * 10
  end
end

game.setup

game.computer_place_ships
puts 'I placed my ships. Do the same.'
puts 'You have a 2 unit ship and a 3 unit ship.'

game.player_place_ship

puts 'Great, let us begin!'

game.players_take_shots

puts 'Somebody won!'
