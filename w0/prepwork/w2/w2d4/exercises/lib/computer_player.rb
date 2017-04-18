require_relative 'board'

class ComputerPlayer
  attr_reader :name, :board
  attr_accessor :mark

  def initialize(name, mark = nil)
    @name = name
    @mark = mark
  end

  def display(board)
    @board = board
    board.grid
  end

  def get_move
    possible_moves = [0, 1, 2].permutation(2).to_a.select do |pos|
      board[pos].nil?
    end

    possible_moves.each {|move| return move if winning_move?(move)}

    possible_moves.sample
  end

  def winning_move?(move)
    board[move] = @mark
    if board.winner.nil?
      false
    else
      true
    end
  end
end
