## Scopes ##

# Scope - ActiveRecord::Base class method that constructs all or part of a
# query and then returns the resulting Relation object
# => keep your query code DRY by moving  frequently-used queries into a scope

class Post < ActiveRecord::Base
  def self.by_popularity
    self
      .select("posts.*, COUNT(*) AS comment_count")
      .joins(:comments)
      .group("posts.id")
      .order("comment_count DESC")
  end
end

# We can now use Post.by_popularity:

$ posts = Post.by_popularity
#  => #<ActiveRecord::Relation [#<Post id: 12>, #<Post id: 5>, ...]>
posts.first.comment_count
#  => 45

# Because it returns a Relation object and not just the results, we can continue to tack query methods onto it.
# => Makes it super flexable

# Suppose we only want the 5 most popular posts:
$ posts = Post.by_popularity.limit(5)
#  => #<ActiveRecord::Relation [#<Post id: 12>, #<Post id: 5>, ...]>
$ posts.count
#  => 5

# You can scopes them with associations
# Get most popular posts
$ posts = User.first.posts.by_popularity
#  => #<ActiveRecord::AssociationRelation #<Post id: 1>, #<Post id: 7>, ...]>
$ posts.first.comment_count
#  => 8


# Remember that User#posts returns a Relation object too.
# Relation objects know what kind of model objects they should contain.
# => they will assume the class methods (including scopes) that are available on that model class
