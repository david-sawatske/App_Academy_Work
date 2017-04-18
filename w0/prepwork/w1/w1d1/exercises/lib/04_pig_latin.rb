def translate(s)
  pigged = s.split(' ').map { |word| pig(word) }

  pigged.map { |word| retain_caps(punct(word)) }.join(' ')
end

def pig(str)
  cons = ('a'..'z').to_a - 'aeiou'.chars - ['q']

  str << str.slice!(/(#{cons}|qu|q)*/i) + "ay"
end

def retain_caps(word)
  word =~ /[A-Z]/ ? word.capitalize : word
end

# Test-driving bonus:
# * write a test asserting that capitalized words are still capitalized (but with a different initial capital letter, of course)
# * retain the punctuation from the original phrase

def punct(word)
  word.chars.partition {|x| '.,;!?'.chars.include?(x)}.rotate.join
end
