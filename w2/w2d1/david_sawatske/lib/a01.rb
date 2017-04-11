class Array
  # Write a method that binary searches an array for a target and returns its
  # index if found. Assume a sorted array

  # NB: YOU MUST WRITE THIS RECURSIVELY (searching half of the array every time).
  # We will not give you points if you visit every element in the array every time
  # you search.

  # For example, given the array [1, 2, 3, 4], you should NOT be checking
  # 1 first, then 2, then 3, then 4.

  def binary_search(target)
    return nil if self.empty?
    mid = length / 2

    case target <=> self[mid]
    when -1
      self.take(mid).binary_search(target)
    when 0
      return mid
    when 1
      x = self.drop(mid+1).binary_search(target)
      x = x + mid + 1 unless x.nil?
    end
  end
end

class Array
  # Write a new `Array#pair_sum(target)` method that finds all pairs of
  # positions where the elements at those positions sum to the target.

  # NB: ordering matters. I want each of the pairs to be sorted
  # smaller index before bigger index. I want the array of pairs to be
  # sorted "dictionary-wise":
  #   [0, 2] before [1, 2] (smaller first elements come first)
  #   [0, 1] before [0, 2] (then smaller second elements come first)

  def pair_sum(target)
    pairs = []

    self.each_index do |i1|
      for i2 in i1 + 1...self.length
        pairs << [i1, i2] if self[i1] + self[i2] == target
      end
    end

    pairs
  end
end

# Write a method called 'sum_rec' that
# recursively calculates the sum of an array of values
def sum_rec(nums)
  return 0 if nums.empty?
  return nums.first if nums.length == 1

  nums.first + sum_rec(nums[1..-1])
end

class String
  # Write a method that finds all the unique substrings for a word

  def uniq_subs
    uniq = []
    for i1 in 0...self.length
      for i2 in i1...self.length
        str = self[i1..i2]
        uniq << str unless uniq.include?(str)
      end
    end

    uniq
  end
end


def prime?(num)
(2...num).select { |n| num % n == 0 }.count == 0
end

# Write a method that sums the first n prime numbers starting with 2.
def sum_n_primes(n)
  return 0 if n == 0
  primes = []

  (2..+1.0/0.0).each do |num|
    primes << num if prime?(num)

    break if primes.length == n
  end

  primes.reduce(&:+)
end


class Array
  # Write a method that calls a passed block for each element of the array
  def my_each(&prc)
    eached = []

    self.length.times do |i|
      eached << prc.call(self[i])
    end

    self
  end
end

class Array
  # Write a method that calls a block for each element of the array
  # and returns a new array made up of the results
  def my_map(&prc)
    mapped = []

    self.length.times do |i|
      mapped << prc.call(self[i])
    end

    mapped
  end
end
