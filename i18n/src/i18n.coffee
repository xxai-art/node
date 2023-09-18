#!/usr/bin/env coffee

> ./index.js

try
  await index(
    process.env.WORKDIR \
    or \
    process.cwd()
  )
  code = 0
catch err
  console.trace err
  code = 1
process.exit(code)
