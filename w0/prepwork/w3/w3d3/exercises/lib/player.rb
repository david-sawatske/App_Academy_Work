class HumanPlayer
  def get_play
    puts "Where would you like to attack? y, x"
    move = gets.chomp
    move.split(',').map!{ |x|x.to_i }
  end
end
