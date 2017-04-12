class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    sum = 0
    self.each_with_index do |el, idx|
      sum += el.hash * idx
    end
    sum
  end
end

class String
  def hash
    array = self.chars
    sum = 0
    array.each_with_index do |el, idx|
      sum += el.ord.hash * idx
    end
    sum
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    nested_array = self.to_a.sort_by { |arr| arr[0] }
    sum = 0
    nested_array.each do |arr|
      sum += arr[0].to_s.ord.hash
      if arr[1].is_a? Integer
        sum += arr[1].hash
      elsif arr[1] == true
        sum += true.hash
      else
        sum += arr[1].ord.hash
      end
    end
    sum
  end
end
