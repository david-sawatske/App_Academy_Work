class Board
  attr_accessor :grid

  def initialize(grid=self.class.default_grid)
    @grid = grid
    @row_length = @grid.length
    @available_spaces = available
  end

  def self.default_grid
    Array.new(10) { Array.new(10, nil) }
  end

  def place_random_ship
    raise "Full!" if full?

    pos = @available_spaces.sample
    @available_spaces.delete(pos)

    self[pos] = :s
  end

  def available
    @grid.flat_map.with_index do |row, row_idx|
      row.each_index.select{ |i| row[i] == nil }.map{|col_idx| [row_idx, col_idx] }
    end
  end

  def won?
    @grid.flatten.none? { |el| el == :s }
  end

  def empty?(pos=nil)
    if pos
      self[pos].nil?
    else
      count == 0
    end
  end

  def full?
    @grid.flatten.none? { |pos| pos.nil? }
  end

  def count
    @grid.flatten.select { |pos| pos == :s }.count
  end

  def display
    column_ids = '    '
    1.upto(@row_length) { |num| column_ids << " #{num}    "}

    @row_length = column_ids.length - 3
    puts column_ids
    puts " #{'-' * @row_length} \n"
    puts formatted_row
  end

  def formatted_row
    alpha = ('a'..'z').to_a
    grid_with_row = ''

    @grid.each.with_index do |row, idx|
      grid_with_row << "#{alpha[idx]} |"

      row.each do |space|
        space == nil ? grid_with_row << "     |" : grid_with_row << "   #{space} |"
      end

      grid_with_row << "\n #{'-' * @row_length} \n"
    end

    grid_with_row
  end

  def [](pos)
    @grid[pos[0]][pos[1]]
  end

  def []=(pos, val)
    row, col = pos
    @grid[row][col] = val
  end
end

if __FILE__ == $0
  b = Board.new
end
