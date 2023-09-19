#!/usr/bin/env coffee

> @xxai/tran_md
  @w5/uridir
  @w5/read
  path > join

ROOT = uridir(import.meta)


fp = join(ROOT, 'test.md')

await TranMd(
  read(fp)
) 'en','zh',join ROOT,'.cache'
