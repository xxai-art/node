#!/usr/bin/env coffee

export default dump = (li, indent=0)=>
  pad = ''.padEnd indent
  r = []
  if Array.isArray(li)
    for i from li
      r.push '\n'+pad+'- '+dump(i,indent+2)
  else if li.constructor == String
    if li.includes '\n'
      prefix = '\n'+pad+'> '
      return prefix+li.split('\n').join(prefix)
    else
      return li
  else
    for [k,v] from Object.entries(li)
      r.push '\n'+pad+k+':'+dump(v,indent+2)
  r.join('')
