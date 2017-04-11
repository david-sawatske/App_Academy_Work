# .concat mutates the caller
# << mutates the caller
# += reassigns the pointer


# []= and accessor methods
def [](pos)
  row, col = pos
  @seats[row][col]
end

def []=(pos, value)
  row, col = pos
  @seats[row][col] = value
end
#

my_hash = {}
my_hash[:key] = :value # this is not assigning a var, it's a method call (with syn sug)
my_hash.[]=(:key, :value) # here is the identical method call w/o sugar

# How the method above may be defined
class Hash
  def []=(key, val)
    #code to map the value
  end
end


# other syntatic sugar
x += y # => x = x + y, will work as long as `#+` is defined
x != y # => !(x == y), will use the `#==` method

# The or trick - Ruby will return the first truthy value
true || this_code_is_not_run
false || this_code_will_be_run
(1 || 2) == 1
(nil || 5) == 5

class MemoizedFibonacci
  def initialize # initializes empty hash
    @values = {}
  end

  def fib(n)
    @values[n] ||= calculate_fib(n) # or eq trick that will ret @values if it's not nil
    .....


################################
# Array/Hash defaults
  # Arrays of Arrays
arr_of_arr = Array.new(3, []) # this references the same empty array (in memory) 3 times
arr_of_arr[0] << "first only?"
p arr_of_arr #=> [["first only?"], ["first only?"], ["first only?"]]

arr_of_arr = Array.new(3) { [] } # the block constructs a new array each time it is run.
arr_of_arr[0] << "first only?"
p arr_of_arr #=> [["first only?"], [], []]

  # Muteable Immutable
arr2 = Array.new(3, 1)
arr2[0] += 1 # == arr2[0] = arr2[0] + 1 (+ operation does not mutate the original object)
             # fixnum in not mutated, arr[0] references a new fixnum object ie 2
p arr2 # => [2, 1, 1]

arr_of_arr = Array.new(3, []) # why does this not mutate the array stored in memory
arr_of_arr[0] = "first only?" # chaning all of the references to it?
p arr_of_arr #=> ["first only?", [], []]

  # Hash defaults
cats = Hash.new([])
cats["Devon"] # providing an argument to Hash.new merely changes what what is returned
p cats # => {}  when we look up a key that isn't present in the hash. doesn't assign "Devon"

cats["Devon"] += ["Earl"] # += constructs a new array and stores it for key "Devon"
p cats # => {"Devon" =>["Earl"]}

cats["Devon"] += ["Breakfast"] # adds to the value in hash stored in "Devon"
p cats # => {"Devon"=>["Earl", "Breakfast"]}

  #
cats = Hash.new([])
cats["John"] << "Kiki" # We never set a value for "John" though, so this is not stored in the Hash
p cats # => {} #       # John is not a key in the hash. we can't *push to it directly
# when we try to access some other non‐present key ( "Raul" ), the default value is returned
# again. But since we mutated the value by shovelling "Kiki" in, this is no longer empty.
p cats["Raul"] # => ["Kiki"]

# Here we've modified the block to take two arguments: when Hash needs a default value, it will
# pass itself ( h ) and the key ( k ). it creates and empty array and assigns it to the hash
 cats3 = Hash.new { |h, k| h[k] = [] }
 cats3["Devon"] # as a side effect, looking up a non existing key creates it in the hash
 p cats3
 # => {"Devon"=>[]}
 cats3["John"] << "Kiki"
 p cats3 # => {"Devon"=>[], "John"=>["Kiki"]}
