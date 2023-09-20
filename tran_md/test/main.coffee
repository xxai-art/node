#!/usr/bin/env coffee

> @xxai/tran_md
  @w5/uridir
  @w5/read
  path > join
  @w5/write

ROOT = uridir(import.meta)

fp = join(ROOT, 'zh.md')
en_fp = join ROOT,'en.md'

en = await TranMd(
  read(fp)
  'zh'
)(
  'en'
  join(ROOT,'.cache')
  en_fp
)

# write(
#   en_fp
#   en
# )
