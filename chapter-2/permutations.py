#!/usr/bin/env python3

from itertools import permutations
from scipy.special import factorial
import time
import tabulate

def factorial_model(n, a):
	return a*factorial(n)

def check_sorted(a):
	for i, val in enumerate(a):
		if i > 0 and val < a[i-1]:
			return False
	return True

def permutation_sort(A):
	for attempt in permutations(A):
		if check_sorted(attempt):
			A[:] = attempt [:]
			print(A)
			return
		
# table = [5, 32, 21, 3332, 53, 12, 321, 543, 1212, 21423, 523, 123]
# permutation_sort()

# create a function that creates a table with descending order
def desc_call():
	val = 3909
	my_table = []
	for i in range(12):
		my_table.append(val)
		val = val // 2
		print(i, my_table)
	return

desc_call()
