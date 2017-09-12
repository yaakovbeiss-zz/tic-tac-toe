class Board

  attr_reader :size, :grid

  # size allows for variable grid size
  def initialize(size = 3)
    @size = size
    @grid = Array.new(size) { Array.new(size) }
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

  def full?
    grid.flatten.all? { |pos| pos != nil }
  end

  def out_of_bounds?(pos)
    pos.any? { |x| x < 0 || x > size - 1}
  end

end
