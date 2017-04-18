def add(*args)
  args.reduce(:+)
end

def subtract(*args)
  args.reduce(:-)
end

def sum(array)
  array.reduce(0, :+)
end

def multiply(*args)
  args.reduce(&:*)
end

def power(*args)
  args.reduce(&:**)
end

def factorial(number)
  return 1 if number == 0
  1.upto(number).reduce(&:*)
end
