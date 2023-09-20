#!/usr/bin/env coffee
> @xxai/cache
  @xxai/tran_md
  @w5/read
  @w5/write
  path > join

tranMd = cache (dir, relpath, from_lang)=>
  console.log relpath
  TranMd(
    read join(dir, from_lang, relpath)
    from_lang
  )

< (dir, relpath, to_lang, from_lang)=>
  tran = tranMd(dir, relpath, from_lang)
  out = await tran(
    to_lang
    join dir,'.i18n',"#{from_lang}.#{to_lang}", relpath
  )
  write(
    join dir, to_lang, relpath
    out
  )
  return
