#!/usr/bin/env coffee

> @xxai/nt:Nt
  path > join
  @xxai/cache
  ./toFrom.js
  ./nt.js
  fs > statSync
  ./IsChange.js

EXT_YML = '.nt'

< (root)=>
  {i18n} = Nt(root)
  to_from = toFrom i18n.lang


  for dir from i18n.nt

    pwd = join(root,dir)
    [isChange,changeSave] = IsChange(pwd)

    y = Nt(pwd)
    fromNt = cache (name)=>
      y[name]

    ntT = nt.bind(0,pwd)
    changed = new Set
    for [to_lang,from_lang] from to_from
      to_lang_nt = to_lang + EXT_YML
      from_lang_nt = from_lang + EXT_YML
      if isChange(from_lang_nt) or isChange(to_lang_nt)
        await ntT(
          to_lang
          y[to_lang] or {}
          from_lang
          fromNt(from_lang)
        )
        changed.add to_lang
    changeSave [...changed].map (i)=>i+EXT_YML
  return
