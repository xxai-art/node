#!/usr/bin/env coffee

> @xxai/cache
  @w5/xxhash3-wasm > hash128
  @w5/u8 > u8eq
  fs > statSync readFileSync existsSync
  path > join
  @xxai/vbyte > vbyteE
  ./env.js > CACHE_DIR
  @w5/binmap > BinMap
  @w5/write

< (dir)=>
  cache_path = join(
    CACHE_DIR
    Buffer.from(hash128(dir)).toString('base64url')
  )
  m = new BinMap
  if existsSync cache_path
    pre = BinMap.load readFileSync cache_path
    isChange = cache (rfp)=> # isChange
      fp = join dir, rfp
      if existsSync fp
        stats = statSync fp
        size_mtime = vbyteE [stats.size,stats.mtime]
        hash = hash128(rfp)
        m.set hash, size_mtime
        pre_sm = pre.get(hash)
        if pre_sm
          return not u8eq size_mtime, pre_sm
      true
  else
    isChange = => true
  [
    isChange
    (li)=> # save
      for fp from li
        stats = statSync join dir,fp
        m.set hash128(fp), vbyteE [
          stats.size,stats.mtime
        ]
      write(
        cache_path
        m.dump()
      )
      return
  ]
