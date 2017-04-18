class HumanPlayer
  def turn(board)
    puts "Where would you like to attack? x, y"
    gets.chomp.split(',').map! { |x| x.to_i }
  end
end
