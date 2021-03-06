#!/usr/bin/python3.7
# cython: language_level=3
# -*- coding: utf-8 -*-
# @Time  : 2020/3/21 11:55
# @Author: Jtyoui@qq.com
from random import randrange
import math

cpdef get_prime_rounds(number):
    bit_size = number.bit_length()
    if bit_size >= 1536:
        return 3
    if bit_size >= 1024:
        return 4
    if bit_size >= 512:
        return 7
    return 10

cpdef is_prime(n):
    cdef s = n - 1
    cdef f = s
    cdef t = 0
    cdef int k = get_prime_rounds(n)
    if n <= 4:
        return [False, False, True, True, False][n]
    while s % 2 == 0:
        s //= 2
        t += 1
        for _ in range(k):
            a = randrange(2, f)
            v = pow(a, s, n)
            if v != 1:
                i = 0
                while v != f:
                    if i == t - 1:
                        return False
                    else:
                        i += 1
                        v = (v ** 2) % n
        return True
    return False

cpdef get_large_prime_length(length=500):
    cdef size = 10 ** length
    cdef n = 10 ** (length - 1)
    while True:
        num = randrange(n, size)
        if is_prime(num):
            return num

cpdef prime_range(start, end):
    cdef sieve = [True] * end
    cdef primes = []
    sieve[0] = False
    sieve[1] = False
    for i in range(2, int(math.sqrt(end)) + 1):
        point = i * 2
        while point < start:
            point += i
        while point < end:
            sieve[point] = False
            point += i

    for i in range(start, end):
        if sieve[i]:
            primes.append(i)
    return primes

cpdef get_large_prime_bit_size(bit_size=512):
    cdef size = 2 ** bit_size
    cdef n = 2 ** (bit_size - 1)
    while True:
        num = randrange(n, size)
        if is_prime(num):
            return num
