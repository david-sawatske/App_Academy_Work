# # RSpec cont. # #

# subject and let - To test a class, you will often want to instantiate an
#                   instance of the object to test it out. In this case, you may
#                   want to define a subject for your tests.

# there can only be one (unnamed) subject. (if you declare a second subject,
# the value of subject inside of your it blocks will use the more recent definition).

describe Robot do  # you can delcare subject w or w/o name (:robot (below))
  subject(:robot) { Robot.new } # subject also accepts a block that constructs the
                                # subject with any necessary setup
  let(:light_item) { double("light_item", :weight => 1) } # helper object
  let(:max_weight_item) { double("max_weight_item", :weight => 250) } # helper objec

  it "position should start at [0, 0]" do
    expect(robot.position).to eq([0, 0])
  end

  describe "move methods" do
    it "moves left" do
      robot.move_left
      expect(robot.position).to eq([-1, 0])
    end
  end
end

# The it block is a test. It runs the code, and the test fails if the expect fails.
# In the first test, we expect that the position is [0, 0]. In the second test we
# move the robot, and then expect the position to have changed.


# let - used to define helper objects that interact with the subject of the test.
# => you can define many helper objects through let.
# => let defines a method (e.g. light_item, max_weight_item) that runs the
#    block provided once for each spec in which it is called.

describe Robot do
  subject(:robot) { Robot.new }
  let(:light_item) { double("light_item", :weight => 1) }
  let(:max_weight_item) { double("max_weight_item", :weight => 250) }

  describe "#pick_up" do
    it "does not add item past maximum weight of 250" do
      robot.pick_up(max_weight_item)

      expect do
        robot.pick_up(light_item)
      end.to raise_error(ArgumentError)
    end
  end
end

# =>  You might read that let memoizes its return value. Memoization means that
#     the first time the method is invoked, Since every it is a different scope,
#     let does not persist state between those specs.

class Cat
  attr_accessor :name

  def initialize(name)
    @name = name
  end
end

describe "Cat" do
  let(:cat) { Cat.new("Sennacy") }

  describe "name property" do
    it "returns something we can manipulate" do # cat name is maniplated
      cat.name = "Rocky"
      expect(cat.name).to eq("Rocky")
    end

    it "does not persist state" do      # cat name returns from manipulation it's
      expect(cat.name).to eq("Sennacy") # original value
    end
  end
end


# RSpec Order of Operations

RSpec.describe Deck do
  describe '#initialize' do
    subject(:deck) { Deck.new } # RSpec requires that the subject be declared
                                # outside of your it blocks.
    it 'initializes with 52 cards' do
      expect(deck.count).to eq(52)
    end
  end
end


# Test Doubles - we want each of our specs to test just one thing
# => this is complicated when we write classes that interact with other classes

# Here an Order object needs a Customer object; the associated Customer object is
# used, for instance, when we try to call the #send_confirmation_email. In particular,
# if we want to test #send_confirmation_email, it looks like we'll have to supply
# Order a Customer object.

class Order
  def initialize(customer)
    @customer = customer
  end

  def send_confirmation_email
    email(
      to: @customer.email_address,
      subject: "Order Confirmation",
      body: self.summary
    )
  end
end

# This is troublesome because a spec for #send_confirmation_email should only
# test the #send_confirmation_email method, not Customer#email_address
# Another problem is if Order and Customer both have methods that interact with
# the other. If we write the Customer specs and methods first, then we'll need a
# functioning Order object first for our Customer to interact with.

describe Order
  subject(:order) do
    customer = Customer.new(
      :first_name => "Ned",
      :last_name => "Ruggeri",
      :email_address => "ned@appacademy.io"
    )
    Order.new(customer)
  end

  it "sends email successfully" do
    expect do
      subject.send_confirmation_email
    end.not_to raise_exception
  end
end

## SOLUTION ##
# A test double (also called a mock) is a fake object that we can use to create
# the desired isolation. A double takes the place of outside, interacting objects,
# such as Customer

describe Order
  let(:customer) { double("customer") } # creates an instance of RSpec::Mocks::Mock
  subject(:order) { Order.new(customer) }

  it "sends email successfully" do
    allow(customer).to receive(:email_address).and_return("ned@appacademy.io")

    expect do
      order.send_confirmation_email
    end.to_not raise_exception
  end
end

# => A method stub stands in for a method; Order needs customer's email_address
#    method, so we create a stub to provide it. We do this by calling
#    allow(double).to receive(:method), passing a symbol with the name of the method
#    that we want to stub. The and_return method takes the return value that the
#    stubbed method will return when called as its parameter.

# => The customer double simulates the Customer#email_address method, without
#    actually using any of the Customer code. This totally isolates the test
#    from the Customer class; we don't use Customer at all. We don't even need
#    to have the Customer class defined. The customer object is not a real
#    Customer; it's an instance of Mock.


# Method Expectations - we should test that the proper methods are called
# Here we want to test that when we call charge_customer on an Order object,
# it tells the customer to subtract the item price from the customer's account.
# We also specify that we should check that we have passed #debit_account the
# correct price of the product.

describe Order
  let(:customer) { double('customer') }
  let(:product) { double('product', :cost => 5.99) }
  subject(:order) { Order.new(customer, product) }

  it "subtracts item cost from customer account" do
    expect(customer).to receive(:debit_account).with(5.99)
    order.charge_customer
  end
end
# Notice that we set the message expectation before we actually kick off the
# #charge_customer method. Expectations need to be set up in advance.


# Integration tests - we use real objects instead of mocks, so that we can
#                     verify that all the classes interact correctly.
