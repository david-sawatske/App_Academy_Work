class RPNCalculator
  attr_accessor :stack

  def initialize
    @stack = []
  end

  def value
    stack.last
  end

  def push(value)
    stack << value.to_f
  end

  def pop
    value = stack.pop

    raise 'calculator is empty' if value.nil?

    value
  end

  def plus
    stack << pop + pop
  end

  def minus
    last = stack.pop
    stack << pop - last
  end

  def divide
    last = stack.pop
    stack << pop / last
  end

  def times
    stack << pop * pop
  end

  def tokens(function_string)
    function_string.split.map do |x|
      if '+,-,*,/'.chars.include?(x)
        x.to_sym
      else
        x.to_f
      end
    end
  end

  def evaluate(function_string)
    tokens(function_string).each do |x|
      case x
      when :+
        plus
      when :-
        minus
      when :*
        times
      when :/
        divide
      else
        push x
      end
    end
    value
  end
end
