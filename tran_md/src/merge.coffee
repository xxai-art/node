#!/usr/bin/env coffee

###

# 使用 chatgpt gpt4 编码
https://chat.openai.com/chat/9ba1710a-0ecd-4af2-991a-2fa9edf7f359

请用 CoffeeScript 编写代码：

定义函数 merge(li)，其参数 li 是一个由文本行组成的数组。函数需将位于两个 ``` 符号之间的行合并为一个元素（使用 '\n' 连接），同时将位于 <-- 和 --> 符号之间的行以相同方式合并。同时，需将分隔符号也拼接到合并后的行中。

采用下划线风格命名变量。在处理多个 if 语句时，尽可能使用 switch 语句。若变量初始值为 false，请使用自创语法 + 变量名进行声明，并注意 + 和变量名之间需要有空格。若函数中未使用 this，应使用 => 而非 -> 来定义。

在每次循环开始时，去除行尾空格，使用 line = line.trimEnd()。在循环开始处，定义 trimStarted = line.trimStart() 以进行后续比较。当合并代码块或注释块时，使用 merged.push buffer + line 替代 buffer += line + '\n' 和 merged.push buffer.slice(0, -1)。

函数返回一个数组，包含合并后的数组以及未合并行的行号（变量名为 unmerged_line_numbers）。在判断未合并行时，添加一个条件：仅当行不以 < 开头且不以 > 结束，同时 trimStarted 非空，且不以 ![ 开头时，才将当前行号添加到 unmerged_line_numbers 数组中。

###

###
因为代码和html注释无需翻译，把代码和html注释合并为一行
定义 merge 函数，用于合并代码块和注释块
###

export default merge = (txt) =>
  li = txt.split('\n')
  # 初始化变量
  + is_code_block, is_comment_block
  merged = []
  buffer = ''
  unmerged_line_numbers = []

  # 遍历输入数组的每一行
  for line in li
    # 去掉行尾的空格
    line = line.trimEnd()
    trimStarted = line.trimStart()

    # 判断当前行是否为代码块或注释块的开始或结束，并更新状态
    if trimStarted.startsWith '```'
        if is_code_block
          merged.push buffer + line
          buffer = ''
        else
          buffer += line + '\n'
        is_code_block = !is_code_block
    else if trimStarted.startsWith '<!--'
      p = line.indexOf '-->',3
      if p > 0
        buffer += line.slice(0,p+4) + '\n'
        merged.push buffer
        buffer = ''
        is_comment_block = false
      else
        buffer += line + '\n'
        is_comment_block = true
    else
      if is_code_block or is_comment_block
        buffer += line
        if is_comment_block
          p = line.indexOf '-->'
          if ~p
            is_comment_block = false
            merged.push buffer
            buffer = ''
            continue
        buffer += '\n'
      else if not line.startsWith('[#]: ')
        if not trimStarted and not merged.length
          continue
        if not (
          line.startsWith('<') and line.endsWith('>')
        ) and trimStarted
          unmerged_line_numbers.push merged.length
        merged.push line

  # 返回合并后的数组及未合并行的行号数组
  return [merged, unmerged_line_numbers]

if process.argv[1] == decodeURI (new URL(import.meta.url)).pathname
  test_input = [
    'Line 1',
    '```',
    'Code block line 1',
    'Code block line 2',
    '```',
    '<img>'
    'Line 2',
    '<!--',
    'Comment line 1',
    'Comment line 2',
    '-->',
    'Line 3'
    '![xxAI.Art 品牌标识](https://raw.githubusercontent.com/xxai-art/web/main/file/svg/logo.svg)'
    'Line 4'
  ]

  result = merge(test_input.join('\n'))

  console.log('合并后的数组：')
  console.log(result[0])
  console.log('未合并行的行号：')
  console.log(result[1])

