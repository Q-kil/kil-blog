---
title: HHKB
date: 2020-03-23 14:29:28
categories:
- Tool
tags:
- HHKB
---

# 中英文切换
背景：每次Control + space 实在是太繁琐，中英文每天要用100多次。如果不想办法的话，估计一辈子用的次数会绕地球两圈。

现在切换按键：shift

方法：
1、安装 Karabiner-Elements
https://karabiner-elements.pqrs.org/index.html

2、找到文件编辑
`.config/karabiner/karabiner.json` 
配置文件进行编辑，如果没有此文件，请随意在软件软件界面建立一条规则再删除即可。
添加配置：
``` json
"rules": [
    {
        "description": "Change caps to left_shift. (Post leftshift if alone)",
        "manipulators": [
            {
                "from": {
                    "key_code": "left_shift",
                    "modifiers": {
                        "optional": [
                            "any"
                        ]
                    }
                },
                "to": [
                    {
                        "key_code": "left_shift"
                    }
                ],
                "to_if_alone": [
                    {
                        "key_code": "caps_lock"
                    }
                ],
                "type": "basic"
            }
        ]
    }
]
```
设置完成，保存文件即可立即生效，此时短按左shift键，应该可以切换中/英文功能了。
[原文](https://kknews.cc/digital/o2nb86o.html)
