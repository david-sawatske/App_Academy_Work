# Back in the good old days, you used to be able to write a darn near
# uncrackable code by simply taking each letter of a message and incrementing it
# by a fixed number, so "abc" by 2 would look like "cde", wrapping around back
# to "a" when you pass "z".  Write a function, `caesar_cipher(str, shift)` which
# will take a message and an increment amount and outputs the encoded message.
# Assume lowercase and no punctuation. Preserve spaces.
#
# To get an array of letters "a" to "z", you may use `("a".."z").to_a`. To find
# the position of a letter in the array, you may use `Array#find_index`.

def caesar_cipher(str, shift)
  alpha = ('a'..'z').to_a

  str.split(' ').map do |word|
    word.chars.map { |x| alpha[(alpha.index(x) + shift) % 26] }.join
  end.join(' ')
end

# Write a method, `digital_root(num)`. It should Sum the digits of a positive
# integer. If it is greater than 10, sum the digits of the resulting number.
# Keep repeating until there is only one digit in the result, called the
# "digital root". **Do not use string conversion within your method.**
#
# You may wish to use a helper function, `digital_root_step(num)` which performs
# one step of the process.

def digital_root(num)

  while num > 10
    num = digital_root_step(num)
  end

  num
end

def digital_root_step(num)
  sum = 0

  while num > 0
    sum += num % 10

    num /= 10
  end

  sum
end

# Jumble sort takes a string and an alphabet. It returns a copy of the string
# with the letters re-ordered according to their positions in the alphabet. If
# no alphabet is passed in, it defaults to normal alphabetical order (a-z).

# Example:
# jumble_sort("hello") => "ehllo"
# jumble_sort("hello", ['o', 'l', 'h', 'e']) => 'ollhe'

def jumble_sort(str, alphabet = nil)
  return str.split(//).sort.join if alphabet.nil?

  str.split(//).sort_by { |x| alphabet.index(x) }.join
end

class Array
  # Write a method, `Array#two_sum`, that finds all pairs of positions where the
  # elements at those positions sum to zero.

  # NB: ordering matters. I want each of the pairs to be sorted smaller index
  # before bigger index. I want the array of pairs to be sorted
  # "dictionary-wise":
  #   [0, 2] before [1, 2] (smaller first elements come first)
  #   [0, 1] before [0, 2] (then smaller second elements come first)

  def two_sum
    pairs = []

    self.each_index do |i1|
      for i2 in i1 + 1...self.length
        pairs << [i1, i2] if self[i1] + self[i2] == 0
      end
    end

    pairs
  end
end

class String
  # Returns an array of all the subwords of the string that appear in the
  # dictionary argument. The method does NOT return any duplicates.

  def real_words_in_string(dictionary)
    words = []
    length = self.length

    1.upto(length) do |x|
      self.chars.each_cons(x) do |seg_arr|
        segment = seg_arr.join

        if dictionary.include?(segment) && !words.include?(segment)
          words << segment
        end
      end
    end

    words.reverse
  end
end

# Write a method that returns the factors of a number in ascending order.

def factors(num)
  1.upto(num).select { |x| num % x == 0 }
end
