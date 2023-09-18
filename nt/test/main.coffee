#!/usr/bin/env coffee

> @xxai/nt


li = nt '''
# test
a:
  b:
    c: 1
    d: 2
  x: 3
  y:
    - m
    - n
e:
  f:
    > 123
    > 456
'''
console.log li

li = nt '''
- a
- b
'''
console.log li
