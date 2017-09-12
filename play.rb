require_relative 'game'
require_relative 'player'
require_relative 'display'
require_relative 'board'
require 'faker'
require 'colorize'

def get_answer
  answer = ''
  until answer == 'y' || answer == 'n'
    puts "Please enter y or n".colorize(random_color)
    answer = gets.chomp
  end
  answer
end

def random_color
  String.colors.sample
end

puts "Welcome to Tic Tac Toe!".colorize(random_color)

board_size = nil
until board_size
  puts "Please enter the board size: ".colorize(random_color)
  board_size = gets.chomp.to_i
  board_size = nil if board_size < 2 || !board_size.is_a?(Integer)
end

board = Board.new(board_size)
display = Display.new(board)

puts "Please enter player one's name: ".colorize(random_color)
human_player1_name = gets.chomp
player1 = HumanPlayer.new(human_player1_name)


puts "Would you like to play against the computer? y/n".colorize(random_color)
answer = get_answer
if answer == 'y'
  computer_player_name = Faker::LordOfTheRings.character
  player2 = ComputerPlayer.new(computer_player_name)
  puts "You are playing against #{computer_player_name}.".colorize(random_color)
  sleep(0.7)
elsif answer == 'n'
  puts "Please enter player two's name: ".colorize(random_color)
  human_player2_name = gets.chomp
  player2 = HumanPlayer.new(human_player2_name)
end

puts "Would you like to go first? y/n".colorize(random_color)
answer = get_answer

answer == 'y' ? players = [player1, player2] : players = [player2, player1]

game = Game.new(board, display, players)
game.play
