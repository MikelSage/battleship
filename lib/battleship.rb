require_relative 'player'
require_relative 'computer_player'
require_relative 'grid'
require_relative 'ship'
require_relative 'validator'
puts 'Welcome to Battleship!'

include Validator

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

player_grid = Grid.new
player_grid.board_setup('D4')
frigate = Ship.new
destroyer = Ship.new(3)

cpu_grid = Grid.new
cpu_grid.board_setup('D4')

cpu = ComputerPlayer.new(cpu_grid, player_grid)
player = Player.new(player_grid, cpu_grid)

cpu.place_ships
puts 'I placed my ships. Do the same.'
puts 'You have a 2 unit ship and a 3 unit ship.'
puts 'Place your 2 unit ship'

frigate_coords = gets.chomp.upcase.split

while Validator.invalid_coordinates?(frigate_coords, frigate, player_grid)
  puts 'Those coordinates are invalid, try again'
  frigate_coords = gets.chomp.upcase.split
end

player.place_ship(frigate_coords, frigate)

puts 'Now place your 3 unit ship'

destroyer_coords = gets.chomp.upcase.split

while Validator.invalid_coordinates?(destroyer_coords, destroyer, player_grid)
  puts 'Those coordinates are invalid, try again'
  destroyer_coords = gets.chomp.upcase.split
end

player.place_ship(destroyer_coords, destroyer)

puts 'Great, let us begin!'

while (cpu.lives > 0 || player.lives > 0)
  cpu_grid.print_results
  player_grid.print_results

  puts 'Pick a coordinate to shoot at: '
  coordinate = gets.chomp.upcase

  player.shoot_at(coordinate)
  cpu.shoot_randomly(player_grid)
end
