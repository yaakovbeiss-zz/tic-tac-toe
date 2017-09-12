require_relative 'board'
require_relative 'player'

class Game

  attr_reader :players, :current_player
  attr_accessor :board, :display

  def initialize(board = Board.new, display, players)
    @board = board
    @display = display
    players.first.symbol = :X
    players.last.symbol = :O
    @players = {
      X: players.first,
      O: players.last,
    }
    @current_player = @players[:X]
  end

  def game_over?
    if winner?
      puts "#{current_player.name} has won!".colorize(random_color)
      true
    elsif board.full?
      puts "Tie game.".colorize(random_color)
      true
    else
      false
    end
  end

  # checks all rows of grid to see if current_player's symbol fills all spaces
  def check_rows
    board.grid.any? do |row|
      row.all? { |x| x == current_player.symbol }
    end
  end

  # transposes grid so that columns of grid become rows and then checks each row
  # to see if current_player's symbol fills all spaces
  def check_columns
    transposed = board.grid.transpose
    transposed.any? do |row|
      row.all? { |x| x == current_player.symbol }
    end
  end

  # creates two new arrays, each array representing one diagonal, then checks each
  # diagonal to see if current_player's symbol fills all spaces
  def check_diagonals
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
    puts "Would you like to play again? y/n".colorize(random_color)
    answer = gets.chomp
    if answer == 'y'
      reset_board
      display.game_info = "Lets play again! Winner goes first!".colorize(random_color)
      play
    else
      display.game_info = "Catch you later!".colorize(random_color)
    end
    display.render
  end

  def setup
    display.game_info = "It is #{current_player.name}'s turn.".colorize(random_color)
    display.render
  end

  def reset_board
    @board = Board.new(@board.size)
    @display = Display.new(@board)
  end

  def play
    setup
    loop do
      begin
        move = current_player.make_move(board, display)
        raise ValidMoveError unless board.empty?(move)
      rescue ValidMoveError => e
        puts e.message
        sleep(0.5)
        retry
      end

      board[move] = current_player.symbol
      display.render

      break if game_over?
      switch_players
      display.game_info = "It is #{current_player.name}'s turn.".colorize(random_color)
    end

    play_again?
  end


end

class ValidMoveError < StandardError
  def message
    puts "The position you entered is not empty.".colorize(:red)
  end
end
