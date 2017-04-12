require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    unless @store.include?(key)
      @count += 1
      self[key.hash] << key
    end
    resize! if @count == num_buckets
  end

  def include?(key)
    @store.flatten.include?(key) || @store.include?(key)
  end

  def remove(key)
    self[key.hash].delete(key)
  end

  private

  def [](num)

    @store[num.hash % num_buckets]
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_store = Array.new(num_buckets * 2) { [] }
    @store.each do |bucket|
      bucket.each do |num|
        hash_num = num.hash
        new_store[hash_num % num_buckets] << hash_num
      end
    end
    @store = new_store
  end
end
