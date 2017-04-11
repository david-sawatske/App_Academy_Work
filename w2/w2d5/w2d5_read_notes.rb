# https://launchschool.com/blog/how-the-hash-works-in-ruby

## Hashes ##
# constant O(1) time

# uses the division method to reduce the size of the data structure
# => key.hash is divided by the size of the storage or table and the remainder is the
#    location inside that table where a record can be stored.

# divisor M is prime, the results are not as biased and more evenly distributed.
# even with the best divisor, collisions will occur as the number of records
# being added increases.

# Ruby adjusts the value of M based the density (number in 1 bucket)
# => max density is in Ruby is 6. when reached, Ruby adjusts # of buckets

# Ruby now has ordered keys
