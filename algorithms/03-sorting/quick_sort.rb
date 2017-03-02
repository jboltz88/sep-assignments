def quick_sort(collection)
  puts "collection: #{collection}"
  pivot = collection[rand(0..10)] # how to do random in ruby?
  sorted_collection = [pivot]
  pivot_index = 0
  (0...collection.length - 1).each do |i|
    if collection[i] < pivot
      sorted_collection.unshift(collection[i])
      pivot_index += 1
    else
      sorted_collection.push(collection[i])
    end
  end
  puts "pre-recursion: pivot: #{pivot} array: #{sorted_collection}"

  if sorted_collection[0...pivot_index].length > 1
    quick_sort(sorted_collection[0...pivot_index])
  end
  if sorted_collection[pivot_index...sorted_collection.length].length > 1
    quick_sort(sorted_collection[pivot_index...sorted_collection.length])
  end

  # answer
end


arr = [3, 1, 2, 8, 4, 9, 7, 5]
puts "#{quick_sort(arr)}"
