enum MyError: Error {
    case valueError(String)
}

func median(my_list: Array<Int>) throws -> Int {
    guard my_list.count % 2 == 1 else {
        throw MyError.valueError("List should be odd")
    }
    
    let size = my_list.count
    let median_position = size / 2
    
    for idx in 0..<size {
        var bigger = 0
        var smaller = 0
        
        for j in 0..<size {
            if my_list[idx] < my_list[j] {
                smaller += 1
            } else if my_list[idx] > my_list[j] {
                bigger += 1
            }
        }
        
        if smaller == median_position {
            return my_list[idx]
        }
    }
    throw MyError.valueError("Median not found") 
}

func quickSelect(_ arr: inout [Int], _ left: Int, _ right: Int, _ k: Int) -> Int {
    let pivot = arr[right] // Choose last element as pivot
    var pIndex = left
    
    for i in left..<right {
        if arr[i] < pivot {
            arr.swapAt(i, pIndex)
            pIndex += 1
        }
    }
    
    arr.swapAt(pIndex, right) // Move pivot to correct position
    
    if pIndex == k {
        return arr[pIndex] // Found the median
    } else if pIndex < k {
        return quickSelect(&arr, pIndex + 1, right, k) // Search right
    } else {
        return quickSelect(&arr, left, pIndex - 1, k) // Search left
    }
}

func medianQuickSelect(_ myList: [Int]) throws -> Int {
    guard myList.count % 2 == 1 else {
        throw MyError.valueError("List should be odd")
    }
    var arr = myList // Copy to avoid modifying original array
    let medianIndex = myList.count / 2
    return quickSelect(&arr, 0, arr.count - 1, medianIndex)
}

// Example usage
do {
    let medianValue = try medianQuickSelect([7, 2, 1, 10, 5])
    print("Median:", medianValue) // Output: Median: 5
} catch {
    print(error)
}