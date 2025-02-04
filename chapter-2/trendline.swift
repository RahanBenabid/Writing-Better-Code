import Foundation
import Accelerate

func linear_model(x: [Double], y: [Double]) -> (a: Double, b: Double)? {
	guard x.count == y.count, x.count > 1 else {
		return nil
	}
	
	let sumX = x.reduce(0, +)
	let sumY = y.reduce(0, +)
	let sumXY = zip(x, y).map(*).reduce(0, +)
	let sumX2 = x.map { $0 * $0 }.reduce(0, +)
	let n = Double(x.count)
	
	let denominator = (n * sumX2 - sumX * sumX)
	guard denominator != 0 else { return nil }
	
	let a = (n * sumXY - sumX * sumY) / denominator
	let b = (sumY - a * sumX) / n
	
	return (a, b)
}

let xs: [Double] = [100, 1000, 10000]
let ys: [Double] = [0.063, 0.565, 5.946]

if let (a, b) = linear_model(x: xs, y: ys) {
	print("Linear = \(a) * N + \(b)")
} else {
	print("Could not fit the model")
}