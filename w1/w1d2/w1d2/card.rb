class Card
  attr_reader :back, :front, :revealed


  def initialize(front)
    @front = front
    @back = "A"
    @revealed = false
  end

  def reveal
    @revealed = true
  end

  def hide
    @revealed = false
  end

  def show_card
    @revealed ? @front : @back
  end

  def revealed?
    @revealed ? true : false
  end

  def to_s
  end

end

a = [1, 2]
a + a
