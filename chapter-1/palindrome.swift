func is_palindrom(w: String) -> Bool {
	let myString = Array(w)
	var end = myString.count - 1
	
	var i = 0
	while i < end {
		while i < end && !myString[i].isLetter {
			i += 1
		}
		while i < end && !myString[end].isLetter {
			end -= 1
		}
		if myString[i].lowercased() != myString[end-1].lowercased() {
			return false
		}
		i+=1
		end-=1
	}
	return true
}

print(is_palindrom(w: "A man, a plan, a canal. Panama!"))