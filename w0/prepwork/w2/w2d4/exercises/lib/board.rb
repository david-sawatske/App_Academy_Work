class Board
  attr_reader :grid

  def initialize(grid=Array.new(3) { Array.new(3) })
    @grid = grid
    @marks = [:X, :O]
    @marked = { X: [], O: [] }
  end

  def [](pos)
    row, col = pos
    grid[row][col]
  end

  def []=(pos, mark)
    grid[pos[0]][pos[1]] = mark
  end

  def place_mark(pos, mark)
    if empty?(pos) == true
      self[pos] = mark
    elsif false
      "#{self[pos]} is already filled!"
    end
  end

  def empty?(pos)
    self[pos].nil?
  end

  def winner
    return :X if check_mark(:X)
    return :O if check_mark(:O)
  end

  def over?
    grid.flatten.none? { |el| el.nil? } || !winner.nil?
  end

  def check_mark(mark)
    comb_sets = three_combo(@marked[mark])

    if comb_sets.count == 0
      false
    elsif comb_sets.count == 1
      line?(set)
    elsif comb_sets.count > 1
      comb_sets.any? { |set| line?(set) }
    end
  end

  def three_combo(marked)
    marked.flatten.combination(3).to_a
  end

  def marked_positions(mark)
    0.upto(2) do |row|
      0.upto(2) do |col|
        @marked[mark] << [row, col] if grid[row][col] == mark
      end
    end
  end

  def line?(set) #only send sets of 3
    a = set[0]
    b = set[1]
    c = set[2]

    a[0] * (b[1] - c[1]) + b[1] * (c[1] - a[1]) + c[0] * (a[1] - b[1]) == 0
  end
end

if __FILE__ == $0
  b = Board.new

  [[1, 1]].each do |position|
    b.place_mark(position, :X)
  end

  [[0, 0], [1, 0]].each do |position|
    b.place_mark(position, :O)
end

b.marked_positions(:X)
b.marked_positions(:O)

p b.grid
p b.winner
p b.over?
end
