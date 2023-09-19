> @w5/read
  @xxai/replace_n
  ./merge.js
  ./pick.js
  @xxai/cache_map:CacheMap
  @w5/xxhash3-wasm > hash128

< (md,cache_fp)=>
  [
    md
    pos_li
  ] = merge ReplaceN(md)

  [mget,mset,msave]=  CacheMap cache_fp

  traned = []
  to_tran_pos = []
  for txt, n in pick(md,pos_li)
    p = pos_li[n]
    pre = mget hash128 txt
    if pre
      traned[p] = pre
    else
      to_tran_pos.push p

  console.log pick(md, to_tran_pos)
  # msave()
  return
