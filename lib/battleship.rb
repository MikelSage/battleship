require_relative 'game'
puts 'Welcome to Battleship!'

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

if game.winner.class == Player
  puts 'You won!'
else
  puts "You lost... somehow."
end

game.endgame_stats
