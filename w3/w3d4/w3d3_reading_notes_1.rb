## Active Relation ##

# Queries are lazy #

# Querying methods like group, having, includes, joins, select and where return
# an array like object of type ActiveRecord::Relation.
# => The contents of relation are not fetched until needed (lazy)

users = User.where("likes_dogs = ?", true) # no fetch yet!

# performs fetch here
users.each { |user| puts "Hello #{user.name}" }
# does not perform fetch; result is "cached"
users.each { |user| puts "Hello #{user.name}" }

# => The Relation is not evaluated (a database query is not fired) until the
#    results are needed.
# => After the query is run, the results are cached by Relation
#    - they are stored for later re-use
#    - we can re-use the result without constantly hitting the database


# Caching #

# After the query is run, the results are cached by Relation for reuse

# Fires a query; `posts` relation stored in `user1`.
p user1.posts
# => []
p user1.posts.object_id
# => 70232180387400

Post.create!(
  user_id: user1.id, # THIS LINE IS KEY, BECAUSE IT TIES THE POST TO THE USER IN THE DATABASE
  title: "Title",
  body: "Body body body"
)

# Does not fire a query; uses cached `posts` relation, which itself has cached the results.
p user1.posts
# => []
p user1.posts.object_id
# => 70232180387400

# call user1.posts(true) to force an association to be reloaded (ignoring any cached value)
# call user1.reload to throw away all cached association relations


# Laziness and stacking queries #

# Laziness allows us to build complex queries
georges = User.where("first_name = ?", "George")
georges.where_values # Returns a Relation which knows to filter by first_name
# => ["first_name = 'George'"]   # the condition is stored in the where_values attribute

george_harrisons = georges.where("last_name = ?", "Harrison")
george_harrisons.where_values # on this Relation; this produces a new Relation
                              # object which will know to filter by both first_name and last_name
# => ["first_name = 'George'", "last_name = 'Harrison'"]

# the additional where created a new Relation; the original georges is not changed
#  we build a second Relation from the first (which is never evaluated)
# => lazyness lets us build up a query by chaining query methods,
#    - none are executed until the chain is finished being built and evaluated

# where_values, includes_values, joins_values, etc. attributes not access DB directly
# => Relation builds up the query by storing each of the conditions
# => When the Relation needs to be evaluated, ActiveRecord looks at each of
#    these values to build the SQL to execute


# Forcing evaluation #

# Call load to force evaluation not yet done (also, count)
# => returns an actual array
