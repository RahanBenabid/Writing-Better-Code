func largest_two(A: [Int]) -> (Int, Int) {
	var (my_max, second) = (A[1], A[0])
	if second > my_max {
		(my_max, second) = (second, my_max)
	}
	
	for idx in 2..<A.count {
		if my_max < A[idx] {
			(second, my_max) = (my_max, A[idx])
		} else if second < A[idx] {
			second = A[idx]
		}
	}
	
	return (my_max, second)
}

print(largest_two(A: [1, 5, 2, 9, 3, 4]))