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
      @board[move] = :x
    elsif position == :s
      @board[move] = :h
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
    move = @player.get_play
    if @board[move] == :s
      puts "Hit!"
    else
      puts "Miss!"
    end
    attack(move)
  end

  def setup
    (0..9).each {@board.place_random_ship}
    @board.find_hidden_ships
  end
end
