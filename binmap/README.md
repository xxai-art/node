# wasm

wasm wrapper for rust BTreeSet https://doc.rust-lang.org/std/collections/struct.BTreeSet.html

use :
[→ test.coffee](test.coffee)

```coffee
#!/usr/bin/env coffee

> ./pkg/_ > BinSet

set = new BinSet

txt = """set.add(Buffer.from [1])
set.has([2])
set.has([1])
set.add(new Uint8Array([1]))
set.has([1])
set.size
set.dump()
BinSet.load(set.dump(),1).size
set.delete([1])
set.size
set.has([1])
set.delete([1])
set.has([2])""".split('\n')

[
  set.add(Buffer.from [1])
  set.has([2])
  set.has([1])
  set.add(new Uint8Array([1]))
  set.has([1])
  set.dump()
  set.size
  BinSet.load(set.dump(),1).size
  set.delete([1])
  set.size
  set.has([1])
  set.delete([1])
  set.has([2])
].map (i,pos)=>console.log(txt[pos],'=',i)
```


out :
[→ out.txt](out.txt)

```txt
set.add(new Uint8Array([1])) = true
set.has([1]) = true
set.size = Uint8Array(1) [ 1 ]
set.dump() = 1
BinSet.load(set.dump(),1).size = 1
set.delete([1]) = true
set.size = 0
set.has([1]) = false
set.delete([1]) = false
set.has([2]) = false
```

