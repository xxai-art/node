[‼️]: ✏️README.mdt

# @xxai/tran_md

[test/main.coffee](./test/main.coffee) :

```coffee
#!/usr/bin/env coffee

> @xxai/tran_md
  @w5/uridir
  @w5/read
  path > join

ROOT = uridir(import.meta)

fp = join(ROOT, 'test.md')

console.log await TranMd(
  read(fp)
  'zh'
) 'en',join ROOT,'.cache'
```

output :

```
# Test

## Code Snippet

`CoffeeScript` code

```coffee
# Code comments
console.log 'good'

```

```rust
/* Code comments */

fn main(){
  dbg!("yes");
}
```

## Comment

<!-- 单行 HTML 注释 --> 

test

<!--
多行
HTML
注释
-->

## Quote

> Road to Road, very Avenue

## Link

[Markdown documentation](https://github.com/xxai-art/xxai-art-md)

## Picture

![xxAI.Art Brand Identity](https://raw.githubusercontent.com/xxai-art/web/main/file/svg/logo.svg)

## Indentation

Mr. Lu Xun wrote in "Self-titled Portrait":

  Lingtai has no plan to escape from the divine arrow
  Stormy and Dark Hometown
  The meaning of the cold star is not noticed
  I recommend Xuanyuan with my blood
```
