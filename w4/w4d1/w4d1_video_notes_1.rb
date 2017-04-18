## What is an API ##

# Application Program Interface #
# => published interface (set of rules) for how a program works and how you use it

# Ruby object API
# => the publically available methods

# On the internet: GET request to server
# => website - includes assets to be rendered by browser
# => webservice (API) - just data ie google maps on a phone/ server to server/
#                       client side rendering of data (gmail)


## HTTP Request and Response ##

# Request
  # must have
# => method ie GET, PUT, PATCH, POST
# => path ie ../users/4
  # optional
# => query string ie ?loc=SF&  everything after the ? in a url
#    - key value pair separated by the =, pairs separated by &
# => request body
#    - also key value pair. probably from pair

# Response
# => status - what happened in the server. 200 OK, 404 NOT FOUND
# => body - the requested information
#    - this would be the HTML, CSS, JS if a page is requested


## Rails Routing ##

#   in server
# Rails Router - recieves HTTP request
# => determines to what controller to send request
#    - decided by the path (ie /users) and method (ie GET)
# => tells controller what to do with the request by creating a new instance
#    if the controller (which itself is a class)

# Rails Controller (a class) - has actions (methods defined on the controller)
# => responsible for processing the request and returning the HTTP response
