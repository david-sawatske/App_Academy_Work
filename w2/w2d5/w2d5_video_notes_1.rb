## Video 1 ##

# Sets - Abstract Data Type

# => Can be implemented in a Set class with an array. API:
#   -include? => 0(n)
#   -insert   => 0(n)
#   -delete   => 0(n)
#  * this is a bad way to implement as these are slow

# To increase effeciency, assuming you know the min/ max, you can set up
# an array with True/ False values based on the integers inclution. You can
# query the set with the index you are looking for. Indexing into an array
# is 0(1) constant time.

# It is constant time because arrays are stored in RAM consecutively
# It also knows the lenght of the array. It is 0(1) because of pointer arithmetic
#  Now this is a good implementation, right? Why not?
#  -include? => 0(1)
#  -insert   => 0(1)
#   -delete  => 0(1)
#   => takes up a lot of space. 0(max - min). could be huge.


## Video 2 ##
# We need to control the number of slots in the data structure

{1,4,6,3,8,9}  # the elements we want in the set
[ , , , ]        # we only have 4 'buckets'
 1 2 3 4    # <= the result of el % n.length is where el is stored

# This can be done by % set.length. put el in the number index of the result
#  -include? => 0(n)
#  -insert   => 0(n)  need to scan the whole bucket to see if el already exists
#  -delete   => 0(n)  need to scan the whole bucket to find
# we need to find a way for the k (number of buckets (4))in n/k
# to grow with n resulting in 0(1)


## Video 3 ##
{1,4,6,3,8,9}  # % 4 for all and place in the correcdt bucket
[ , , , ]
 1 2 3 4

# To do it, when n > k, it triggers the creation of a new array of k + 1 buckets
{1,4,6,3,8,9}
[ , , , , ]
# now we need to re % every element and reassign to the correct bucket
#  -include? => 0(1) constant - because k will always be > or = to n
#  -insert   => 0(n) linear - not great because of the re %
#  -delete   => 0(1) constant
#   space complexity is 0(n) linear becasue the number of buckets scales with n

# how to speed up insertion? we want to add n new buckets (k) for each add
# n * 2 buckets added per n will give a constant 0(1) per push
# the amortization of adding bucket per free n is constant

#  -include? => 0(1) constant - because k will always be > or = to n
#  -insert   => 0(1) now this is constant
#  -delete   => 0(1)

# But the above rely on random data sets and the 0(1) is rep of ave, not worst case
# and only works for integers
