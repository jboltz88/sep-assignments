def bucket_sort(arr, bucket_size = 5)
  if arr.empty? || arr.length == 1
    return arr
  end

  # determine minimum and maximum values
  min = arr.min
  max = arr.max

  # calculate number of buckets needed, create array of buckets
  bucket_count = ((max - min) / bucket_size).ceil + 1
  buckets = Array.new(bucket_count)
  (0..buckets.length - 1).each do |i|
    buckets[i] = []
  end

  # put array values into buckets
  (0..arr.length - 1).each do |i|
    buckets[((arr[i] - min) / bucket_size).floor].push(arr[i])
  end

  # Sort buckets and place back into input array
  arr = []
  (0..buckets.length - 1).each do |i|
    buckets[i] = insertion_sort(buckets[i])
    buckets[i].each do |value|
      arr.push(value)
    end
  end

  arr
end

def insertion_sort(collection)
  sorted_array = [collection.delete_at(0)]

  until collection.length == 0
    insert_value = collection.shift
    i = 0
    until i == sorted_array.length || insert_value < sorted_array[i]
      i += 1
    end
    sorted_array.insert(i, insert_value)
  end

  sorted_array
end


arr = [3, 6, 1, 2, 8, 4, 9, 7, 5]
puts "#{bucket_sort(arr)}"
