## Auth Pattern ##  Don't use your own!

# User model
# validates :password, length: { minimum: 6, allow_nil :true }
# => the allow_nil is for when we pull it out of the db

class User < ActiveRecord::Base

# creating user for the first time
  def password=(password)
    self.password_digest = BCrypt::Password.create(password)
  end

  def self.find_by_credentials(username, password)
      # def is_password?(password)
      #   BCrypt::Password.new(self.password_digest) == password
      # end
  end
end

# need session tokens methods
# 1. generate_session_token (creates random string)
# 2. ensure_session_token   (if we don't have one, we assign one)
# 3. reset_session_token    (resets to new one)


# Controllers #

# User - new (register), create (create new user and log in)

# SessionController - new (sign in page), create (logs in), destroy (log out/ redirect)

# ApplicationController
# @current_user ||= User.find_by[session_token] # only one query
# login!(user) # session[session_token]
# redirect_unless_logged_in

# to make sure users are logged in to perform certain functions:
# in the Controllers
# before_action :redirect_unless_logged_in, only[:index ...] or except[:index...]
