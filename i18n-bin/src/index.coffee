#!/usr/bin/env coffee

export default (pwd, file_li, to_from)=>
  console.log to_from
  console.log file_li
  console.log pwd
  return

if process.argv[1] == decodeURI (new URL(import.meta.url)).pathname
  await main()
  process.exit()

