> @w5/read
  @xxai/replace_n
  ./merge.js
  ./pick.js

< (md,cache_fp)=>
  [
    md
    pos_li
  ] = merge ReplaceN(md)
  console.log pick md,pos_li
