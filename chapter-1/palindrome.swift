func is_palindrom(w: String) -> Bool {
	let myString = Array(w)
	var end = myString.count - 1
	
	var i = 0
	while i < end {
		while !myString[i].isLetter || !myString[end-1].isLetter {
			if !myString[i].isLetter {
				i+=1
			}
			if !myString[end-1].isLetter {
				end-=1
			}
		}
		if myString[i].lowercased() != myString[end-1].lowercased() {
			return false
		}
		i+=1
		end-=1
	}
	return true
}

print(is_palindrom(w: "3A man, a plan, a canal. Panama!"))