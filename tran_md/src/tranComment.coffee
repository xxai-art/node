#!/usr/bin/env coffee

> ./comment.js
  ./pick.js
  @w5/utf8/utf8d.js
  @w5/xxhash3-wasm > hash128
  @w5/tran > tranTxt

< (md, code_pos_li, mget, mset, to_lang, from_lang)=>
  for md_code_pos from code_pos_li
    code = md[md_code_pos].split('\n')
    lang = code[0].slice(3)
    if lang of comment
      code0 = code[0]+'\n'
      code_1 = '\n'+code.at(-1)
      [code_li, pos_li] = comment[lang] code.slice(1,-1).join('\n')

      to_tran_hash = []
      to_tran_pos = []
      to_tran_txt = []
      n = 0
      for i,pos in pick code_li,pos_li
        hash = hash128 'code\r'+i
        pre = mget hash
        pos = pos_li[n]
        if pre
          code_li[pos] = utf8d pre
        else
          to_tran_txt.push i
          to_tran_hash.push hash
          to_tran_pos.push pos
      n = 0
      for await i from tranTxt(to_tran_txt, to_lang, from_lang)
        code_li[to_tran_pos[n]] = i
        mset to_tran_hash[n], i
        ++n
      md[md_code_pos] = code0+code_li.join('')+code_1
  return
