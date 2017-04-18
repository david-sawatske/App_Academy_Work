## Metaprogramming and Reflection ##

# send and define_method #

# Ruby is reflection (also called introspection): the ability for a program to examine itself.
# => we can ask an object what methods it will respond to:
obj = Object.new
obj.methods
# => [:nil?, :===, :=~, :!~, :eql?, :hash, :<=>, :class, ...]

# More significantly, we can call a method by name:
[].send(:count) # => 0

# using send lets us write methods like this:
def do_three_times(object, method_name)
  3.times { object.send(method_name) }
end

class Dog
  def bark
    puts "Woof"
  end
end

dog = Dog.new
do_three_times(dog, :bark)


# We can even define new methods dynamically with define_method:

class Dog
  # defines a class method that will define more methods; this is
  # called a **macro**.

  def self.makes_sound(name)
    define_method(name) { puts "#{name}!" }
  end

  makes_sound(:woof)
  makes_sound(:bark)
  makes_sound(:grr)
end

dog = Dog.new
dog.woof
dog.bark
dog.grr

# => The code inside Dog class is executed at the time Ruby defines the Dog class.
# => makes_sound is called at class definition time, not each time a new Dog object is created.
#    - makes_sound sets up an instance method to be shared by all Dog objects.
#    - It's not instance-specific.
# => Inside the definition of the Dog class, makes_sound knows to call the class method
#    because self == Dog here.
# => In the makes_sound macro, self == Dog because this is a Dog class method.
# => define_method is implicitly called on Dog, adding a new method named name

# We don't write macros every single day, but they are frequently quite useful.
# Some of the most famous macro methods are:
=> attr_accessor: # defines getter/setter methods given an instance variable name.
=> belongs_to/has_many: # defines a method to perform a SQL query to fetch associated objects.
