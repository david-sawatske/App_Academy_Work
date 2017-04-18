# I/O Exercises
#
# * Write a `guessing_game` method. The computer should choose a number between
#   1 and 100. Prompt the user to `guess a number`. Each time through a play loop,
#   get a guess from the user. Print the number guessed and whether it was `too
#   high` or `too low`. Track the number of guesses the player takes. When the
#   player guesses the number, print out what the number was and how many guesses
#   the player needed.
def guessing_game
  secret_number = rand(1..100)
  guess_count = 0

  loop do
    puts "Guess a number"
    guess = gets.chomp.to_i
    guess_count += 1

    case secret_number <=> guess
    when -1
      puts "#{guess} is too high"
    when 0
      puts "#{guess} is correct!"
      puts "It took #{guess_count} guesses."
      break
    when 1
      puts "#{guess} is too low"
    end
  end
end

# * Write a program that prompts the user for a file name, reads that file,
#   shuffles the lines, and saves it to the file "{input_name}-shuffled.txt". You
#   could create a random number using the Random class, or you could use the
#   `shuffle` method in array.

def shuffle_file
  puts "What file would you like to shuffle?"
  filename = gets.chomp
  base = File.basename(filename, ".*")
  extension = File.extname(filename)
	lines = File.readlines(filename).shuffle!

	File.open("#{base}-shuffled.#{extension}", "w") do |shuffled|
		lines.each do |line|
			shuffled.puts line
		end
	end
end
