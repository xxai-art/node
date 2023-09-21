[‼️]: ✏️README.mdt

# @xxai/nt

[test/main.coffee](./test/main.coffee) :

```coffee
#!/usr/bin/env coffee

> @xxai/nt/loads.js
  @xxai/nt/dumps.js

# li = loads '''
# # t1
# a:
#   # t2
#   b:
#     c: 1
#     # t3
#     d: 2
#   x: 3
#   y:
#     - m
#     - n
# e:
#   f:
#     > 123
#     > 456
# '''
# console.log dumps li

li = loads '''
en:
zh:
  - abc: 3
  -
    1234: 3
    12: 3
'''
console.log li

# li = loads '''
# - a
# - b
# '''
# console.log dumps li
#
# li = loads '''
# a:
#   > 123
#   > 235
# b:
#   > 123
#   > 235
# '''
# console.log dumps li
```

output :

```
{ en: '', zh: [ 'abc: 3', { '12': '3', '1234': '3' } ] }
```
