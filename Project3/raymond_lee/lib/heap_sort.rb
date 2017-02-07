require_relative "heap"

class Array
  def heap_sort!
    (0...count).each do |i|
      BinaryMinHeap.heapify_up(self, i, count)
    end

    count.downto(1).each do |i|
      self[0], self[i - 1] = self[i - 1], self[0]
      BinaryMinHeap.heapify_down(self, 0, i - 1)
    end

    self.reverse!
  end
end
