## Callbacks ##

# Callbacks are methods that get called at certain moments of an object's life cycle.
# => makes it possible to write code that will run whenever an Active Record
#    object is created, saved, updated, deleted, validated, or loaded from the database.


# Relational Callbacks #
# ex User has many posts, want to destroy posts when user is destroyed
# => or else the posts are said to be widowed
# => To do this, we pass the :dependent option to has_many:

class User < ActiveRecord::Base
  has_many :posts, :dependent => :destroy
end

class Post < ActiveRecord::Base
  belongs_to :user
end

>> user = User.first
=> #<User id: 1>
>> user.posts.create!
=> #<Post id: 1, user_id: 1>
>> user.destroy
=> #<User id: 1>


# Active Record and Referential Integrity #

# when a record is widowed, its foreign key becomes invalid (causing error)
# enforce a constraint at the DB level to guarantee referential integrity
# => this means adding a FOREIGN KEY constraint.
# => use a library like foreigner to add FK constraints
# => bet aware, but this may be considered overkill as far as protections


# Callback Registration #
# hooking into other model lifecycle events
# implement callbacks as ordinary methods
# use a macro-style class method to register them as callbacks

class User < ActiveRecord::Base
  validates :random_code, :presence => true
  before_validation :ensure_random_code

  protected
  def ensure_random_code
    # assign a random code
    self.random_code ||= SecureRandom.hex(8) # callback
  end
end

# => a callback to make sure to set the random_code attribute before validations
# => good practice to declare callback methods as protected or private


# Available Callbacks #
# most commonly hooked-into callbacks

# before_validation (handy as a last chance to set forgotten fields)
# after_create (handy to do some post-create logic, like send a confirmation email)
# after_destroy (handy to perform post-destroy clean-up logic)
