class Board
  attr_accessor :grid, :avalibe_spaces, :ships

  def initialize(grid=self.class.default_grid)
    @grid = grid
    @avalibe_spaces = []
    @row_length = @grid.length
    @ships = { carrier:    Array.new(5, :s),
               battleship: Array.new(4, :s),
               submarine:  Array.new(3, :s),
               destroyer:  Array.new(3, :s),
               patrol:     Array.new(2, :s) }
  end

  def self.default_grid
    Array.new(10) { Array.new(10, nil) }
  end

  def populate_grid
    @ships.each_key do |ship|
      place_random_ship(ship)
    end
  end

  def place_random_ship(ship)
    s = @ships[ship]
    pos = random_position
    ori = random_orientation

    if fit?(pos, ori, s)
      (0...s.length).each do |i|
        if ori == :horizontal
          @grid[0 + 1 + i][0] = s[i]

        elsif ori == :vertical
          @grid[0][0 + 1 + i] = s[i]
        end
      end
    end
  end

  def fit?(position, orientation, ship)
    if orientation == :horizontal
      position[0] + ship.length < @row_length
    elsif orientation == :vertical
      position[1] + ship.length < @row_length
    end
  end

  def random_position
    [rand(0..10), rand(0..10)]
  end

  def random_orientation
    [:horizontal, :vertical].sample
  end

  def won?
    @ships.length == 0
  end

  def hit?(pos)
    @grid[pos] == :s
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
    @grid.flatten.select { |space| space == :s }.count
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

  def test
    @ships
  end
end

if __FILE__ == $0
  b = Board.new
  b.populate_grid
  b.random_position
end
