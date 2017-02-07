require_relative "static_array"

class RingBuffer
  attr_reader :length

  def initialize
    self.store = StaticArray.new(8)
    self.capacity = 8
    self.length = 0
    self.start_idx = 0
  end

  # O(1)
  def [](index)
    raise "index out of bounds" if index < 0 || index >= length

    store[(start_idx + index) % capacity]
  end

  # O(1)
  def []=(index, val)
    raise "index out of bounds" if index < 0 || index >= length

    store[(start_idx + index) % capacity] = val
  end

  # O(1)
  def pop
    raise "index out of bounds" if length == 0
    popped = self[length - 1]
    self[length - 1] = nil
    self.length -= 1

    popped
  end

  # O(1) ammortized
  def push(val)
    resize! if length == capacity

    self.length += 1
    self[length - 1] = val
  end

  # O(1)
  def shift
    raise "index out of bounds" if length == 0

    shifted = self[0]
    self[0] = nil
    self.start_idx = (self.start_idx + 1) % capacity
    self.length -= 1

    shifted
  end

  # O(1) ammortized
  def unshift(val)
    resize! if length == capacity

    self.start_idx = (self.start_idx - 1) % capacity
    self.length += 1
    self[0] = val
  end

  protected

  attr_accessor :capacity, :start_idx, :store
  attr_writer :length

  def resize!
    new_capacity = capacity * 2
    new_store = StaticArray.new(new_capacity)
    (0...self.length).each do |i|
      new_store[i] = self[i]
    end

    self.capacity = new_capacity
    self.store = new_store
    self.start_idx = 0
  end
end
