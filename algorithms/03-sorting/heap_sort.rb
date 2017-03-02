def heap_sort(arr)
	# heapify
	(1..arr.length - 1) do |i|
		# move up element to establish max heap
		child = i
		while child > 0
			parent = (child - 1) / 2
			if arr[parent] < arr[child]
        temp = arr[parent]
				arr[parent] = arr[child]
        arr[child] = temp
				child = parent
			else
				break
			end
		end
	end

	# sort
	i = arr.length - 1
  # swap max heap value (root) to the end of the array
	while i > 0
    temp = arr[0]
		arr[0] = arr[i]
    arr[i] = temp
    # prepare next sorted location
		i -= 1

		# move down swapped element to maintain max heap
		parent = 0
		while parent * 2 + 1 <= i
      # left child
			child = parent * 2 + 1
      # if left child is ____ and left child is less than right child, use right child
			if child < i && arr[child] < arr[child + 1]
				child += 1
			end
      # if parent element is less than child element, swap the two
			if arr[parent] < arr[child]
        temp = arr[child]
        arr[child] = arr[parent]
				arr[parent] = temp
				parent = child
			else
				break
			end
		end
	end
end

arr = [1, 9, 3, 8, 7, 2, 6, 4, 5]
puts "#{heap_sort(arr)}"
