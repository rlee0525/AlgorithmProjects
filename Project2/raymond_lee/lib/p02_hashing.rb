class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    hashing = 0

    self.each_with_index do |val, i|
      hashing += (val * i).hash
    end

    hashing
  end
end

class String
  def hash
    hashing = 0

    self.chars.each_with_index do |char, i|
      hashing += (char.ord * i).hash
    end

    hashing
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    hashing = 0

    self.each do |k, v|
      hashing += k.hash * v.hash
    end

    hashing
  end
end
