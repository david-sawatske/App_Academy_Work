require_relative 'board'

class Computer
  attr_reader :board, :seen_cards

  def initialize(board)
    @board = board
    @seen_cards = {}
    @winning_pair =[]
  end



  def move
    while !@board.won?
      move1 = []
      move2 = []
      if winning_pair.nil?
        pos = random_move
        card_value = @board[pos]
        @seen_cards[card_value] << pos
        move1.empty? ? move1 = pos : move2 = pos
      else
        winners = winning_pair
        move1.empty? ? move1 = winners[0] : move2 = winners[1]
      end
    end
  end

  def random_move
    a = rand(0...@board.length)
    b = rand(0...@board.length)
    [a,b]
  end

  def winning_pair
    winning_pair = @seen_cards.select { |k,v| v.length == 2 }
    @seen_cards.delete_if { |k,v| v.length == 2 }
    winning_pair
  end

end
