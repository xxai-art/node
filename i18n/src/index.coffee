#!/usr/bin/env coffee

> @w5/yml/Yml
  os > homedir
  path > join
  @w5/xxhash3-wasm > hash128
  @xxai/cache
  ./toFrom.js
  ./yml.js

CACHE_DIR = process.env.CACHE_DIR or join(
  homedir()
  '.cache/xxai/i18n'
)

< (root)=>
  {i18n} = Yml(root)
  to_from = toFrom i18n.lang


  for dir from i18n.yml
    cache_path = join(
      CACHE_DIR
      Buffer.from(hash128(join(root, dir))).toString('base64url')
    )

    pwd = join(root,dir)
    y = Yml(pwd)
    fromYml = cache (name)=>
      y[name]

    ymlT = yml.bind(0,pwd)
    # todo check from_lang is change
    for [to_lang,from_lang] from to_from
       ymlT(
         to_lang
         y[to_lang] or {}
         from_lang
         fromYml(from_lang)
       )
    # save from_lang is mtime and size
  return
