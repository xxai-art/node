#!/usr/bin/env coffee

# todo 没有对字符串的引号和转义进行处理

单行注释 = 1
多行注释 = 2

pythonComment = (txt)=>
  out = []
  comment_pos = []
  for i,pos in txt.split '\n'
    it = i.trimStart()
    if it.startsWith '#'
      t = ''.padEnd(i.length - it.length)+'#'
      i = i.slice(1)
      it = i.trimStart()
      out.push t+''.padEnd(i.length - it.length)
      i = it.trimEnd()
      comment_pos.push out.length
      out.push i
      out.push '\n'
    else
      out.push i+'\n'
  [
    out
    comment_pos
  ]

cStyleComment = (txt)=>
  out = []
  buffer = ''
  comment_pos = []
  + state

  p = 0
  {length:txtlen} = txt

  push = =>
    out.push buffer
    buffer = ''
    return

  push_code = =>
    comment_pos.push out.length
    t = buffer.trimEnd()
    suffix = buffer.slice(t.length)
    buffer = buffer.slice(0,t.length)
    push()
    state = 0
    buffer = suffix
    return

  while p < txtlen
    i = txt[p++]
    if state == 多行注释
      if i == '*' and txt[p] == '/'
        ++p
        push_code()
        buffer+='*/'
      else
        buffer += i
    else if state == 单行注释
      buffer += i
      if txt[p] == '\n'
        push_code()
    else
      if i == '/'
        switch txt[p]
          when '/'
            ++p
            state = 单行注释
            buffer += '//'
            while txt[p].trim() == ''
              buffer += txt[p++]
            push()
            continue
          when '*'
            ++p
            buffer += '/*'
            while txt[p].trim() == ''
              buffer += txt[p++]
            push()
            state = 多行注释
            continue
      buffer += i

  if state
    push_code()
  else
    push()

  [
    out
    comment_pos
  ]


export default {
  rust:cStyleComment
  c: cStyleComment
  cpp: cStyleComment
  java: cStyleComment
  js: cStyleComment
  coffee: pythonComment
  py: pythonComment
  python: pythonComment
  bash: pythonComment
}

