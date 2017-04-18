class Hangman
  attr_reader :guesser, :referee, :board

  def initialize(players = { referee: ComputerPlayer.new,
                             guesser: HumanPlayer.new })
    @referee = players[:referee]
    @guesser = players[:guesser]
    @freq_table = Hash.new(0)
    @board = []

  end

  def setup
    word_length = @referee.pick_secret_word
    @guesser.register_secret_length(word_length)
    @board = ["_"] * word_length
  end

  def take_turn
    guess = @guesser.guess
    check = @referee.check_guess(guess)
    response = @referee.check_guess(guess, board)
    update_board(response, check) unless check.nil?
    @guesser.handle_response(guess, check)
  end

  def update_board(guess, response)
    response.each { |index| @board[index] = guess }
  end
end

class HumanPlayer

  def initialize
  end

  def handle_response(letter, indices)
  end

  def pick_secret_word
    puts "How many letters is your word?"
    gets.chomp.to_i
  end

  def register_secret_length(length)
    @secret_length = length
  end

  def guess(board)
    puts "Letter, please"
    guess = gets.chomp.downcase
    guess.to_s
  end
end

class ComputerPlayer
  attr_reader :secret_word, :dictionary

  def initialize(dictionary=File.new("/Users/a7/Desktop/david_sawatske/w3/w3d4/exercises/lib/dictionary.txt").readlines)
    @dictionary = dictionary
    @secret_word = secret_word
  end

  def pick_secret_word
    @secret_word = @dictionary.sample

    @secret_word.length
  end

  def check_guess(letter)
    @secret_word.enum_for(:scan, letter).map { Regexp.last_match.begin(0) }
  end

  def handle_response(letter, indices)
    @dictionary = @dictionary.select do |word|
      indices.all? { |j| word[j] == letter }
    end

    @dictionary = @dictionary.reject { |word| word.count(letter) > indices.count }
  end

  def register_secret_length(length)
    @secret_length = length
    @dictionary = @dictionary.select { |word| word.length == length }
  end

  def guess(board)
    @freq_table.max_by { |letter, count| count }
  end

  def candidate_words
    @dictionary
  end

  def freq_table(board)
    @candidate_words.each do |word|
      @board.each_with_index do |letter, index|
        @freq_table[word[index]] += 1 if letter.nil?
      end
    end
  end
end
