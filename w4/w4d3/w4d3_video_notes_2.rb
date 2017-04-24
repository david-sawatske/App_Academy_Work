## Salting ##

# How to solve the 'Users are stupid problem' #

# Attach a unique salt (random bits) to the password
# Hash the combination

# in the Users db on site:
# 1. Username (persists)
# 2. Password Digest (hashed password + salt using BCrypt)
# 3. Salt itself (new salt for every user)

# The entropy is huge. ie no way this is stored in a rainbow table
# Everyone with the same password will not have the same salt

# There is still a risk of attack on a high profile user
# => billgates12

# Make the cost of cracking the highest value user > the expected return
# => Run the hashed password + salt through hash multiple times
# => BCrypt shows the number of times hashed in the hash digest


## BCrypt ##
# BCrypt::Password.create("password123")
# => this is stored in the db as a string:
# '$2a$12$8vxYfAWCXe0Hm4gNX8nzwuqWNukOkcMJ1a9G2tD71ipotEZ9f80Vu'
# pass_hash = '$2a$12$8vxYfAWCXe0Hm4gNX8nzwuqWNukOkcMJ1a9G2tD71ipotEZ9f80Vu'

# Methods
# :version (2a)
# :cost (12) how many times hashed
# :salt (8vxYfAWCXe0Hm4gNX8nzwuqWNukO)
# :checksum (kcMJ1a9G2tD71ipotEZ9f80Vu)
# pass_hash.is_password?("password123") => true


## Session and Flash ##

# Session - like a hash, available primarily in the controller #
# Set keys in the session
#   session[:session_token] = 'ha2964'
#   session[:lang] = 'english'   # example
#    - (tamper proof/ encrypted cookies)
#    - stored client side,
#   session[:session_token]  # reads that cookie

# Generally you want to limit what is stored in cookies (want more on server)
# Cookies are stored for a max of 20 years


# Flash - a cookie that lasts for one request ie one redirect #
# ie user makes a form error, we want to give them that error

# flash[:user_error] = "Username can't be blank"
# ex in view
# <div class = "error">
#    <%= flash [:user_error] %>
# <div/>

# flash.now[:user_error] -only exists for this cycle













#
