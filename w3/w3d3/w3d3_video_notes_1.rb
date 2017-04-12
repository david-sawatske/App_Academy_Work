## Video 2 ##

# Migrations #
# A record of how the DB got to its current state
# Used to change the structure of the table, not it's contents

# Creating a migration
$ rails generate migration CreateCatsTable

class CreateCatsTable < ActiveRecord::Migrations
  def change
    create_table :cats do |t|
      t.string :name, null: false # options hash creates DB level constrait requiring cat to have name
      t.timestamps
    end
  end
end

$ rake db:create # to create the CreateCatsTable DB
$ rake db:migrate # passes the updated info the the DB
# => in the case above, it ran the code in #change and created a cats table

# see the current state of database in db/schema.rb (has but does not show id)

# make new table
$ rails g migration CreateToys

class CreateToys < ActiveRecord::Migrations
  def change
    create_table :cats do |t|
      t.string :name, null: false
      t.integer :cat_id, null: false #foreign key pointing to a cat
      t.timestamps
    end
  end
end

# if you made a mistake, run rake db:rollback, correct mistake and rake db:migrate

# How to edit table without using rollback?

$ rails g migration AddColorToCats

class AddColorToCats < ActiveRecord::Migrations
  def change
    create_table :cats, :color, :string
  end
end

$ rake db:migrate
# see the current state of database in db/schema.rb (has but does not show id)



## Video 3 ##

# Models #
# gives an Object Oriented way to interact with tables

# Make new file in app/models named the singular version of the table (cat.rb)

# app/models/cat.rb
class Cat < ActiveRecord::Base  # this gives ability to read, write, search cats table
end

# interact with the above class with the rails console
$ rails console or rails c

pry > c = Cat.new # create new instance of Cat. Not yet in DB
# => we can set properties of the cat that were created as table columns
#   - since the class inher from AR, it has built in setter methods

pry > c.name = "Sarah"  # setting name
pry > c.save # saves the created instance of Cat to DB

pry > sarah = Cat.first # selects first row from cats table in DB

# Set cat properties right off the bat
pry > jeff = c = Cat.new(name: 'Jeff', color: 'green') # match attributes with column names
pry > jeff.save

pry > Cat.all  # gives an array of all the cats in the DB

pry > jeff = Cat.last
pry > jeff.destroy  # removes jeff from the DB

pry > Cat.find(1)  # search db
pry > Cat.find(name: "Sarah")  # search db using opitions hash

pry > Cat.create(name: 'Sam', color: 'red') # creates the instance of Cat and inserts into DB
