> @w5/read
  @xxai/replace_n
  ./merge.js

< (md,cache_fp)=>
  [
    md
    pos_li
  ] = merge ReplaceN(md)
  console.log md
  console.log pos_li
