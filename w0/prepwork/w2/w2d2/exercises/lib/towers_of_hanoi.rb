class TowersOfHanoi
  attr_reader :towers

  def initialize
    @towers = [[3, 2, 1], [], []]
  end

  def play
    until won?
      puts "From what tower?"
      from_tower = gets.chomp.to_i - 1

      puts "To which tower?"
      to_tower = gets.chomp.to_i - 1

      if valid_move?(from_tower, to_tower)
        move(from_tower, to_tower)
        display
      else
        puts "That's not a valid move!"
      end
    end

    puts "Big Winner!!!"
  end

  def move(from_tower, to_tower)
    @towers[to_tower] << @towers[from_tower].pop
  end

  def valid_move?(from_tower, to_tower)
    if @towers[to_tower].empty? || (@towers[from_tower].last < @towers[to_tower].last)
      true
    else
      false
    end
  rescue
    puts "That's not a valid move!"
  end

  def won?
    (1..2).any? { |i| @towers[i].count == 3 }
  end

  def display
    p "Tower 1:  #{@towers[0]}"
    p "Tower 2:  #{@towers[1]}"
    p "Tower 3:  #{@towers[2]}"
  end
end

if __FILE__ == $0
  game = TowersOfHanoi.new

  game.display
end
