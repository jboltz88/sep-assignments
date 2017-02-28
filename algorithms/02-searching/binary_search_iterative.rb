def binary_search(collection, value)
  low = 0
  high = collection.length - 1

  while low <= high
    mid = (low + high) / 2
    if collection[mid] > value
      high = mid - 1
    elsif collection[mid] < value
      low = mid + 1
    else
      return collection[mid]
    end
  end

  return "not found"
end

arr = []
(0...1000).each do |x|
  arr.push(x)
end
puts binary_search(arr, 3)
