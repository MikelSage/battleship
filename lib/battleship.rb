require_relative 'game'
require_relative 'messages'

include Messages
# game = Game.new

puts welcome

while true
  puts opening_prompt
  puts divider
  answer = gets.chomp.downcase

  if answer == 'p'
    break
  elsif answer == 'i'
    puts divider
    puts instructions
    puts divider
  elsif answer == 'q'
    puts divider
    puts goodbye_message
    puts divider
    exit 1
  else
    puts divider
    puts invalid_selection
    puts divider
  end
end

while true
  puts difficulty_message
  puts divider
  answer = gets.chomp.downcase

  if answer == "b"
    game = Game.new(5)
    game.setup('D4')
    break
  elsif answer == 'i'
    game = Game.new(9)
    game.setup('H8')
    break
  elsif answer == 'h'
    game = Game.new(14)
    game.setup('L12')
    break
  else
    puts invalid_selection
  end
end


# game.setup

game.computer_place_ships

puts divider
puts computer_placed_ships
puts divider

game.player_place_ship

puts divider
puts begin_message
puts divider

game.players_take_shots

if game.winner.class == Player
  puts player_win_message
else
  puts computer_win_message
end

game.endgame_stats
