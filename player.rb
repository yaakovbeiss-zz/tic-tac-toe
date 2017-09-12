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

  def make_move(board, display)
    new_pos = nil
    until new_pos
      display.render
      new_pos = display.cursor.get_input
    end
    new_pos
  end

end

class ComputerPlayer < Player

  def initialize(name, symbol)
    super(name, symbol)
  end

  def make_move(board, display)
    winning_moves = find_winning_moves(board)
    return winning_moves.sample unless winning_moves.empty?
    board.empty_spaces.sample
  end

  def find_winning_moves(board)
    winning_moves = []
    winning_moves.concat(winning_rows(board))
    winning_moves.concat(winning_cols(board))
    winning_moves.concat(winning_diags(board))
    return winning_moves
  end

  def winning_rows(board)
    rows = []
    board.grid.each_with_index do |row, row_idx|
      count = row.select {|x| x == symbol }.count
      if count == board.size - 1
        col_idx = row.index(nil)
        rows << [row_idx, col_idx]
      end
    end
    rows
  end

  def winning_cols(board)
    cols = []
    transposed = board.grid.transpose
    transposed.each_with_index do |row, row_idx|
      count = row.select {|x| x == symbol }.count
      if count == board.size - 1
        col_idx = row.index(nil)
        cols << [col_idx, row_idx]
      end
    end
    cols
  end

  def winning_diags(board)
    diags = []
    diag1 = (0...board.size).collect {|i| board.grid[i][i]}
    count = diag1.select {|x| x == symbol }.count
    if count == board.size - 1
      idx = diag1.index(nil)
      # on a top-left to bottom-right diag the indicies will always be equal
      diags << [idx, idx]
    end
    size = board.size - 1
    diag2 = (0...board.size).collect {|i| board.grid[size - i][i]}
    count = diag2.select {|x| x == symbol }.count
    if count == board.size - 1
      idx = diag2.index(nil)
      # if diag2 = [X, X, nil] nil represents [0, 2] on the regular board
      diags << [size - idx, idx]
    end

    diags
  end


end
