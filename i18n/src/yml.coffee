> @w5/tran > tranTxt
  @w5/xxhash3-wasm > hash128
  @w5/binmap > BinMap
  @w5/write
  fs > readFileSync existsSync

< (dir, to_lang, to_yml, from_lang, from_yml)=>
  if not from_yml
    return

  cache_fp = join dir,'.i18n',from_lang, to_lang

  if existsSync cache_fp
    binmap = BinMap.load readFileSync cache_fp
    return

  for [k,v] from Object.entries from_yml
    console.log k,v
    # k - v - tran

  console.log to_lang, from_lang, from_yml
  return
