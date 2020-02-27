---
title: Git
date: 2020-02-23 19:07:58
categories:
- Git
tags:
- Git
---

## 配置
### 全局配置
用户名
``` BASH
$ git config --global user.name "name"
```

邮箱
``` BASH
$ git config --global user.email "email@gmail.com"
```

### 代理
``` BASH
#只对github.com
git config --global http.https://github.com.proxy socks5://127.0.0.1:1080

#取消代理
git config --global --unset http.https://github.com.proxy)
```

## 指令
git配置
git config --list