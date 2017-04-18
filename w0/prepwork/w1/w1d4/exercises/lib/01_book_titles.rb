class Book
  attr_accessor :title

  def title=(unformed_title)
    @title = unformed_title.split.map.with_index do |word, i|
      i == 0 ? word.capitalize : title_form(word)
    end.join(' ')
  end

  def title_form(word)
    articles = %w(a an the)
    conjunctions = %w(and or but or so)
    prepositions = %w(in of if by)

    if !(articles + conjunctions + prepositions).include?(word.downcase) || word == 'i'
      word.capitalize
    else
      word.downcase
    end
  end
end
