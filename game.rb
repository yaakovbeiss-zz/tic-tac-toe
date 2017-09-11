require 'byebug'
require_relative 'board'
require_relative 'player'
require_relative 'directions'
require_relative 'display'

class Game
  include Directions

  attr_reader :players, :current_player
  attr_accessor :board, :display

  def initialize(board = Board.new, display, players)
    @board = board
    @display = display
    @players = {
      X: players.first,
      O: players.last,
    }
    @current_player = @players[:X]
  end

  def game_over?
    if winner?
      puts "#{current_player.name} has won!"
      true
    elsif board.full?
      puts "Tie game."
      true
    else
      false
    end
  end

  def check_rows
    # checks all rows of grid to see if current_player's symbol fills all spaces
    board.grid.any? do |row|
      row.all? { |x| x == current_player.symbol }
    end
  end

  def check_columns
    # transposes grid so that columns of grid become rows and then checks each row
    # to see if current_player's symbol fills all spaces
    transposed = board.grid.transpose
    transposed.any? do |row|
      row.all? { |x| x == current_player.symbol }
    end
  end

  def check_diagonals
    # creates two new arrays, each array representing one diagonal, then checks each
    # diagonal to see if current_player's symbol fills all spaces
    size = board.size - 1
    (0...board.size).collect {|i| board.grid[i][i]}.all? { |x| x == current_player.symbol } ||
    (0...board.size).collect {|i| board.grid[size - i][i]}.all? { |x| x == current_player.symbol }
  end

  def winner?
    check_rows || check_columns || check_diagonals
  end

  def switch_players
    @current_player = (@current_player == @players[:X]) ? @players[:O] : @players[:X]
  end

  def play_again?
    puts "Would you like to play again? y/n"
    answer = gets.chomp
    if answer == 'y'
      reset_board
      display.game_info << "Lets play again!"
      play
    else
      display.game_info << "Catch you later!"
    end
    display.render
  end

  def reset_board
    @board = Board.new(@board.size)
    @display = Display.new(@board)
  end

  def play
    display.render
    loop do
      move = current_player.make_move(display)
      if board.empty?(move)
        board[move] = current_player.symbol
        board.last_move = move
      else
        display.errors << "You can't move there."
      end
      display.render
      break if game_over?
      switch_players
    end

    play_again?
  end


end
