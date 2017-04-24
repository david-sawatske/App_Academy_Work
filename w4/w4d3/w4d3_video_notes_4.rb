## CSRF Attack ##

# cross site request forgery

# hidden html on another site has s form that post to your db

# only works when the user is logged into the attacked site
# => highjack existing session

# Prevent CSRF Attack #
# Make the host site aware that a req is coming from another site

# ../Controlers/ApplicationController

protect_from_forgert with: :exception
# This automatically protects

# The build out
def my_csrf_token
  SecureRandom::urlsafe_base64
end

helper_method :my_csrf_token # makes avail in views

#.../views/...
# put hidden input in the submition form with val <% my_csrf_token %>

# also store it in the session
# ../Controlers/ApplicationController
def my_csrf_token
  self.session[:_my_csrf_token] ||= SecureRandom::urlsafe_base64
end

# the token is now stored in params[:_my_csrf_token] and session[:_my_csrf_token]

# new method in ../Controlers/ApplicationController

before_filter :validate_csrf_token # before running controller action, run the below
def validate_csrf_token
  return if self.request.mehtod == "GET" # GET request doesn't have form data
  return if params[:_my_csrf_token] == session[:_my_csrf_token] # does nothing if ==
  raise "CSRF ATTACK DETECTED" # if they do not match
end


# Rails CSRF Methods - built in #
# ../Controlers/ApplicationController
protect_from_forgery with: :exception

#.../views/...  this is needed on all forms 
<input
  type="hidden"
  name="authenticity_token"
  value="<% form_authenticity_token %>">
