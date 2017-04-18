## Routes Demo ##

# config/routes.rb
# REST - representational state transfer routes #
# 1. name of HTTP method ie get, post, patch, put, new, edit (aka HTTP verbs)
# 2. specify the path 'superheroes/:id'
# => these are the 2 things that the router will look at to decide
# 3. specifies the controller 'to:superheroes...'
# 4. and what action to: 'superheroes#show'  (hash)

Rails.application.routes.draw do
  # get 'superheroes', to: 'superheroes#index'          (returns whats at the index)
  # get 'superheroes/:id', to: 'superheroes#show'       (:id = wildcard)
  # post 'superheroes', to: 'superheroes#create'        (creates)
  # patch 'superheroes/:id', to: 'superheroes#update'   (update)
  # put 'superheroes/:id', to: 'superheroes#update'
  # delete 'superheroes/:id', to: 'superheroes#destroy'

  # All of the above can be created with this:
  # resources :superheroes, only: [:index, :show, :create, :update, :destroy]

  # Nest collection routes - we need the superheroes id
  resources :superheroes do
    resources :abilities, only: [:index]
  end

  # Do not next your collection routes
  resources :abilities, only: [:show, :update, :create, :destroy]
end


## Basic Controller Demo ##

# how to create controller and see what the it gets from the router
Rails.application.routes.draw do
  # the get method, to the silly path, sent to the silly controller, fun action
  get 'silly', to: 'silly#fun'
  post 'silly', to: 'silly#time'
  post 'silly/:id', to: 'silly#super'

  resources :superheroes do
    resources :abilities, only: [:index]
  end

  resources :abilities, only: [:show, :update, :create, :destroy]
end

# test this route in Postman
# 1. start rails server
# 2. enter the request

# There was an error for no controller
# /app/controllers/silly_controller  (create a new file)
#  define instance method
class SillyController < ApplicaionController
  def fun
    # render text: 'hello'
    render json: params
  end
end

# the params is a hash like object given to controller by router. contains
# 1. Query string
# 2. Request body
# 3. URL Params/ route params (wildcards)

# GET localhost:3000/silly
# when the 'render json: params' is called in Postman, the response is
{
  "controller": "silly",
  "action": "fun"
}

# GET localhost:3000/silly?message=hi&fun=100 (we are putting something in the query string)
{
  "message": "hi",
  "fun": "100",
  "controller": "silly",
  "action": "fun"
}


class SillyController < ApplicaionController
  def fun
    # render text: 'hello'
    render json: params[message]
  end

  def time
    render json: params[message]
  end

  def super
    ender json: params
  end
end

# GET localhost:3000/silly?message=hi&fun=100
 "hi"

# added post to routes (post 'silly', to: 'silly#time')
# POST localhost:3000/silly in postman
# in Body key: age value: 50
{
  "age": "50",
  "controller": "silly",
  "action": "fun"
}


# added post 'silly/:id', to: 'silly#super' (for wildcard)
# GET localhost:3000/silly?20
{
  "controller": "silly",
  "action": "fun"
  "id": "20" # id is the wild card parameter
}
