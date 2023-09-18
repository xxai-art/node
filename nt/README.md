[‼️]: ✏️README.mdt

# @xxai/nt

[test/main.coffee](./test/main.coffee) :

```coffee
#!/usr/bin/env coffee

> @xxai/nt/load.js
  @xxai/nt/dump.js

# li = load '''
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
# console.log dump li

li = load '''
en:
zh: en
'''
console.log li

# li = load '''
# - a
# - b
# '''
# console.log dump li
#
# li = load '''
# a:
#   > 123
#   > 235
# b:
#   > 123
#   > 235
# '''
# console.log dump li
```

output :

```
./out.txt
```
