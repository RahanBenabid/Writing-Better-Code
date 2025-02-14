# Writing-Better-Code

I will try using Swift for most of the code of this repo, if not all, I will be using 3 packages, and here are the python equivalent of them:
-	Swift Numerics & Accelerate → Numpy (for array and matrix operations).
-	Accelerate & Swift for TensorFlow → SciPy (for optimization, linear algebra, and advanced computations).
-	SwiftGraph → NetworkX (for graph-based network analysis).

# Chapter 1

## Some boring genreal knowledge

There is more to an *algorithm* than **simply** solving a problem, we need to know if it performs better than other algorithms, and what exact time it will take to execute but also how it would perform in different scenarios. For example, the `max()` method in Python always performs better in descending lists when going through an array.

Arrays are obviously one of the oldest data scrtuctures, it has fixed lengths, some languages like Java and Python can allow you to determine the length *at run time* which others like C don't. It cannot be extended or made smaller, instead, a new array should be created with the desired size and copy old values into it with the necessary modifications.

How do you determine which algorithm is better to use, for example let's take these two:

```py
def largest(A):
	my_max = A[0]
	for idx in range(1, len(A)):
		if my_max < A[idx]:
			my_max = A[idx]
	return my_max
```

```py
def alternate(A):
	for v in A:
		v_is_largest = True
		for x in A:
			if v < x:
				v_is_largest = False
				break
			if v_is_largest:
				return v
	return None
```

First one is pretty simple to compute, since the comparison is invoked N-1 times, but the second one has nested loops, and it's not that simple to compute them.

if for example our list is `[1, 5, 2, 9, 3, 4]`, in the first code less-than would end up being called N-1 anyways which is 5, meanwhile in the second case we call it 14 times.

So we just judge an algorithms' peformance by counting the number of times a key operation is performed...

> if we take the Python `max()` method, which is pretty much the same implementation as the `largest()` method, the pre-built python version will always outperform it, that's because the built-in functions in python are implemented within the interpreter.

So how can pick one algorithm over the other? It’s based on these factors:
1. Required extra strorage, and if it makes a copy of the original problem instance
2. The less lines the better
3. If it modifies the input provided (mutable or not)
4. if it outperforms the competition

It does not just depend on the operations inside but also the memeory it allocates over time, let’s take this example:

```py
def double_two(A):
	my_max = max(A)
	copy = list(A)
	copy.remove(my_max)
	return (my_max, max(copy))
	
def largest_two(A):
	my_max,second = A[:2]
	if my_max < second:
		my_max,second = second,my_max
		
	for idx in range(2, len(A)):
		if my_max < A[idx]:
			my_max,second = A[idx],my_max
		elif second < A[idx]:
			second = A[idx]
	return (my_max, second)
```

with smaller numbers like N = 4,096, 8,192, 16,384, `double_two()` will perform better, but once N > 262,144 `largest_two()` will become faster, that’s because it needs to allocate more memory as times goes on…

## Complexity

Since counting the number of operations can be tricky, and because of the difference in programming languages (for example Python or Java being executed by an interpreter)… And when doing so, you’d realize that the total number of operations varies on the size of the problem instance. That’s where the **time complexity** function `C(N)` comes to play.

With that we assume that each operation take a fixed amount of time `t` while being independent from the CPU of the machine.

In other words, the function  `C(N)`  gives us a way to estimate how the number of operations grows as  `N`  increases. However, analyzing the exact number of operations for every algorithm can be tedious. Instead, we often focus on the asymptotic behavior of  `C(N)` , which describes how it behaves for large  `N` .

Asymptotic Notation:
To simplify complexity analysis, we use asymptotic notation such as:
- Big-O notation  `O(f(N))` : Describes an upper bound on the growth rate of  `C(N)`.
- Omega notation  \Omega(f(N)) : Describes a lower bound on  C(N).
- Theta notation  $\Theta(f(N))$ : Describes a tight bound, meaning  `C(N)` grows at the same rate as  `f(N)`.

For example, if an algorithm runs approximately  $5N^2 + 3N + 2$  operations, we simplify its growth rate to $O(N^2)$, ignoring constants and lower-order terms.

But like seen before, we should also consider the **space complexity**, the amount of memory needed to be allocated in the RAM for the program to execute, i also should note that the space complexity is independent from the size of the problem instance, no matter the size of the problem instance, its extra space never changes.

# Chapter 2

When working on algorithms and programs, it’s important to ensure they are efficient and scalable, especially as problem sizes grow. Start by analyzing the data structures and algorithms you’re using, and ask yourself if there’s a better way to solve the problem or implement the solution. Performance can vary based on the hardware, so it’s crucial to model and predict runtime behavior as data scales.

One effective way to predict performance is by using empirical models. By testing your program on smaller data sets, you can gather runtime data and use it to build mathematical models, such as linear, quadratic, or N log N, to estimate how the program will perform on larger data sets. For example, if your program processes data sets of 100, 1,000, and 10,000 elements, you can use this data to predict runtime for 100,000 or even 1,000,000 elements. The N log N model often provides the most accurate predictions for runtime as problem sizes increase.

A practical example involves processing large data sets in a nightly batch job. If your prototype works well on small data sets, you can use empirical models to ensure it will handle much larger data sets efficiently. For instance, a model like T(N) = a × N × log(N) can accurately predict runtime for large problem sizes, helping you avoid performance bottlenecks.

