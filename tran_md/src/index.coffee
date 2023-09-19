> @w5/read
  @w5/tran > tranHtm
  @w5/md2htm
  @w5/htm2md
  @xxai/title-case
  @w5/utf8/utf8d.js
  @w5/utf8/utf8e.js
  @xxai/replace_n
  ./merge.js
  ./pick.js
  ./prefix.js
  @xxai/cache_map:CacheMap
  @w5/xxhash3-wasm > hash128

< (md)=>
  # 找到可以翻译的行，然后转html，翻译之后再转回来

  [
    md
    pos_li
    code_pos_li
  ] = merge ReplaceN(md)

  (to_lang, from_lang, cache_fp) =>
    [mget,mset,msave]=  CacheMap cache_fp

    to_tran_hash = []
    to_tran_htm = []
    to_tran_pos = []
    to_tran_prefix = []

    for i from pick(md, code_pos_li)
      console.log i

    for txt, n in pick(md,pos_li)
      pos = pos_li[n]
      hash = hash128 txt
      pre = mget hash
      if pre
        md[pos] = utf8d pre
      else
        [p, t] = prefix txt
        to_tran_prefix.push p
        to_tran_htm.push (await md2htm t).trimEnd()
        to_tran_pos.push pos
        to_tran_hash.push hash

    n = 0
    for await i from tranHtm(to_tran_htm,to_lang, from_lang)
      p = to_tran_prefix[n]
      i = htm2md i
      if p.charAt(0) == '#'
        i = TitleCase i
      txt = p + i
      mset to_tran_hash[n], txt
      md[to_tran_pos[n]] = txt
      n++

    msave()
    md.join('\n')
