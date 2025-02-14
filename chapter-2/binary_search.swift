import Foundation



func binary_search(_ A: [Int], _ target: Int) -> (Int, Int) {
	
	var index = A.count/2 - 1
	var mid = A.count/2
	
	while A[index] != target {
		mid = mid/2
		if A[index] < target {
			index += index+mid
		} else if A[index] > target {
			index -= index-mid
		}
	}
	return (A[index], index)
}

func binary_array_search(_ A: [Int], _ target: Int) -> Bool {
	var lo = 0
	var hi = A.count - 1
	
	while lo <= hi {
		let mid = (lo + hi) / 2
		
		if target < A[mid] {
			hi = mid - 1
		} else if target > A[mid] {
			lo = mid + 1
		} else {
			return true
		}
	}
	return false
}
	
func binary_tree_final(_ A: inout [Int], _ target: Int) -> (Bool, Int?) {
	guard !A.isEmpty else { return (false, nil) }
	guard target >=  A.first! && target <= A.last! else { return (false, nil) }
	
	var lo = 0
	var hi = A.count - 1
	
	while lo <= hi {
		let mid = lo + (hi - lo) / 2
		if A[mid] > target {
			hi = mid - 1
		} else if A[mid] < target {
			lo = mid + 1
		} else {
			return (true, mid)
		}
	}
	print("value does not exist... inserting it...")
	A.insert(target, at: lo)
	print(lo, hi)
	print(A)
	return (false, nil)
}

var my_array = [3, 14, 15, 19, 26, 53, 125]
//print(binary_array_search(my_array, 14))
//print(binary_search(my_array, 58))
let result = binary_tree_final(&my_array, 20)
print(result.0, result.1)