def factor(num)
  1.upto(num).select{|x| num%x == 0}
end

class Array
  def bubble_sort!(&prc)
    (0...self.length-1).each do |i|
      (i+1...self.length).each do |j|
        self[i], self[j] = self[j], self[i] if yield(self[i], self[j])
      end
    end

    self
  end

  def bubble_sort(&prc)
    self.dup.bubble_sort!(&prc)
  end
end

def substrings(string)
  ret = []

  1.upto(string.length).each do |i|
    string.chars.each_cons(i) do |substr|
      ret << substr.join unless ret.include?(substr.join)
    end
  end

  ret
end

def subwords(word, dictionary)
  substrings(word).select { |sub_word| dictionary.include?(sub_word) }
end

p [1,2,3,4,5].bubble_sort! { |num1, num2| num1 <=> num2 } == [5, 4, 3, 2, 1]
