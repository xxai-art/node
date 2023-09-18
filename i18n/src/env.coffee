#!/usr/bin/env coffee

> path > join
  os > homedir

export CACHE_DIR = process.env.CACHE_DIR or join(
  homedir()
  '.cache/xxai/i18n'
)
