require "byebug"
require_relative "card"

class Board
  attr_reader = :grid

  def initialize
    @grid = Array.new(2) {Array.new(2)}
    populate
  end

  def won?
    @grid.each do |row|
      row.each {|card| return false if card.show_card == "A"}
    end
    true
  end

  def populate
    half = (@grid.size ** 2) / 2
    non_paired_cards = []
    while non_paired_cards.count < half
      non_paired_cards << rand(1..99)
    end
    paired_cards = non_paired_cards + non_paired_cards
    paired_cards.shuffle
    @grid.map! do |row|
      row.map! {|el| el = Card.new(paired_cards.pop)}
    end
  end

  def match?(pos1, pos2)
    card1 = self[pos1]
    card2 = self[pos2]
    if card1.show_card != card2.show_card
      card1.hide
      card2.hide
    end
  end

  def reveal(pos)
    card = self[pos]
    if valid_move?(card)
      card.reveal
      render
      return card.show_card
    else
      return false
    end
  end

  def display_card

  end

  def valid_move?(card)
    return false if card.revealed?
    true
  end

  def []=(loc, val)
debugger
    row = loc[0]
    col = loc[1]
    @grid[row][col] = val
  end

  def [] (loc)

    row = loc[0]
    el = loc[1]
    @grid[row][el]
  end

  def render
    @grid.each do |pos|
      p pos.map { |el| el.show_card }
    end
  end
end
