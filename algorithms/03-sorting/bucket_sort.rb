def bucket_sort(arr, bucket_size = 5)
    if arr.empty? || arr.length == 1
      return arr
    end

    # determine minimum and maximum values
    min = arr.min
    max = arr.max

    # calculate number of buckets needed, create array of buckets
    bucket_count = ((max - min) / bucket_size).ceil
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
      buckets[i].insertion_sort
      buckets[i].each do |value|
        arr.push(value)
      end
    end
  end
end

def insertion_sort(collection)
  sorted_collection = [collection.delete_at(0)]

  for val in collection
    sorted_collection_index = 0
    while sorted_collection_index < sorted_collection.length
      if val <= sorted_collection[sorted_collection_index]
        sorted_collection.insert(sorted_collection_index, val)
        break
      elsif sorted_collection_index == sorted_collection.length - 1
        sorted_collection.insert(sorted_collection_index + 1, val)
        break
      end

      sorted_collection_index += 1
    end
  end

  sorted_collection
end


arr = [3, 1, 2, 8, 4, 9, 7, 5]
puts "#{bucket_sort(arr)}"
