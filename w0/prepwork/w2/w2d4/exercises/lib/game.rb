require_relative 'board'
require_relative 'human_player'
require_relative 'computer_player'

class Game
  attr_reader :board, :player1, :player2, :current_player

  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @player1.mark = :X
    @player2.mark = :O
    @board = Board.new
    @current_player = @player1
  end

  def play
    until @board.over?
      play_turn
    end
  end

  def play_turn
    @current_player.display
    move = @current_player.get_move
    @board.place_mark(move, @current_player.mark)
    switch_players!
  end

  def switch_players!
    @current_player = @current_player == @player1 ? @player2 : @player1
  end
end
