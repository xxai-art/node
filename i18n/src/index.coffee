#!/usr/bin/env coffee

> @w5/yml/Yml
  path > join
  @xxai/cache
  ./toFrom.js
  ./yml.js
  fs > statSync
  ./IsChange.js

EXT_YML = '.yml'

< (root)=>
  {i18n} = Yml(root)
  to_from = toFrom i18n.lang


  for dir from i18n.yml

    pwd = join(root,dir)
    [isChange,changeSave] = IsChange(pwd)

    y = Yml(pwd)
    fromYml = cache (name)=>
      y[name]

    ymlT = yml.bind(0,pwd)
    changed = new Set
    for [to_lang,from_lang] from to_from
      to_lang_yml = to_lang + EXT_YML
      from_lang_yml = from_lang + EXT_YML
      if isChange(from_lang_yml) or isChange(to_lang_yml)
        await ymlT(
          to_lang
          y[to_lang] or {}
          from_lang
          fromYml(from_lang)
        )
        changed.add to_lang
    changeSave [...changed].map (i)=>i+EXT_YML
  return
