#!/usr/bin/env coffee

> @xxai/tran_md
  @w5/uridir
  @w5/read
  path > join

ROOT = uridir(import.meta)

read()

console.log await tran_md 123
