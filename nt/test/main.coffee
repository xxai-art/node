#!/usr/bin/env coffee

> @xxai/nt/load.js


li = load '''
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

li = load '''
- a
- b
'''
console.log li
