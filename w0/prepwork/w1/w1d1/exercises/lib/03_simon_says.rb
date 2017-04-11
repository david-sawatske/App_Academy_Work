def echo(string)
  string
end

def shout(string)
  string.upcase
end

def repeat(str, times=2)
  ([str] * times).join(' ')
end

def start_of_word(str, num)
  str.chars.first(num).join
end

def first_word(string)
  string.split.first
end

def titleize(string)
  little_words = %w(and the over) # little_words only taken from spec file

  string.split.map.with_index do |word, i|
    little_words.include?(word) && i != 0 ? word.downcase : word.capitalize
  end.join(' ')

  # def titleize(string)
  #   little_words = %w(the and over of)
  #
  #   string.downcase.capitalize.split.map do |word|
  #     little_words.include?(word) ? word : word.capitalize
  #   end.join(' ')
  # end
end
