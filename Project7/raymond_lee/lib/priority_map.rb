require_relative 'heap2'

class PriorityMap
  def initialize(&prc)
    @map = {}
    @queue = BinaryMinHeap.new(&prc)
  end

  def [](key)
    @map[key]
  end

  def []=(key, value)
    insert(key, value)
    @map[key] = value
  end

  def count
    @queue.count
  end

  def empty?
    @queue.empty?
  end

  def extract
    key = @queue.extract
    value = @map[key]
    # update(key, value)
    @map.delete(key)
    [key, value]
  end

  def extract!
    @queue.extract
  end

  def has_key?(key)
    @map.key?(key)
  end

  protected

  attr_accessor :map, :queue

  def insert(key, _)
    @queue.push(key) unless @map.key?(key)
  end

  def update(key, _)
    @queue.reduce!(key)
  end
end
