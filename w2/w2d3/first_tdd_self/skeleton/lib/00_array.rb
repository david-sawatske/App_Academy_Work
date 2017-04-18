def my_uniq(array)
  uniqs = []

  array.each { |el| uniqs << el unless uniqs.include?(el) }

  uniqs
end

class Array
  def two_sum
    pairs = []

    self.each_index do |i|
      for j in i + 1...self.length
        pairs << [i, j] if self[i] + self[j] == 0
      end
    end

    pairs
  end
end

def my_transpose(rows)
  dimension = rows.first.count
  cols = Array.new(dimension) { Array.new(dimension) }

  dimension.times do |i|
    dimension.times do |j|
      cols[j][i] = rows[i][j]
    end
  end

  cols
end

def pick_stocks(prices)
  best_pair = nil
  best_profit = 0

  prices.each_index do |buy_date|
    prices.each_index do |sell_date|
      next if sell_date < buy_date

      profit = prices[sell_date] - prices[buy_date]
      if profit > best_profit
        best_pair, best_profit = [buy_date, sell_date], profit
      end
    end
  end

  best_pair
end
