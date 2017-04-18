require_relative 'board'
require_relative 'player'

class BattleshipGame
  attr_reader :board, :player, :move

  def initialize(player, board)
    @player = player
    @board = board
  end

  def play
    setup
    @board.display

    until @board.won?
      play_turn
      @board.display
    end
  end

  def attack(move)
    position = @board[move]
    if position.nil?
      position = :x
    elsif position == :s
      position = :o
    else
      "That spot has been bombed"
    end
  end

  def count
    @board.count
  end

  def game_over?
    @board.won?
  end

  def play_turn
    move = @player.get_play(@board)
    puts (@board.hit?(move) ? "You Hit!" : "Miss")
    attack(move)
  end

  def setup
    (0..9).each {@board.place_random_ship}
    @board.find_hidden_ships
  end
end
