> @w5/tran > tranHtm
  @w5/xxhash3-wasm > hash128
  @xxai/cache
  @w5/bar:Bar
  @xxai/cache_map:CacheMap
  @w5/write
  @w5/u8 > u8eq
  @xxai/nt/dump.js
  @xxai/nt/load.js
  path > join
  fs > readFileSync existsSync

cacheNt = cache load

< (dir, relpath, to_lang, from_lang)=>

  from_nt = cacheNt join dir, from_lang, relpath

  if not from_nt
    return

  to_nt = load(join dir, to_lang, relpath) or {}

  [mget,mset,msave]=  CacheMap(
    join dir,'.i18n', from_lang+'.'+to_lang, relpath
  )

  kli = []
  vli = []

  for [k,v] from Object.entries from_nt
    hash = hash128(v)
    if k of to_nt
      pre = mget(k)
      if pre and u8eq pre,hash
        continue
    mset k,hash
    kli.push k
    vli.push v

  {length} = vli
  if length
    n = 0
    bar = Bar(length)
    for await to from tranHtm vli, to_lang, from_lang
      to_nt[kli[n]] = to
      bar()
      bar.log '  '+vli[n],'→',to
      ++n

    dump(
      join dir, to_lang, relpath
      to_nt
    )
  msave()
  # console.log to_lang, from_lang, kli, vli
  return
