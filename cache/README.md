[‼️]: ✏️README.mdt

# @xxai/cache

[test/main.coffee](./test/main.coffee) :

```coffee
#!/usr/bin/env coffee

> @xxai/cache

test = cache (a)=>
  console.log 'run test',a
  a+2


console.log test 123
console.log test 123
```

output :

```
run test 123
125
125
```
