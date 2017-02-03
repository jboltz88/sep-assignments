require_relative 'node'

class OpenAddressing
  def initialize(size)
    @hash = Array.new(size)
    @entries = 0
  end

  def []=(key, value)
    i = index(key, size())
    # new hash pair
    if @hash[i] == nil
      @hash[i] = Node.new(key, value)
      @entries += 1
    # duplicate hash pair
    elsif @hash[i].key == key && @hash[i].value == value
      return "duplicate"
    # hash pair value needs updating
    elsif @hash[i].key == key && @hash[i].value != value
      @hash[i].value = value
    else
      # search for next open index
      j = next_open_index(i)
      if j == -1
        resize()
        self[key] = value
      else
        @hash[j] = Node.new(key, value)
        @entries += 1
      end
    end
  end

  def [](key)
    (0...size()).each do |i|
      if @hash[i] != nil
        if @hash[i].key == key
          return @hash[i].value
        end
      end
    end
    return "pair not found"
  end

  def print_hash
    (0...size()).each do |i|
      if @hash[i] != nil
        puts "index: #{i}, #{@hash[i].key}: #{@hash[i].value}"
      end
    end
    puts "load factor: #{load_factor()}"
  end

  # Returns a unique, deterministically reproducible index into an array
  # We are hashing based on strings, let's use the ascii value of each string as
  # a starting point.
  def index(key, size)
    return key.sum % size
  end

  # Given an index, find the next open index in @hash
  def next_open_index(index)
    (index...size()).each do |i|
      if @hash[i] == nil
        return i
      end
    end
    return -1
  end

  # Simple method to return the number of hash in the hash
  def size
    return @hash.length
  end

  def load_factor
    size = size() + 0.0
    lf = @entries / size
    return lf
  end

  # Resize the hash
  def resize
    # create transfer array
    arrXfer = Array.new(@hash.length * 2)
    # for each element in the @hash array, copy them into the new transfer
    # array and give them a new index based on the new array size
    (0...@hash.length).each do |el|
      if @hash[el]
        newIndex = @hash[el].key.sum % arrXfer.length
        arrXfer[newIndex] = @hash[el]
        @hash[el] = nil
      end
    end
    # assign the transfer array to our hash array
    @hash = arrXfer
  end
end
