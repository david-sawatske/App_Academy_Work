class Human
  attr_reader :name, :board

  def initialize(name="Player", board)
    @board = board
    @name = name
  end


  def move
    @board.render
    while !@board.won?
      puts "Which card do you want to turn over?"
       first = turn_card
      puts "Where is its match?"
       second = turn_card
       @board.match?(first, second)
     end
   end

end
