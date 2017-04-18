NUMS = {
  0 => "zero",
  1 => "one",
  2 => "two",
  3 => "three",
  4 => "four",
  5 => "five",
  6 => "six",
  7 => "seven",
  8 => "eight",
  9 => "nine",
  10 => "ten",
  11 => "eleven",
  12 => "twelve",
  13 => "thirteen",
  14 => "fourteen",
  15 => "fifteen",
  16 => "sixteen",
  17 => "seventeen",
  18 => "eighteen",
  19 => "nineteen",
  20 => "twenty",
  30 => "thirty",
  40 => "forty",
  50 => "fifty",
  60 => "sixty",
  70 => "seventy",
  80 => "eighty",
  90 => "ninety"
}

MAGNITUDES = {
  2 => "thousand",
  3 => "million",
  4 => "billion",
  5 => "trillion"
}

class Fixnum
  def in_words
    word_return =  []
    split_string = self.to_s.reverse.scan(/.{1,3}/).map! { |s| s.reverse }.reverse
    mags = magnitude(split_string)

    split_string.each.with_index do |group, idx|
      word_return << within_group(group)
      word_return << mags[idx] unless group == '000'
    end

    word_return.join(" ").strip.gsub(/\s+/, " ")
  end

  def magnitude(split_string)
    mags = []
    first_mag = split_string.size

    first_mag.downto(2) do |idx|
      mags << MAGNITUDES[idx]
    end

    mags
  end

  def within_group(group)
    return_string = ''

    return "#{NUMS[group.scan(/\d/).first.to_i]}" if group.length == 1

    if group.length == 3 && group.to_i / 100 >= 1
      return_string += "#{NUMS[group.scan(/\d/).first.to_i]} hundred "
    end

    last_two = group.scan(/\d\d$/).first
    if (10..19).include?(last_two[0,2].to_i)
      return_string += NUMS[last_two[0,2].to_i]
    elsif (2..9).include?(last_two[0].to_i)
      return_string += NUMS[last_two[0].to_i * 10]
      if (1..9).include?(last_two[1].to_i)
        return_string += " #{NUMS[last_two[1].to_i]}"
      end
    elsif last_two[0].to_i == 0 && last_two[1].to_i != 0
      return_string += NUMS[last_two[1].to_i]
    end

    return_string
  end
end
