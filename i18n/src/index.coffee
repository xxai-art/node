#!/usr/bin/env coffee

> ./nt.js
  ./md.js
  ./toFrom.js
  @w5/ext
  @w5/bar:Bar
  @w5/walk > walkRel
  @xxai/is-change
  @xxai/nt:Nt
  fs > statSync existsSync
  path > join

EXT_NT = '.nt'

tran = {
  md
  nt
}

< (pwd, to)=>
  {i18n} = Nt(pwd)
  to_from = toFrom i18n, to

  [isChange,changeSave] = IsChange(
    join pwd,'.i18n'
    pwd
  )

  changed = new Set

  bar = Bar to_from.length
  for [to_lang,from_lang] from to_from
    bar()
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
      from_change = isChange(from_rel)
      bar.log from_lang, '→', to_lang
      if from_change or isChange(to_rel)
        await tran[e](
          pwd
          fp
          to_lang
          from_lang
        )
        changed.add to_rel
  if not to # 不然可能缓存了中间态，比如中译英，英还没译为其他，但是已经缓存了英文的哈希
    changeSave changed
  return
