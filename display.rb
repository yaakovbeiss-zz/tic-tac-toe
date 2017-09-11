require_relative 'cursor'
require_relative 'board'
require 'colorize'
require 'byebug'

class Display

  attr_reader :cursor, :board, :errors, :game_info

  def initialize(board)
    @board = board
    @cursor = Cursor.new([0,0], board)
    @game_info = []
    @errors = []
  end

  def render
    system("clear")
    board.grid.each_with_index do |row, row_idx|
      row.each_with_index do |col, col_idx|
        pos = [row_idx, col_idx]
        back_color = background_color(pos)
        if board[pos]
          print "#{board[pos]} ".colorize(background: back_color)
        else
          print "  ".colorize(background: back_color)
        end
      end
      print "\n"
    end
    game_info.map { |info| puts info }
    errors.map { |error| puts error }
    sleep(0.4) unless errors.empty?
    sleep(0.4) unless game_info.empty?
    clear_errors
    clear_game_info
  end

  def clear_errors
    @errors = []
  end

  def clear_game_info
    @game_info = []
  end

  def background_color(pos)
    if pos == @cursor.cursor_pos
     :red
    elsif (pos.all? {|x| x.even? }) || (pos.all? {|y| y.odd?})
      :grey
    else
      :white
    end
  end


end
