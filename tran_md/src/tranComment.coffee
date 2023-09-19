#!/usr/bin/env coffee

> ./comment.js
  ./pick.js

< (md, code_pos_li, mget, mset)=>
  for pos from code_pos_li
    code = md[pos].split('\n')
    lang = code[0].slice(3)
    if lang of comment
      [code_li, pos_li] = comment[lang] code.slice(1,-1).join('\n')
      console.log lang, code_li, pos_li
      for c from pick code_li,pos_li
        console.log c
  return
