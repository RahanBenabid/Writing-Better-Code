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