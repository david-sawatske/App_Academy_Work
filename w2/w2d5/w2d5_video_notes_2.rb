## Video 4 ##

# Hashing #

# Anything goes in:     |hashing| => the output is random 'crap' encoded
# 5, "hi", grandma  =>  | funct |    in base 64 'b72ac99z12' and is the same
#                                    fixed size as input

# hashing is deterministic - each time grandma is hashed, get same output
# uniformly distributed - one output string is just as likley as another
# one way - looking at the output, there is nothing predicatble about the input

# Hashing functions include - Cityhash, CRC32, Mururm hash (Ruby uses)
# Cryptographic hashing funct (slower) - MDS, SHA2, Blowfish
#   => fewer collisions - when inputs are assigned to same hashing value (output)
#   => very hard to reverse engineer

# for every Ruby object there is a def hash instance method through Murmur hash
#   => this hash, like others,  outputs as a string


## Video 5 ##

# Hash Set #

# instead of % the number, we will % the hash of the number
{ 2, 4, 6, 8, 'hello', 'dolly' } # elements we want in the set
[ , , , ]        # 4 'buckets'

# take the first el you want to put in set and put it through the hashing
# function to get a number
#  % that number and put the el in the bucket of the result
# when those buckets are full, add n * 2 more buckets and rehash

#  -include? => 0(1) on average as n / buckets is a constant number, worst case 0(n)
#  -insert   => 0(1) constant, worst case 0(n) to check for prev inclution
#  -delete  => 0(1)  constant, worst case 0(n) to check for current inclution

# How .hash is is defined for class object by default (below). This can be bad
#  => because two objects that should have the same hash value do not because
#     they have different object ids. ex is matching two empty arrays
#  => in real life, Array class over rides this with in the class' def hash method

class Object
  def hash
    object_id.hash
  end
end


## Video 6 ##

# Liked List #

# singly-linked-list
#       head                               tail
#      node 1            node 2           node 3
#[value/ @next] ->[ value/ @next] -> [value/ @next]
#  => the @next is a pointer. an instance variable that points to next node (or nil)

class Link
  def initialize(value, next)
    @value = value
    @next = next
  end
end

# => operations for link list
#     -find 0(n) # arrays are faster
#     -push 0(1)
#     -unshifting  0(1)
#     -delete 0(1)   # see below @prev/ @next
#     -insert  0(1)  # see below @prev/ @next

# => deleting becomes easy as you change the pointer to the node you want gone
#    gets deallocated and garbage collected (cold shoulder in HS). How?
#    - doubly linked list with both next and nil

#       head                                                tail
#       node 1                     node 2                   node 3
# [value/ @next/ @prev] ->[ value/ @next/ @prev] -> [value/ @next/ @prev]
# => node 1 changes @next to 5, 5 changes @prev to 1
# => node 2 still has pointers, but since it is not being referenced, it is
#    garbage collected.

# Using sentenial nodes makes writing the code for linked lists easier
# => empty link list |:head|    |:tail|
#                    |@next| -> |next | ->
#                 <- |@prev| <- |@prev|
# these nodes are placeholders, there is always a head and a tail


# Hash Map

# Example node for hash map
#    |@key | @val|
#    |    next    | ->
# <- |    prev    |

# to go from hash set to hash map, use an array of liked lists
#   => each 'bucket' is a linked list
#
# to make sure the key is used as the identifier as the keys are unique
# key.hash % is used for assignment the the ordered buckets (linked list)
# and key.hash % is also used for look up

        [linked list, linked list, linked list, linked list]
             ↑↓            ↑↓           ↑↓           ↑↓
            |key|        |key|        |key|        |key|
            |val|        |val|        |val|        |val|
             ↑↓            ↑↓           ↑↓           ↑↓
            |key|                     |key|        |key|
            |val|                     |val|        |val|
             ↑↓            ↑↓           ↑↓           ↑↓
#  -getting hash[key] 0(1)
#  -setting hash[key] 0(1)
