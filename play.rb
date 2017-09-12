require_relative 'game'
require_relative 'player'
require_relative 'display'
require_relative 'board'
require 'faker'


puts "Welcome to Tic Tac Toe!"

board_size = nil
until board_size
  puts "Please enter the board size: "
  board_size = gets.chomp.to_i
  board_size = nil if board_size < 2 || !board_size.is_a?(Integer)
end

board = Board.new(board_size)
display = Display.new(board)

puts "Please enter player one's name: "
human_player1_name = gets.chomp
player1 = HumanPlayer.new(human_player1_name, :X)


puts "Would you like to play against the computer? y/n"
answer = gets.chomp
if answer == 'y'
  computer_player_name = Faker::LordOfTheRings.character
  player2 = ComputerPlayer.new(computer_player_name, :O)
  puts "You are playing against #{computer_player_name}."
  sleep(0.7)
else
  puts "Please enter player two's name: "
  human_player2_name = gets.chomp
  player2 = HumanPlayer.new(human_player2_name, :O)
end

players = [player1, player2]
game = Game.new(board, display, players)
game.play