Another example is multiplying large integers. Traditional methods, like the grade-school algorithm, have a quadratic runtime (N²), meaning the time increases significantly as the number of digits grows. However, more advanced algorithms, like Karatsuba multiplication, have a runtime of N^1.585, which is much more efficient for large inputs. This shows that choosing the right algorithm can drastically improve performance.

In summary, to ensure your programs are efficient and scalable:

1. Analyze your algorithms and data structures to identify potential inefficiencies.
2. Use empirical data from smaller problem instances to build mathematical models and predict runtime for larger inputs.
3. Focus on models like N log N, which often provide accurate predictions for runtime growth.
4. Consider advanced algorithms (like Karatsuba) for tasks that involve large inputs, as they can significantly improve performance.
5. Always test and review your code to ensure it performs well across different problem sizes and hardware.

By following these steps, you can optimize your programs to handle larger data sets efficiently and avoid performance issues.

## Performance classes

To identify which algorithm has the best performance, it’s good to classify them using mathemtical models, the goal is to predict the **worst runtime performance**, where `N` is the upper bound, so we try to work with a logic like "the algorithm will never be worse than this"

For that scienctists have used something called Big O notation to calculate how efficient an algorithm is without depending on the hardware used, it is used for both the best case and worst case intance of a problem.

So the goal is to estimate the time for an algorithm to process any problem instance of size N, it must be accurate for all the N instances, for that:
1. find `k(N)`, how many times a key operation executes on a worst case scenario
2. estimate that the number of machine insctructions executed in total would be a multiple of this count so `c * k(N)`, this is because  modern programming languages can be compiled into tends of hundreds of machine instructions

So each performance class `O(f(N))` can be described as some `f(N)`, here are some examples:
- `O(N)` is the linear complexity class, where `f(N) = N`.
- `O(N1.585)` is the Karatsuba complexity class, where `f(N) = N1.585`
- `O(N2)` is the quadratic complexity class, where `f(N) = N2`
- `O(N log N)` is the complexity class where `f(N) = N × log N`.

for example let’s take this simple code sample:

```py
for i in range(100):
	for j in range(N):
		ct = ct + 1
```

the total number of executions of ct = ct + 1 is: $100 \times N$



however, when executing on a machine many times, the exact execution time depends on the machine running the code, everything will vary due to different CPUs speed, the memory used.

## Complexity classes

Let's take `log(N)` as an example, how this complexity works is when the execution time grows proportionally to the algorithm of the input size `n`, and the problem size is reduced by a constant factor in each step, a perfect example would be the binary search algorithm, here is an emplementation in python:

```py
def binary_search(A, target):
	lo = 0
	hi = len(A) - 1
	
	while lo <= hi:
		mid = (lo + hi) // 2
		
		if target < A[mid]:
			hi = mid - 1
		elif target > A[mid]:
			lo = mid + 1
		else:
			return mid
	return -(lo+1)
```

So the `while` loop will be repeated when `lo <= hi`, and the first iteration starts with `N` values to search through, but in the second iteration, it turns into `N/2`, and it keeps getting devided by 2 until (in the worst scenario) it reaches 1.

And to know how many times we divided by two, the quantity will be $k = \log_2(N)$, hence the logarithmic complexity, this is super efficient, as in one million values in an array, we need to loop only **20 times**.

There are many complexity classes, but the most known are the following:
- The linear, O(N), complexity class means complexity is directly proportional to the size of the problem instance.
- A series of polynomial classes are all of increasing complexity—O(N^2), O(N^3), and so on—up to any fixed constant, O(N^c).
- Sandwiched between O(N) and O(N^2) is O(N log N), which is often identified as the **best** complexity class for algorithm designers.
- The last class is the exponential and factorial complexity O(N!) and O(2^N), these can solve very small problems and are inneficient most of the time in real world problems.

The most important part of algorithms is knowing which is the **dominant one**, if we create an algorithm where a subset has a complexity of O(N^3) and another subset is of complexity O(N log N), the classification would be O(N^3), because it has a dominant impact on the overall complexity. Also multiplicative constants can be ignored, for example O(30*N) is the same as O(N).

Here is a table that summerizes how complexity increments:

| N     | log(N) | N     | N log N | N²       | N³         | 2ⁿ          | N!          |
|-------|--------|-------|---------|----------|----------- |-------------|-------------|
| 2     | 1      | 2     | 2       | 4        | 8          | 4           | 2           |
| 4     | 2      | 4     | 8       | 16       | 64         | 16          | 24          |
| 8     | 3      | 8     | 24      | 64       | 512        | 256         | 40,320      |
| 16    | 4      | 16    | 64      | 256      | 4,096      | 65,536      | 2.1 × 10¹³  |
| 32    | 5      | 32    | 160     | 1,024    | 32,768     | 4.3 × 10⁹   | 2.6 × 10³⁵  |
| 64    | 6      | 64    | 384     | 4,096    | 262,144    | 1.8 × 10¹⁹  | 1.3 × 10⁶⁹  |
| 128   | 7      | 128   | 896     | 16,384   | 2,097,152  | 3.4 × 10³⁸  | -           |
| 256   | 8      | 256   | 2,048   | 65,536   | 16,777,216 | 1.2 × 10⁷⁷  | -           |
| 512   | 9      | 512   | 4,608   | 262,144  | 1.3 × 10⁸  | -           | -           |
| 1,024 | 10     | 1,024 | 10,240  | 1,048,576| 1.1 × 10⁹  | -           | -           |
| 2,048 | 11     | 2,048 | 22,528  | 4,194,304| 8.6 × 10⁹  | -           | -           |

