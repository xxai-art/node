#!/usr/bin/env coffee

> @w5/yml/Yml
  @w5/lang

langFrom = (lang_li)=>
  s = new Map
  for [k,li] from Object.entries lang_li
    if li
      for v from li.split ' '
        s.set v,k
    else
      s.set '',k

  to_from = []
  + all
  exist = new Set
  for [to_lang,from_lang] from s.entries()
    exist.add from_lang
    if to_lang
      to_from.push [to_lang, from_lang]
      exist.add to_lang
    else
      all = from_lang

  if all
    for [i] from lang
      if not exist.has i
        to_from.push [i,all]

  to_from



< (root)=>
  {i18n} = Yml(root)
  to_from = langFrom i18n.lang

  for dir from i18n.yml
    console.log dir
  # for [code] from lang
  #   console.log code
  return
