# # Video 1
# recursion = a function that calls itself
# base case = the last time it is run stoping the recursion from never ending

def factorial(n)
  return 1 if n == 1 # base case (where the recursion stops/ the bottom)
                     # no base case? program breaks because of stack overflow

  n * factorial(n - 1) # inductive step. if the logic works, it is scaleable
end                    # this is the subproblem.

# recursion helps to solve problems by solving it's subproblems

# # Video 2
# anything that can be implemented recursively can be done iteratively
# iterative ver is slightly more effecient (less memory)
# recursively ver is easier to reason an much more simply written (elegance)

# # Video 3

def upcase(str)
  return str.upcase if str.length <= 1 # base case. if one char remaining or empty string
  puts str

  p str[0].upcase + upcase(str[1..-1]) # can upcase everything but the first (or last  char)
end

upcase("test")
# => test
#    est
#    st    # "T" is the base case recombinatorial steps are below
#    "ST" # "S" was appended to the base case "T"
#    "EST" # so on...
#    "TEST" # goes up stack frame until it return the function



def reverse(str)
  return str if str.length <= 1

  str[-1] + reverse(str[0..-2])
end

p reverse("this")

# "Hello" => "olleH"  is the return we want
# start with something that works for either everything but the first or last
# "Hell" => "o" + "lleH"
# "ello" => "olle" + "H"


# # Video 4/5
# sort one element at a time. let's start by putting 4 in the correct, sorted position
# [4, 12, 3, 9, 7, 2] with the 'piviot element' as 4 we find its sorted position by putting
# [3, 2, 4, 12, 9, 7]  all < 4 on left/ > on right, in the order they appear in the array
# use recursion to sort the elements to the left and the elements to the right of 4
# [12, 9, 7] call quick_sort to put the new piviot, 12, in the correct spot
# [9, 7, 12] call quick_sort on the the elements to the left and the elements to the right of 12
# [9, 7] 9 is the pivot so put all < to the left (7) and all > (none) to the right
# [7, 9] 7 is the piviot and that == array.length == 1 ie the base case

def quick_sort(arr)
  return arr if arr.length <= 1
  pivot_arr = [arr.first]
  left_side = arr[1..-1].select { |el| el < arr.first }   # one of these needs = for
  right_side = arr[1..-1].select { |el| el >= arr.first } # duplicates of base case

  quick_sort(left_side) + piviot_arr + quick_sort(right_side)
end


# # Video 6/7
# stack overflow (ie SystemStackError) recursion never stopped and memory ran out or
# the number of stack frames limit set by Ruby (approx 9000), even on correct recursive calls


# # Video 8 - the stack, made of stack frames, which are stored in memory
# the bottom stack frame is called main. main is the global self (top level)
# - constants, gets, puts, defined functions, defined local vars are in main
# - main has line numbers
# see video 4:00 there is a new stack frame for each recursion, all saved in memory
# when the stack frame meets the base case, it is popped off the stack
# the each additional frame is popped and the cumulative value is returned
# to the next frame, until the original stack frame (one above main).
