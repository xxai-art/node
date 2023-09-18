#!/usr/bin/env coffee

> @w5/yml/Yml
  os > homedir
  path > join
  @w5/xxhash3-wasm > hash128
  @xxai/cache
  ./toFrom.js
  ./yml.js
  fs > statSync
  ./IsChange.js


< (root)=>
  {i18n} = Yml(root)
  to_from = toFrom i18n.lang


  for dir from i18n.yml

    pwd = join(root,dir)
    y = Yml(pwd)
    fromYml = cache (name)=>
      y[name]

    ymlT = yml.bind(0,pwd)
    for [to_lang,from_lang] from to_from
      fstat = statSync join pwd, from_lang+'.yml'
      console.log fstat
      await ymlT(
        to_lang
        y[to_lang] or {}
        from_lang
        fromYml(from_lang)
      )
    # save from_lang is mtime and size
  return
