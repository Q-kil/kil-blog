---
title: Nodejs
date: 2020-02-23 18:58:37
categories:
- Nodejs
tags:
- Nodejs
---

# 指令
npm 查看安装了哪些包
``` BASH
npm list --depth=0
```

``` BASH
$ npm list -g
/home/kil/.npm-global/lib
├─┬ node-sass@4.13.1
│ ├── async-foreach@0.1.3
```

# 升级
## 使用npm安装n模块
npm install -g n

## 使用n模块升级node
升级到稳定版
sudo n stable

安装成功 node -v