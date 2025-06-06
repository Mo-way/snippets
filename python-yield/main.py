#!/usr/bin/env python3

def return_func():
    L = [1, 2, 3]
    return L

def yield_func():
    L = [1, 2, 3]
    for k in range(len(L)):
        yield L[k]


actual_copy = return_func()
generator = yield_func()
print(f"ret func {type(actual_copy)}")
print(f"ret func {[a for a in actual_copy]}")
print(f"Yield func {type(generator)}")
print(f"Yield func {[a for a in generator]}")
