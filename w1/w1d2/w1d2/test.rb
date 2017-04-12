# def populate
#   half = @grid.size / 2
#   non_paired_cards = []
#
#   while cards.count < half
#     cards << rand(1..0)
#   end
# end
#
# paired_cards = non_paired_cards + non_paired_cards
#
# paired_cards.shuffle
#
#
#
#
#
# def populate
#
#  half = @grid.size
#  values = []
#  i = 0
#  while i < half / 2
#    @grid[i].map! {|el| el = Card.new}
#    i+=1
#  end
#  i = half / 2
#  values.shuffle!
#  while i < @grid.size
#    @grid[i].map! {|el| el = values.pop}
#    i+=1
#  end
#  render


h = {1 => [2,4], 2 => [1,1]}
t = h.reject {|k, v| k == 1}
p t
