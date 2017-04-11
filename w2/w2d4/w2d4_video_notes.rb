## Big O ##

## Vid 1
# Is Algo A faster than Algo B?

# What factors determine speed?
# => harware, # of steps, language implementation, input size
#   => # of steps/ type of input are determined by the Algo


## Vid 2
# RAM Model of Computation
# => allows for the abstraction of the small and insignificant details
#   => i.e. how long + or - or a loop take
# => makes analysis more accurate
# all math operators == 1 step
# loops == number of loops * number of steps in loop
# memory access + function calls == 1 step

## Vid 3
# Asymptotic Analysis - Approaching a value abitrarily close
# the example with constant number of steps and the one dependent on input

# How is this used by CS?
# => Ignore constants
# => Only consider the more dominant term (only as fast as you can bottleneck)
#   - 3n + 1   <= the 3n is the most dominant term
#     - as n gets larger, 1 becomes less significant (n crushes it)

# for the ex, 2700 is reduced to 1 and 3n + 1  is reduced to n
# => 1 vs n

## Vid 4
# The Big-Oh is the Asymptotic worst case runtime
# => Why not first? Too rare. Why not average?  Too dificult

## Vid 5
# Common Big-Oh Classifications - in order fastest => slowest
# => 0(1)
#   - it is independent of its input size (constant)
# => 0(log n) - logarithmic more steps smaller increase in runtime
#   - larger n becomes in log n, the smaller increase in steps
#   - Binary search is an example
# => 0(n) - Linear search
# => 0(n log n) Log Linear
#   - ex merge sort ie the best we can do sorting
# => 0(n ** 2) Quadratic
#   - ex nested x2 iterations & bubble sort
# => 0(2 ** n) Exponental
#   - ex subsets
# => 0(n!) factorial
#   - permutation
