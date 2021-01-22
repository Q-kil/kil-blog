---
title: yarn
date: 2020-07-09 16:41:21
categories:
- Tool
tags:
- Yarn
---

# basic
一、安装
brew install yarn

升级 
brew upgrade yarn

查看版本
yarn --version


二、使用
初始化新项目
yarn init

添加依赖包
yarn add [package]
yarn add [package]@[version]
yarn add [package]@[tag]

yarn add [package] --dev

升级依赖包
yarn upgrade [package]
yarn upgrade [package]@[version]
yarn upgrade [package]@[tag]

移除依赖包
yarn remove [package]

安装项目依赖
yarn

cofig
yarn config list

## 代理
yarn config set proxy http://XX
yarn config set https-proxy http://XX


# 源
查看
``` zsh
$ yarn config get registry
https://registry.yarnpkg.com
```

换源
``` zsh
$ yarn config set registry 'https://registry.npm.taobao.org'
yarn config v1.22.4
success Set "registry" to "https://registry.npm.taobao.org".
✨  Done in 0.03s.
```

# link
改变依赖路径
yarn link game-capsule

link suc：
node_modules game-capsule 出现 ↵ 字符

查看link 文件
``` zsh
$ ls -l node_modules | grep ^l
lrwxr-xr-x    1 niekaifa  staff     42  8  3 16:41 game-capsule -> ../../../../.config/yarn/link/game-capsule
```

## module to local
``` zsh
link
```

## 取消link
``` zsh
yarn unlink game-core
```

## 查看link
``` zsh
ls -l node_modules | grep ^l
```

# 版本
版本好自动 + 1
yarn version --major
yarn version --minor
yarn version --patch

https://classic.yarnpkg.com/en/docs/cli/version/

