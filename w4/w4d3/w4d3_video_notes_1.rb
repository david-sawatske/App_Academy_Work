# HTTP is stateless
# => nothing persists
# => anything that persists needs to be sent in url


## Cookies ##
# keeps state in the website in the client (users computer)

# made of key value pairs that is website specific
# from browser, saved on computer (client)
# => browser enforces cookies (20 per domain, less than 4kb )
# cookies are sent in the header of the request
# cookies can be changed on the client side


 # Validation #

 # user sends u.n. and p.w.
 # server returns session token
 # => random bits, stored in cookies

 # in the Users db on site:
 # 1. Username (persists)
 # 2. Password (persists)
 # 3. Session_token (deleted when user logged out)


# Encoding #

# ex base64 encoding
# => ASCII table (256 character (8 bit) 128 (char (7 bit, really))
#    - 64 possibilities for each character sent  (high entropy)
# => Use the rules for encoding to decode (not sufficient)


# Encripting #

# ex Caesar Cipher
# => we would not know how to un-encript (one of 25 possible shift amounts)
# => The single layer of obfuscation is the same as plain password


# Use Hasing Function #
# One way function, same input = same output
# => When you enter a password, the same digest is given every time
# => Certian matches execept for hashing collision
#    - 2 arbitrary inputs hasing to same digest
#    - possible because the hashing function always gives same output length

# Cryptographic hashing functions - min risk of collision
# => We will use BCrypt


# in the Users db on site:
# 1. Username (persists)
# 2. Password Digest (hashed password using BCrypt)
# 3. Session_token (deleted when user logged out)
