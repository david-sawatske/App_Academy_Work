## Joins in Active Record ##

# db/schema.rb
ActiveRecord::Schema.define(:version => 20130126200858) do
  create_table "comments", :force => true do |t|
    # :force => true drops the table before creating it.
    t.text     "body"
    t.integer  "author_id"
    t.integer  "post_id"
    t.integer  "parent_comment_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "posts", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.integer  "author_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    # :null => false means this field must be filled.
  end

  create_table "users", :force => true do |t|
    t.string   "user_name"
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end
end

### Bad example given in the reading. Annotations here: https://github.com/appacademy/curriculum/blob/master/sql/readings/joins.md

# app/models/user.rb
# the n+1 (bad)
class User
 # ...

 def n_plus_one_post_comment_counts
   posts = self.posts

   posts.each do |post| # This query gets performed once for each post (expensive)
     post_comment_counts[post] = post.comments.length
   end

   post_comment_counts
 end
end


# Solution to N+1 queries problem #

# Active Record lets you specify associations to prefetch
# => When you use these assocations later, the data will already have been
#    fetched and won't need to be queried for

# Use 'includes' to prefetch data (e.g., posts = user.posts.includes(:comments))
# => a subsequent call to access the association (e.g., posts[0].comments) won't #    fire another DB query; it'll use the prefetched data.

# This code will execute just 2 queries,
class User
  # ...

  def includes_post_comment_counts
    posts = self.posts.includes(:comments) # prefetches the association `comments`
    post_comment_counts = {}

    posts.each do |post|
      post_comment_counts[post] = post.comments.length
    end

    post_comment_counts
  end
end

# You should wait until you see performance problems before returning to optimize code
# => "premature optimization is the root of all evil"


# Complex includes #

# You can eagerly load as many associations as you like:

comments = user.comments.includes(:post, :parent_comment)
# both the post and parent_comment associations are eagerly loaded
# Neither comments[0].post nor comments[0].parent_comment will hit the DB
# => they've been prefetched.

# We can also do "nested" prefetches:

posts = user.posts.includes(:comments => [:author, :parent_comment])
first_post = posts[0]
# This prefetches first_post.comments, first_post.comments[0],
# first_post.comments[0].author, first_post.comments[0].parent_comment


# Joining Tables #

# To perform a SQL JOIN, use joins.
# => like includes, it takes a name of an association.
# => joins by default performs an INNER JOIN
#    - frequently used to filter out records that don't have an associated record

# ex filter Users who don't have Comments:

# app/models/user.rb
class User
  # ...

  def self.users_with_comments
    User.joins(:comments).uniq  # returns just an instance of User
  end
end

# `joins` does not automatically return a wider row
# => User.joins(:comments) still just returns a User

# includes` fetches the entries and the associated entries both.
# `User.joins(:comments)` returns no `Comment` data, just the `User` columns


# Avoiding N+1 queries without loading lots of records #

# includes returns lots of data: every Comment on every Post that the User has written.
# => the Comments themselves are useless, we just want to count them

# another major use of joins is  push some of the counting work to SQL
# => the database does the counting
# => we receive just Post objects with associated comment counts

class User
  # ...

  def joins_post_comment_counts
    # When we want to do an "aggregation" like summing the number of
    # records (and don't care about the individual records), we want
    # to use `joins`.

    posts_with_counts = self
      .posts
      .select("posts.*, COUNT(*) AS comments_count")
      .joins(:comments)
      .group("posts.id") # "comments.post_id" would be equivalent

    # As we've seen before using `joins` does not change the type of
    # object returned: this returns an `Array` of `Post` objects.
    #
    # But we do want some extra data about the `Post`: how many
    # comments were left on it. We can use `select` to pick up some
    # "bonus fields" and give us access to extra data.
    #
    # Here, I would like to have the database count the comments per
    # post, and store this in a column named `comments_count`. The
    # magic is that ActiveRecord will give me access to this column by
    # dynamically adding a new method to the returned `Post` objects;
    # I can call `#comments_count`, and it will access the value of
    # this column:

    posts_with_counts.map do |post|
      [post.title, post.comments_count]
    end
  end
end


# OUTER JOINs #

# to include posts with zero comments, we need to do an outer join.

posts_with_counts = self
  .posts
  .select("posts.*, COUNT(comments.id) AS comments_count")
  .joins("LEFT OUTER JOIN comments ON posts.id = comments.post_id")
  .group("posts.id")

# We had to specify the primary and foreign key columns for the join


# Specifying where conditions on joined tables #
# You can specify conditions on the joined tables as usual
# => you should qualify the column names

# fetch comments on `Posts` posted in the previous day
start_time = (DateTime.now.midnight - 1.day)
end_time = DateTime.now.midnight
Comment.joins(:post).where(
  'posts.created_at BETWEEN ? AND ?',
  start_time,
  end_time
).uniq
