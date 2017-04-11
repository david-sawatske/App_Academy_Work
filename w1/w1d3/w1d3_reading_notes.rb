## Recursion

# A recursive method is one that calls itself. Each time the method
# calls itself, it tries to solve a smaller subproblem. The subproblems keep
# getting smaller and smaller, until they are small enough to solve trivially
# and directly. These small subproblems are called base cases.

def factorial(n)
  if n == 0 # the base case

  else # the recursive case
    n * factorial(n - 1)
  end
end

factorial(3)
# => 3 * factorial(2)
# => 3 * 2 * factorial(1)
# => 3 * 2 * 1 * factorial(0)
# => 3 * 2 * 1 * 1
# => 6


# Mathematical induction
# Solving a problem using the solution(s) to these smaller sub-problems
# uses an important concept called mathematical induction, or induction.
# induction tells us that if we can solve for a base case and we can solve for
# the general (or nth) case, then we have solved for all the cases.


# Recursion vs iteration
# Recursive methods can always be written iteratively: using loops and no recursion.


# Recursion and Infinite Loops
# Recursive calls must always make progress toward a base case.
# If you get caught in a recursive loop, the stack will grow infinitely until the
# system runs out of memory. This is because our methods depend on some method
# closing to close themselves (i.e., the base case)


# Strategies for Programming Recursively
# Map out a recursive decomposition: how will you reduce the problem size towards the base case
# Identify the base case(s): The base case will be the case when the stack stops growing
# Think one level up from the base case: Manipulate one level above the base case
# Ensure that your return values from any case returns the same type
# Get a stack trace: The snippet will intentionally crash your program before
# the stack overflow occurs, allowing you to read the stack trace.
#
# MAX_STACK_SIZE = 200
# tracer = proc do |event|
#   if event == 'call' && caller_locations.length > MAX_STACK_SIZE
#     fail "Probable Stack Overflow"
#   end
# end
# set_trace_func(tracer)
