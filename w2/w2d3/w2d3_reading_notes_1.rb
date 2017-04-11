# # RSPEC # #

# Each spec will usually be limited to testing a single file and so will require
# the file at the top of the spec. It will also have to require the rspec gem.

require 'rspec'
require 'hello' # <= The lib/hello.rb file

describe "#hello_world" do # <= method in hello.rb
  it "returns 'Hello, World!'" do
    expect(hello_world).to eq("Hello, World!")
  end
end


# describe, it and expect #

# 'describe' is is RSpec's unit of organization
# => Arg is the name of the method that you are testing as a string
#   - use #method for instance && ::method for class methods

# 'it' is RSpec's most basic test unit.
# => describe what is being tested

# 'expect' is actually testing the code
  expect(5.to_s).to eq('5')
  expect { sqrt(25) }.not_to raise_error(ArgumentError)
  expect('hello').to eq('hello') # => passes ('hello' == 'hello')
  expect('hello').to be('hello') # => fails (strings are different objects)

# before - used to set up the context in which our specs will run
# => before can be used as either before(:each) or before(:all)
#    - with :each state is not shared - that is, you start fresh on every spec
#    - :all shares state making specs dependent on each other

describe Chess do
  let(:board) { Board.new }

  describe '#checkmate?' do
    context 'when in checkmate' do
      before(:each) do
        board.make_move([3, 4], [2, 3])
        board.make_move([1, 2], [4, 5])
        board.make_move([5, 3], [5, 1])
        board.make_move([6, 3], [2, 4])
      end

      it 'should return true' do
        expect(board.checkmate?(:black)).to be true
      end
    end
  end
end

# Pending Specs - Leave off the do...end from the it.


# https://github.com/rspec/rspec-core
# Basic Structure
# =>  The describe method creates an ExampleGroup. Within the block passed
#     to describe you can declare examples using the it method.
# =>  Under the hood, an example group is a class in which the block passed to
#     describe is evaluated. The blocks passed to it are evaluated in the context
#     of an instance of that class.

RSpec.describe Order do # <= creates and example group (class)
  it "sums the prices of its line items" do
    order = Order.new

    order.add_entry(LineItem.new(:item => Item.new(  # instance of that 'class'
      :price => Money.new(1.11, :USD)
    )))
    order.add_entry(LineItem.new(:item => Item.new(  # instance of that 'class'
      :price => Money.new(2.22, :USD),
      :quantity => 2
    )))

    expect(order.total).to eq(Money.new(5.55, :USD))
  end
end

# => You can also declare nested nested groups using the describe or context methods
# => Nested groups are subclasses of the outer example group class, providing the
#    inheritance semantics you'd want for free.
RSpec.describe Order do
  context "with no items" do  # subclass
    it "behaves one way" do
      # ...
    end
  end

  context "with one item" do  # subclass
    it "behaves another way" do
      # ...
    end
  end
end


# Shared Examples and Contexts
# => Declare a shared example group using shared_examples, and then include it in
#    any group using include_examples.
# => Anything that can be declared within an example group can be declared
#    within a shared example group. This includes before, after, and around
#    hooks, let declarations, and nested groups/contexts.

RSpec.shared_examples "collections" do |collection_class| # examples to share
  it "is empty when first created" do
    expect(collection_class.new).to be_empty
  end
end

RSpec.describe Array do
  include_examples "collections", Array     #including shared examples
end

RSpec.describe Hash do
  include_examples "collections", Hash     #including shared examples
end


# Metadata - rspec-core stores a metadata hash with every example and group


# described_class
# => When a class is passed to describe, you can access it
#    from an example using the described_class method, which is a wrapper for
#    example.metadata[:described_class].
# => This is useful in extensions or shared example groups in which the specific
#    class is unknown. Taking the collections shared example group from above, we
#    can clean it up a bit using described_class.

RSpec.shared_examples "collections" do
  it "is empty when first created" do
    expect(described_class.new).to be_empty
  end
end

RSpec.describe Array do
  include_examples "collections"
end

RSpec.describe Hash do
  include_examples "collections"
end

# A Word on Scope - DID NOT READ YET



# https://github.com/rspec/rspec-expectations
# Built-in matchers
expect(actual).to eq(expected)  # passes if actual == expected
expect(actual).to eql(expected) # passes if actual.eql?(expected)
expect(actual).not_to eql(not_expected) # passes if not(actual.eql?(expected))

expect(actual).to be(expected)    # passes if actual.equal?(expected)
expect(actual).to equal(expected) # passes if actual.equal?(expected)

expect(actual).to be >  expected
expect(actual).to be >= expected
expect(actual).to be <= expected
expect(actual).to be <  expected
expect(actual).to be_within(delta).of(expected)

expect(actual).to match(/expression/)

expect(actual).to be_an_instance_of(expected) # passes if actual.class == expected
expect(actual).to be_a(expected)              # passes if actual.kind_of?(expected)
expect(actual).to be_an(expected)             # an alias for be_a
expect(actual).to be_a_kind_of(expected)      # another alias

expect(actual).to be_truthy   # passes if actual is truthy (not nil or false)
expect(actual).to be true     # passes if actual == true
expect(actual).to be_falsy    # passes if actual is falsy (nil or false)
expect(actual).to be false    # passes if actual == false
expect(actual).to be_nil      # passes if actual is nil
expect(actual).to_not be_nil  # passes if actual is not nil

expect { ... }.to raise_error
expect { ... }.to raise_error(ErrorClass)
expect { ... }.to raise_error("message")
expect { ... }.to raise_error(ErrorClass, "message")
