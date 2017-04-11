require_relative 'board'

class HumanPlayer
  attr_reader :name, :board
  attr_accessor :mark

  def initialize(name)
    @name = name
  end

  def display(board)
    @board = board
    board.grid.each.with_index do |row, i|
      puts "  #{board_spacer(row[0])}   |  #{board_spacer(row[1])}   |  #{board_spacer(row[2])}"
      puts "      |      | "
      puts "____________________" unless i == 2
    end
  end

  def board_spacer(spot)
     spot.nil? ?  " " : spot
  end

  def get_move
    puts "Where would you like to move? (row, col)"
    gets.chomp.split(",").map(&:to_i)
  end
end

if __FILE__ == $0
  h = HumanPlayer.new('test')
  b = Board.new

  [[0, 0], [1, 1], [2, 2]].each do |position|
    b.place_mark(position, :O)
  end

  [[2, 0]].each do |position|
    b.place_mark(position, :X)
  end


  p h.display(b)
end
