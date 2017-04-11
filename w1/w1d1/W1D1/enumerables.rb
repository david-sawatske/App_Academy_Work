class Array
  def my_each
    0.upto(self.length-1) do |i|
      yield self[i]
    end

    self
  end

  def my_select
    ret = []
    self.my_each do |el|
      ret.push(el) if yield el
    end

    ret
  end

  def my_reject
    ret = []
    self.my_each do |el|
      ret << el unless yield el
    end

    ret
  end

  def my_any?
    self.my_each do |el|
      return true if yield el
    end

    false
  end

  def my_flatten
    ret = []
    self.my_each do |el|
      unless el.is_a?(Array)
        ret << el
      else
        ret += el.my_flatten
      end
    end

    ret
  end

  def my_zip(*args)
    ret = []
    (0...self.length).to_a.my_each do |i|
      temp = []
      temp << self[i]
      args.my_each do |arg|
        temp << arg[i]
      end

      ret << temp
    end

    ret
  end

  def my_rotate(r = 1)
    ret = []

    (0...self.length).to_a.my_each do |i|
      new_idx = (i + r) % self.length
      ret << self[new_idx]
    end

    ret
  end

  def my_join(s = '')
    ret = self.first

    (1...self.length).to_a.my_each do |i|
      ret += s + self[i]
    end

    ret
  end

  def my_reverse
    ret = []

    self.my_each do |el|
      ret.unshift(el)
    end
    ret
  end
end
