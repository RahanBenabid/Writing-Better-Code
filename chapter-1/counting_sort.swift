func counting_sort(_ my_array: [Int]) -> [Int] {
	// get the max value of a list then create a new array
	guard let max_value = my_array.max() else {
		return []
	}
	
	var C = Array(repeating: 0, count: max_value + 1)
	
	for element in my_array {
		C[element] += 1
	}
	
	print(C)
	
	var sorted_array: [Int] = []
	for (index, count) in C.enumerated() {
		for _ in 0..<count {
			sorted_array.append(index)
		}
	}
	
	return sorted_array
}

let sorted = counting_sort([4, 2, 2, 8, 3, 3, 1])
print("Sorted array:", sorted)