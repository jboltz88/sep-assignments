def poorly_written_ruby(*arrays)
  combined_array = []

  arrays.each do |array|
    combined_array += array
  end

  return bubble_sort(combined_array)
end

def bubble_sort(collection)
  n = collection.length
  begin
    swapped = false

    (n - 1).times do |i|
      if collection[i] > collection[i + 1]
        tmp = collection[i]
        collection[i] = collection[i + 1]
        collection[i + 1] = tmp
        swapped = true
      end
    end
  end until not swapped

  collection
end

puts "#{poorly_written_ruby([2,4,1], [3,7], [8,6,5])}"
