#!/usr/bin/env coffee

> @w5/yml/Yml
  os > homedir
  path > join
  @w5/xxhash3-wasm > hash128
  ./toFrom.js


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

    from_cache = new Map
    # todo check from_lang is change
    for [to_lang,from_lang] from to_from
      console.log from_lang
    # save from_lang is mtime and size
  return
