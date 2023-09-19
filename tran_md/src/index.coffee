> @w5/read
  @w5/tran > tranTxt
  @w5/md2htm
  @w5/htm2md
  @xxai/replace_n
  ./merge.js
  ./pick.js
  @xxai/cache_map:CacheMap
  @w5/xxhash3-wasm > hash128

< (md)=>
  # 找到可以翻译的行，然后转html，翻译之后再转回来

  [
    md
    pos_li
  ] = merge ReplaceN(md)

  (cache_fp) =>
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

    to_tran = pick(md, to_tran_pos)

    console.log to_tran


    msave()
    return
