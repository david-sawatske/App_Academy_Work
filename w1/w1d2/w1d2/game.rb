require_relative "board.rb"
require_relative "computer.rb"
class Game
  attr_reader :board, :player

  def initialize
    @board = Board.new
    @move = nil
    @player = Computer.new(@board)
  end

  def player_turn
    @player.move
  end

  def turn_card
    valid = false

    while !valid
      puts "Make a guess"
      move = gets.chomp.scan(/\d+/)
      move.map! {|el| el.to_i}
      if @board.reveal(move) == false
        valid = false
      else
        valid = true
      end
    end
    move
  end

end

if __FILE__ == $0

  g = Game.new
  g.
 end
