#!/usr/bin/env coffee

> ./dump.js
  ./load.js
  path > join
  fs > existsSync

EXT = '.nt'

< (dir)=>
  new Proxy(
    {}
    get:(_, file)=>
      fp = join dir, file+EXT
      if existsSync fp
        return load fp
      return

    set:(_, file, val)=>
      dump(
        join(
          dir, file+EXT
        )
        val
      )
      return val
  )
