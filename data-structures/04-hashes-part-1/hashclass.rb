require_relative 'hash_item'

class HashClass

  def initialize(size)
    @items = Array.new(size)
  end

  def []=(key, value)
    i = index(key, size())
    # new hash pair
    if @items[i] == nil
      @items[i] = HashItem.new(key, value)
    # duplicate hash pair
    elsif @items[i].key == key && @items[i].value == value
      return "duplicate"
    # index is used, need to resize array, and update hash or add new pair
    else
      # resize until collision is fixed
      loop do
        resize()
        j = index(key, size())
        break if @items[j] == nil || @items[j].key == key
      end
      j = index(key, size())
      # keys are different and values are different, add new pair
      if @items[j] == nil
        @items[j] = HashItem.new(key, value)
      # keys are the same and values are different, update pair
      else
        @items[j].value = value
      end
    end
  end

  def [](key)
    i = index(key, size())
    if @items[i]
      return @items[i].value
    end
  end

  def resize
    # create transfer array
    arrXfer = Array.new(@items.length * 2)
    # for each element in the @items array, copy them into the new transfer
    # array and give them a new index based on the new array size
    (0...@items.length).each do |el|
      if @items[el]
        newIndex = @items[el].key.sum % arrXfer.length
        arrXfer[newIndex] = @items[el]
        @items[el] = nil
      end
    end
    # assign the transfer array to our hash array
    @items = arrXfer
  end

  # Returns a unique, deterministically reproducible index into an array
  # We are hashing based on strings, let's use the ascii value of each string as
  # a starting point.
  def index(key, size)
    return key.sum % size
  end

  # Simple method to return the number of items in the hash
  def size
    return @items.length
  end

end
