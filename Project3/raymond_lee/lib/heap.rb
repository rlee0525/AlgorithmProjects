class BinaryMinHeap
  def initialize(&prc)
    @store = []
  end

  def count
    @store.length
  end

  def extract
    @store[0], @store[count - 1] = @store[count - 1], @store[0]
    extracted = @store.pop
    BinaryMinHeap.heapify_down(@store, 0, count, &prc)
    extracted
  end

  def peek
    @store[0]
  end

  def push(val)
    @store << val
    child_index = @store.length - 1

    BinaryMinHeap.heapify_up(@store, child_index, count, &prc)
  end

  protected

  attr_accessor :prc, :store

  public

  def self.child_indices(len, parent_index)
    cidx = [parent_index * 2 + 1, parent_index * 2 + 2]
    cidx.select { |child| child < len }
  end

  def self.parent_index(child_index)
    raise "root has no parent" if ((child_index - 1) / 2) < 0
    (child_index - 1) / 2
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    prc ||= Proc.new { |a, b| a <=> b }

    cidx = child_indices(len, parent_idx)

    if cidx.length == 2
      cidx = prc.call(array[cidx[0]], array[cidx[1]]) < 1 ? cidx[0] : cidx[1]
    elsif cidx.length == 1
      cidx = cidx[0]
    else
      return array
    end

    if prc.call(array[parent_idx], array[cidx]) >= 0
      array[parent_idx], array[cidx] = array[cidx], array[parent_idx]
      heapify_down(array, cidx, len, &prc)
    end

    array
  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
    prc ||= Proc.new { |a, b| a <=> b }
    return array if child_idx == 0

    new_idx = parent_index(child_idx)
    if prc.call(array[new_idx], array[child_idx]) >= 0
      array[new_idx], array[child_idx] = array[child_idx], array[new_idx]
      heapify_up(array, new_idx, len, &prc)
    end

    array
  end
end
