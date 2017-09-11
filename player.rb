class Player

  attr_reader :name, :symbol
  attr_accessor :last_move

  def initialize(name, symbol)
    @name = name
    @symbol = symbol
  end

end

class HumanPlayer < Player

  def initialize(name, symbol)
    super(name, symbol)
  end

  def make_move(display)
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

  def initialize(name, symbol, board)
    super(name, symbol)
    @board = board
  end

  def make_move(display)
    board.empty_spaces.sample
  end

end
