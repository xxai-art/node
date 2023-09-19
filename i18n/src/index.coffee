#!/usr/bin/env coffee

> ./env.js > CACHE_DIR
  ./nt.js
  ./toFrom.js
  @w5/ext
  @w5/walk > walkRel
  @xxai/is-change:IsChange
  @xxai/nt:Nt
  fs > statSync existsSync
  path > join

EXT_NT = '.nt'

tran = {
  md: =>
  nt
}

< (pwd, to)=>
  {i18n} = Nt(pwd)
  to_from = toFrom i18n, to

  [isChange,changeSave] = IsChange(
    pwd, CACHE_DIR
  )

  changed = new Set

  for [to_lang,from_lang] from to_from
    from_dir = join pwd, from_lang
    if not existsSync from_dir
      continue
    for await fp from walkRel(
      from_dir
      (i)=>
        i.startsWith('.') or i == 'node_modules'
    )
      e = ext fp
      if not e of tran
        continue
      from_rel = join from_lang,fp
      to_rel = join to_lang, fp
      from_fp = join pwd, from_rel
      to_fp = join pwd, to_rel
      if isChange(from_rel) or isChange(to_rel)
        await tran[e](
          pwd
          fp
          to_lang
          from_lang
        )
        changed.add to_rel
  changeSave changed
  return
