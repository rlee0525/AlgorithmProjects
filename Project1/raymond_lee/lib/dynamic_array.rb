require_relative "static_array"

class DynamicArray
  attr_reader :length

  def initialize
    self.store = StaticArray.new(8)
    self.capacity = 8
    self.length = 0
  end

  # O(1)
  def [](index)
    raise "index out of bounds" if index < 0 || index >= length

    store[index]
  end

  # O(1)
  def []=(index, value)
    raise "index out of bounds" if index < 0 || index >= length

    store[index] = value
  end

  # O(1)
  def pop
    raise "index out of bounds" if length <= 0
    popped = self[length - 1]
    self[length - 1] = nil
    self.length -= 1

    popped
  end

  # O(1) ammortized; O(n) worst case. Variable because of the possible
  # resize.
  def push(val)
    resize! if length == capacity

    self.length += 1
    self[length - 1] = val
  end

  # O(n): has to shift over all the elements.
  def shift
    raise "index out of bounds" if length == 0

    shifted = self[0]

    (1...self.length).each do |i|
      self[i - 1] = self[i]
    end

    self.length -= 1

    shifted
  end

  # O(n): has to shift over all the elements.
  def unshift(val)
    resize! if length == capacity

    self.length += 1
    (self.length - 2).downto(0).each do |i|
      self[i + 1] = self[i]
    end

    self[0] = val
  end

  protected

  attr_accessor :capacity, :store
  attr_writer :length

  # O(n): has to copy over all the elements to the new store.
  def resize!
    new_capacity = capacity * 2
    new_store = StaticArray.new(new_capacity)
    (0...self.length).each do |i|
      new_store[i] = self[i]
    end

    self.capacity = new_capacity
    self.store = new_store
  end
end
