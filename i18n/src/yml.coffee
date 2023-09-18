> @w5/tran > tranTxt
  @w5/xxhash3-wasm > hash128
  @w5/binmap > BinMap
  @w5/yml > dump
  @w5/write
  @w5/u8 > u8eq
  path > join
  fs > readFileSync existsSync

< (dir, to_lang, to_yml, from_lang, from_yml)=>
  if not from_yml
    return

  cache_fp = join dir,'.i18n',from_lang, to_lang

  if existsSync cache_fp
    prem = BinMap.load readFileSync cache_fp
  m = new BinMap # 每次都重建，这样可以淘汰不存在的key

  kli = []
  vli = []

  for [k,v] from Object.entries from_yml
    hash = hash128(v)
    m.set k,hash
    if k of to_yml
      if prem
        pre = prem.get(k)
        if pre and u8eq pre,hash
          continue
    kli.push k
    vli.push v

  if not vli.length
    return

  if vli.length
    console.log from_lang, '→', to_lang
    n = 0
    for await to from tranTxt vli, to_lang, from_lang
      to_yml[kli[n]] = to
      console.log '  '+vli[n],'→',to
      ++n

    dump(
      join dir, to_lang+'.yml'
      to_yml
    )
    write(
      cache_fp
      m.dump()
    )
  # console.log to_lang, from_lang, kli, vli
  return
