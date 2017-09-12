require_relative 'cursor'

class Display

  attr_reader :cursor, :board, :errors
  attr_accessor :game_info

  def initialize(board)
    @board = board
    @cursor = Cursor.new([0,0], board)
    @game_info = ""
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
    puts game_info.colorize(random_color)
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
