require 'byebug'

class Board

  attr_reader :size, :grid
  attr_accessor :last_move

  def initialize(size = 3)
    @size = size
    @grid = Array.new(size) { Array.new(size) }
    @last_move = nil
  end

  def [](pos)
    x, y = pos
    @grid[x][y]
  end

  def []=(pos, val)
    x, y = pos
    @grid[x][y] = val
  end

  def empty?(pos)
    self[pos].nil?
  end

  def empty_spaces
    spaces = []
    grid.each_with_index do |row, row_idx|
      row.each_with_index do |_, col_idx|
        pos = [row_idx, col_idx]
        spaces << pos if self.empty?(pos)
      end
    end
    spaces
  end

  def full?
    grid.flatten.all? { |pos| pos != nil }
  end

  def out_of_bounds?(pos)
    pos.any? { |x| x < 0 || x > size - 1}
  end

end
