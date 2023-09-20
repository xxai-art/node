[‼️]: ✏️README.mdt

# @xxai/i18n

* 可以设置代理

```
export https_proxy=http://127.0.0.1:7890
```

* 可以翻译代码注释

* 修改译文，重翻译，如果原文不变，不会影响修改（需要重新运行更新缓存，修改的译文不能增加换行）

[test/main.coffee](./test/main.coffee) :

* 支持嵌入变量 `<br 0>` 替换为 `$0`

```coffee
#!/usr/bin/env coffee

> @xxai/i18n
#   @w5/uridir
#   path > join

# ROOT = uridir(import.meta)
```

output :

```
./out.txt
```
