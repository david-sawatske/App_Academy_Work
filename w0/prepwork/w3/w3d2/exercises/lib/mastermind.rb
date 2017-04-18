class Code
  PEGS = {
    "B" => :blue,
    "G" => :green,
    "O" => :orange,
    "P" => :purple,
    "R" => :red,
    "Y" => :yellow
  }
  attr_reader :pegs

  def initialize(pegs)
    @pegs = pegs
    @exacts = []
  end

  def self.parse(input)
    pegs = input.upcase.split(//).map do |l|
      if PEGS.include?(l)
        PEGS[l]
      else
        raise "error"
      end
    end

    Code.new(pegs)
  end

  def self.random
    pegs = []
    4.times { pegs << PEGS.values.sample }

    Code.new(pegs)
  end

  def [](idx)
    pegs[idx]
  end

  def exact_matches(other_code)
    pegs.select.with_index { |peg, idx| peg == other_code[idx] }.count
  end

  def near_matches(other_code)
    (other_code.pegs & pegs).count - exact_matches(other_code)
  end

  def ==(other_code)
    if other_code.class == Code
      return true if self.pegs == other_code.pegs
    end

    false
  end
end

class Game
  attr_reader :secret_code

  def initialize(secret_code=Code.random)
    @secret_code = secret_code
  end

  def get_guess
    puts "Guess the code in the form of 4 letters"

    begin
      Code.parse(gets.chomp)
    rescue
      puts "Error!, please try again."
      retry
    end
  end

  def display_matches(guess)
    exacts = @secret_code.exact_matches(guess)
    nears = @secret_code.near_matches(guess)

    puts "You got #{exacts} exact matches!"
    puts "You got #{nears} near matches!"
  end
end

if __FILE__ == $0
pegs = Code.new("oooo".split(//))
code2 = Code.new("bboy".split(//))

p pegs.exact_matches(code2)
p pegs.near_matches(code2)
end
