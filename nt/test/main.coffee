#!/usr/bin/env coffee

> @xxai/nt

load = (li)=>
  if li.length > 0
    if li[0][0][1].startsWith '-'
      up = []
      func = list
    else
      up = {}
      func = dict
    for i from li
      func up,i
    return up
  {}

strli = (li)=>
  li.map(
    (i)=>i[0][1].slice(2)
  ).join('\n')

list = (up, li)=>
  t = li[0][1]
  if t.startsWith '-'
    up.push t.slice(1).trimStart()
  return

dict = (up, li)=>
  key = li[0][1]
  # for i from li[1]
  #   pprint up,i,indent+2
  # li = li[1]

  pos = key.indexOf(':')
  if ~ pos
    if pos == key.length - 1
      li1 = li[1]
      if li1.length > 0
        key = key.slice(0,-1)
        sub = li1[0][0][1]
        if sub.startsWith '>'
          up[key] = strli(li1)
        else
          if sub.startsWith '-'
            next = []
            func = list
          else
            func = dict
            next = {}
          up[key] = next
          for i from li1
            func(next, i)
      else
        up[key] = ''
    else
      up[key.slice(0,pos).trimEnd()] = key.slice(pos+1).trimStart()
  up

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
console.log load(li)

li = nt '''
- a
- b
'''
console.log load(li)
