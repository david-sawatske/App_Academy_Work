
class Player
  ALPHABET = ("a".."z").to_a
  attr_reader :name, :guess

  def initialize(name)
    @name = name
    @guess = ""
  end

  def guess
    print ("Enter a letter: ")
    @guess = gets.chomp.to_s.downcase
  end

  def alert_invalid_play
    raise "That is an invalid guess"
  end
end
;
