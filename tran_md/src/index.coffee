> @w5/read
  ./merge.js
  ./pick.js
  ./psfix.js
  ./tranComment.js
  @w5/htm2md
  @w5/md2htm
  @w5/tran > tranHtm
  @w5/utf8/utf8d.js
  @w5/utf8/utf8e.js
  @w5/xxhash3-wasm > hash128
  @xxai/cache_map:CacheMap
  @xxai/replace_n
  @xxai/title-case

< (md, from_lang)=>
  # 找到可以翻译的行，然后转html，翻译之后再转回来

  [
    src
    pos_li
    code_pos_li
  ] = merge ReplaceN(md)

  (to_lang, cache_fp) =>
    md = src.slice()
    [mget,mset,msave]=  CacheMap cache_fp

    to_tran_hash = []
    to_tran_htm = []
    to_tran_pos = []
    to_tran_prefix = []
    to_tran_suffix = []

    await tranComment(
      md, code_pos_li, mget, mset
      to_lang
      from_lang
    )

    for txt, n in pick(md,pos_li)
      pos = pos_li[n]
      hash = hash128 txt
      pre = mget hash
      if pre
        md[pos] = utf8d(pre)+'\n'
      else
        [prefix, t, suffix] = psfix txt
        to_tran_prefix.push prefix
        to_tran_suffix.push suffix
        to_tran_htm.push (await md2htm t).trimEnd()
        to_tran_pos.push pos
        to_tran_hash.push hash

    n = 0
    for await i from tranHtm(to_tran_htm,to_lang, from_lang)
      p = to_tran_prefix[n]
      i = htm2md i
      if p.charAt(0) == '#'
        i = TitleCase i
      txt = p + i + to_tran_suffix[n]
      mset to_tran_hash[n], txt
      md[to_tran_pos[n]] = txt+'\n'
      n++

    msave()
    md.join('')
