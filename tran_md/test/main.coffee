#!/usr/bin/env coffee

> @xxai/tran_md
  @w5/uridir
  @w5/read
  path > join

ROOT = uridir(import.meta)


fp = join(ROOT, 'test.md')

console.log await TranMd(
  read(fp)
) join ROOT,'.cache'
