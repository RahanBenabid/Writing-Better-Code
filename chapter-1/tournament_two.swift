func tournament_two(A: [Int]) -> (Int, Int) {
	let N: Int = A.count
	var winner = Array(repeating: 0, count: N-1)
	var loser = Array(repeating: 0, count: N-1)
	var prior = Array(repeating: -1, count: N-1)
	
	var idx = 0
	// picks the winners of the first round
	for i in stride(from: 0, to: N, by: 2) {
		if A[i] < A[i+1] {
			winner[idx] = A[i+1]
			loser[idx] = A[i]
		} else {
			winner[idx] = A[i]
			loser[idx] = A[i+1]
		}
		idx += 1
	}
	
	var m = 0
	
	// start with the other rounds
	while idx < N-1 {
		// compares winners
		if winner[m] < winner[m+1] {
			winner[idx] = winner[m+1]
			loser[idx] = winner[m]
			prior[idx] = m+1
		} else {
			winner[idx] = winner[m]
			loser[idx] = winner[m+1]
			prior[idx] = m
		}
		m += 2
		idx += 1
	}
	
	let largest = winner[m]
	var second = loser[m]
	m = prior[m]
	while m >= 0 {
		if second < loser[m] {
			second = loser[m]
		}
		m = prior[m]
	}
	
	return (largest, second)
}