require './lib/game'

puts "Player 1 name:"
p1_name = gets.chomp || 'Matt'

puts "Player 2 name:"
p2_name = gets.chomp || 'Anthony'

game = Game.new(p1_name, p2_name)

game.start_message.each { |line| puts line }

input = gets.chomp

game.start if input.downcase == 'go'