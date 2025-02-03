func largest(A: Array<Int>) -> Int {
	var my_max: Int = A[0]
	for idx in 1..<A.count {
		if my_max < A[idx] {
			my_max = A[idx]
		}
	}
	return my_max
}

print(largest(A: [1, 5, 2, 9, 3, 4]))
