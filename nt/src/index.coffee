


< (txt)=>
  txt = txt.replaceAll('\r\n','\n').replaceAll('\r','\n')
  pre_indent = -1
  tree = [[-1],[]]
  now = tree
  stack = [now]
  for i from txt.split '\n'
    {length} = i
    i = i.trimStart()
    if (not i) or i.startsWith('#')
      continue
    indent = length - i.length
    i = i.trimEnd()
    if indent > pre_indent
      pre_indent = indent
      now[1].push now = [[indent,i],[]]
      stack.push now
    else if indent < pre_indent
      loop
        stack.pop()
        t = stack.at(-1)
        if t[0][0] < indent
          now = t
          break
      now[1].push now = [[indent,i],[]]
      stack.push now
      pre_indent = indent
    else
      stack.pop()
      now =  [[indent,i],[]]
      stack.at(-1)[1].push now
      stack.push now
  tree[1]
