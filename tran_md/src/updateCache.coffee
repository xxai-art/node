> ./merge.js
  ./pick.js
  ./codePos.js
  @w5/xxhash3-wasm > hash128
  @xxai/replace_n
  @w5/read

< (from_lang, mget, mset, src, update_cache_fp)=>
  [
    md
    md_pos_li
    md_code_pos_li
  ] = merge ReplaceN(read update_cache_fp)
  if md.length == src.length
    for i from pick(src, md_pos_li)
      key = hash128 i
      if mget key
        console.log 'exist',i
    for [md_code_pos, code0, code_1, code_li, pos_li] from codePos(src, md_code_pos_li)
      for i from pick code_li,pos_li
        key = hash128 'code\r'+i
        if mget key
          console.log  'exist',i
  else
    console.warn "⚠️ Failed Update Cache",update_cache_fp,"length != #{from_lang}.length"
  return
  # for [md_code_pos, code0, code_1, code_li, pos_li] from codePos(
  #   md
  #   code_pos_li
  # )
