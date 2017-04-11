require_relative 'player'

class Game
  attr_reader :players, :current_player, :fragment, :dictionary

  def initialize(players, dictionary)
    @players = []
    @fragment = ''
    @dictionary = to_hash(dictionary)
    @current_player = players.first
  end

  def play_round
    take_turn(@current_player)

    next_player!
  end

  def next_player!
    index_of_current = @players.index(@current_player)
    @current_player = @players[(index_of_current + 1) % @players.length]
  end

  def take_turn(player)
    guess = player.guess

    string = @fragment + guess

    until valid_play?(string)
      guess = player.guess
      string = @fragment + guess
    end

    @fragment = string
  end

  def valid_play?(string)
    @dictionary.include?(string)
  end

  private

  def to_hash(dictionary)
    dictionary_h = Hash.new

    dictionary.each {|word| dictionary_h[word] = word}

    dictionary_h
  end
end



if __FILE__ == $PROGRAM_NAME
  dictionary = File.readlines("dictionary.txt").map(&:chomp)
  Game.new(players, dictionary)
end
