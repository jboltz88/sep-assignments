def quick_sort(collection)
  return collection if collection.length <= 1

  pivot = collection.delete_at(rand(0..collection.length - 1))
  lower = []
  higher = []
  sorted_arr = []

  (0..collection.length - 1).each do |i|
    if collection[i] < pivot
      lower << collection[i]
    else
      higher << collection[i]
    end
  end
  sorted_arr << quick_sort(lower)
  sorted_arr << pivot
  sorted_arr << quick_sort(higher)
  sorted_arr.flatten
end


arr = [3, 6, 1, 2, 8, 4, 9, 7, 5]
puts "#{quick_sort(arr)}"
