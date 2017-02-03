require_relative 'linked_list'
require_relative 'node'

class SeparateChaining
  attr_reader :max_load_factor
  attr_accessor :entries

  def initialize(size)
    @max_load_factor = 0.7
    @entries = 0
    @hash = Array.new(size)
  end

  def []=(key, value)
    i = index(key, size())
    # create new linked list at index
    if @hash[i] == nil
      @hash[i] = LinkedList.new
      @hash[i].add_to_front(Node.new(key, value))
      @entries += 1
    # existing linked list at the index
    else
      currNode = @hash[i].head
      # cycle through the linked list
      until currNode == nil || currNode.key == key
        currNode = currNode.next
      end
      if currNode == nil
        @hash[i].add_to_front(Node.new(key, value))
        @entries += 1
      elsif currNode.key == key && currNode.value != value
        currNode.value = value
      else
        return "duplicate"
      end
    end
    if load_factor() > @max_load_factor
      resize()
    end
  end

  def [](key)
    i = index(key, size())
    if @hash[i] != nil
      currNode = @hash[i].head
      until currNode == nil || currNode.key == key
        currNode = currNode.next
      end
      if currNode == nil
        return "hash pair not found"
      else
        return currNode.value
      end
    else
      return "no match"
    end
  end

  def print_hash
    (0...size()).each do |i|
      if @hash[i] != nil
        puts "index: #{i}"
        @hash[i].print
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

  # Calculate the current load factor
  def load_factor
    size = size() + 0.0
    lf = @entries / size
    return lf
  end

  # Simple method to return the number of buckets in the hash
  def size
    return @hash.length
  end

  # Resize the hash
  def resize
    # create transfer array
    arrXfer = Array.new(@hash.length * 2)
    # for each element in the @hash array, copy them into the new transfer
    # array and give them a new index based on the new array size
    (0...@hash.length).each do |i|
      if @hash[i] != nil
        currNode = @hash[i].head
        until currNode == nil
          newIndex = currNode.key.sum % arrXfer.length
          arrXfer[newIndex] = LinkedList.new
          arrXfer[newIndex].add_to_front(currNode)
          currNode = currNode.next
        end
        @hash[i] = nil
      end
    end
    # assign the transfer array to our hash array
    @hash = arrXfer
  end
end
