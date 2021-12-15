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

yarn add ssh://git@code.apowo.com:opensource/cordova-hot-code-push-cli.git

升级依赖包
yarn upgrade [package]
yarn upgrade [package]@[version]
yarn upgrade [package]@[tag]

yarn upgrade webpack@^5.37.1 --dev

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
$ yarn config get registry https://registry.yarnpkg.com
```

换源
``` zsh
$ yarn config set registry 'https://registry.npm.taobao.org'
yarn config v1.22.4
success Set "registry" to "https://registry.npm.taobao.org".
✨  Done in 0.03s.
```

# link
# niekaifa @ Mac-mini in ~/workspace/apowo/game-core on git:dev x [11:31:10] 
$ yarn link

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

## 解除link后
yarn install --force

# 版本
版本好自动 + 1
yarn version --major
yarn version --minor
yarn version --patch

https://classic.yarnpkg.com/en/docs/cli/version/

# 缓存
$ yarn cache dir
/Users/niekaifa/Library/Caches/Yarn/v6

# error
## Couldn't find match for in "refs/heads/Talkie,refs/heads/audit
Couldn't find match for "2811863d46248ffea1013be2ba97884a0da46fd0" in "refs/heads/Talkie,refs/heads/audit,

解决办法:
yarn cache clean

