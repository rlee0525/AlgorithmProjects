class Link
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end
end

class LinkedList
  include Enumerable

  def initialize
    @head = Link.new(0, "head")
    @tail = Link.new(1, "tail")
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    return nil if self.empty?
    @head.next
  end

  def last
    return nil if self.empty?
    @tail.prev
  end

  def empty?
    @head.next == @tail
  end

  def get(key)
    each { |link| return link.val if link.key == key }
  end

  def include?(key)
    each do |link|
      if link.key == key
        return true
      else
        next
      end
    end

    false
  end

  def insert(key, val)
    if include?(key)
      each { |link| link.val = val if link.key == key }
    else
      new_link = Link.new(key, val)
      current_link = @tail.prev
      current_link.next = new_link
      new_link.prev = current_link
      new_link.next = @tail
      @tail.prev = new_link
    end
  end

  def remove(key)
    get_link = nil
    each { |link| get_link = link if link.key == key }
    prev_link = get_link.prev
    next_link = get_link.next

    prev_link.next = next_link
    next_link.prev = prev_link
  end

  def each
    current_link = @head.next
    until current_link == @tail
      yield current_link
      current_link = current_link.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
