#!/usr/bin/env coffee

> ./IsChange.js
  ./nt.js
  ./toFrom.js
  @w5/ext
  @w5/walk > walkRel
  @xxai/nt:Nt
  fs > statSync existsSync
  path > join

EXT_NT = '.nt'


tran = {
  md: =>
  nt
}

< (pwd)=>
  console.log pwd
  {i18n} = Nt(pwd)
  console.log i18n
  to_from = toFrom i18n

  [isChange,changeSave] = IsChange(pwd)

  changed = new Set

  for [to_lang,from_lang] from to_from
    from_dir = join pwd, from_lang
    to_dir = join pwd, to_lang
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
      from_fp = join from_dir, fp
      to_fp = join to_dir, fp
      if isChange(from_fp) or isChange(to_fp)
        await tran[e](
          pwd
          fp
          to_lang
          from_lang
        )
        changed.add to_fp
# changeSave [...changed].map (i)=>i+EXT_NT

  # for await fp from walkRel(
  #   pwd
  #   (i)=>
  #     i.startsWith('.') or i == 'node_modules'
  # )
  #   pos = fp.lastIndexOf '.'
  #   if not ~ pos
  #     continue
  #   ext = fp.slice(pos+1)
  #   if not ext of tran
  #     continue
  # for [to_lang,from_lang] from to_from
  #   to_lang_nt = to_lang + EXT_NT
  #   from_lang_nt = from_lang + EXT_NT
  #   if isChange(from_lang_nt) or isChange(to_lang_nt)
  #     changed.add to_lang
  # changeSave [...changed].map (i)=>i+EXT_NT
  return
