class QuickSort
  # Quick sort has average case time complexity O(nlogn), but worst
  # case O(n**2).

  # Not in-place. Uses O(n) memory.
  def self.sort1(array)
    return array if array.length <= 1
    pivot = array[0]

    left = array.select { |el| pivot > el }
    middle = array.select { |el| pivot == el }
    right = array.select { |el| pivot < el }

    sort1(left) + middle + sort1(right)
  end

  # In-place.
  def self.sort2!(array, start = 0, length = array.length, &prc)
    prc ||= Proc.new { |a, b| a <=> b }

    
  end

  def self.partition(array, start, length, &prc)
    prc ||= Proc.new { |a, b| a <=> b }

    partition = start

    (start + 1...start + length).each do |i|
      if prc.call(array[start], array[i]) == 1
        array[partition + 1], array[i] = array[i], array[partition + 1]
        partition += 1
      else
        next
      end
    end

    array[start], array[partition] = array[partition], array[start]

    partition
  end
end
