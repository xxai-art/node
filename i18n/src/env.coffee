#!/usr/bin/env coffee

export CACHE_DIR = process.env.CACHE_DIR or join(
  homedir()
  '.cache/xxai/i18n'
)
