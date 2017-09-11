class Player

  attr_reader :name, :symbol, :display
  attr_accessor :last_move

  def initialize(name, symbol, display)
    @name = name
    @symbol = symbol
    @display = display
  end

end

class HumanPlayer < Player

  def initialize(name, symbol, display)
    super(name, symbol, display)
  end

  def make_move
    new_pos = nil
    until new_pos
      display.render
      new_pos = display.cursor.get_input
    end
    new_pos
  end

end

class ComputerPlayer < Player

  attr_reader :board

  def initialize(name, symbol, display, board)
    super(name, symbol, display)
    @board = board
  end

  def make_move
    board.empty_spaces.sample
  end

end
