class Temperature
  def initialize(options = {})
    if options.key?(:f)
      @f = options[:f]
      @c = ftoc(options[:f])
    else
      @c = options[:c]
      @f = ctof(options[:c])
    end
  end

  def in_fahrenheit
    @f
  end

  def in_celsius
    @c
  end

  def ftoc(temp)
    (temp - 32.0) * (5.0 / 9.0)
  end

  def ctof(temp)
    temp * (9.0 / 5.0) + 32
  end

  def self.from_celsius(f)
    new(c: f)
  end

  def self.from_fahrenheit(c)
    new(f: c)
  end
end

class Celsius < Temperature
  def initialize(c)
    super(c: c)
  end
end

class Fahrenheit < Temperature
  def initialize(f)
    super(f: f)
  end
end
