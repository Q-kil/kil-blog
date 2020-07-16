---
title: Nodejs
date: 2020-02-23 18:58:37
categories:
- Nodejs
tags:
- Nodejs
---

# what
JavaScript的服务器版本

优点：
- 便于前端人员上手
- 性能高 （基于chrome v8引擎开发，v8引擎会做预编译，比原生代码快）
- 利于和前端代码整合  （比如校验，前后用一套）

用途：
- 很少用于主力服务器开发语言
- 中间层语言 (大公司会用，为了安全)
  + 充分利用已有代码、增强主服务代码的独立性
  + 安全性
  + 性能
  + 丰富接口功能
- 工具开发  （webpack）

`{% asset_img middle.png %}`

## npm
npm —— nodejs package manager
cnpm —— 企业npm
yarn —— Facebook

# 指令
npm 查看安装了哪些包
``` BASH
npm list --depth=0 --global
```

``` BASH
$ npm list -g
/home/kil/.npm-global/lib
├─┬ node-sass@4.13.1
│ ├── async-foreach@0.1.3
```

# 升级
## 使用npm安装全局n模块
npm install -g n

## 使用n模块升级node
升级到稳定版
sudo n stable

安装成功 node -v

## 更新全局安装包
npm update -g jshint


# 模块系统
## 定义模块
### exports
```js
exports.a = 12;
exports.b = function() {
  return 5;
};
```
### module
```js
module.exports = function() {
  console.log('aaa');
}
module.exports = class {
  constructor(a, b) {
    this.a = a;
    this.b = b;
  }

  sum(){}
}
```

## 引入模块
require
``` js
const fs = require('fs');

fs.writeFile('a.txt', 'adsdfs', err => {
  if (err) {
    console.log('有错');
  } else {
    console.log('成功');
  }
})
```

### 两种方法
1、系统node_modules/本地node_modules/父目录node_modules
``` js
require('http');
```

2、自定义模块/具体地址
``` js
require('/xx/xx/http')
```

# koa
``` js
const Koa = require('koa');

let server = new Koa();
server.listen(8081);
console.log('server start');


server.use(async ctx => {
  console.log('query:', ctx.query);
  
  let {a, b} = ctx.query;

  ctx.set('Access-Control-Allow-Origin', '*');
  ctx.body=parseInt(a) + parseInt(b);
})
```

# npm
## electron
### 安装慢
```
$ npm install -g electron
/usr/local/bin/electron -> /usr/local/lib/node_modules/electron/cli.js

> core-js@3.6.5 postinstall /usr/local/lib/node_modules/electron/node_modules/core-js
> node -e "try{require('./postinstall')}catch(e){}"

Thank you for using core-js ( https://github.com/zloirock/core-js ) for polyfilling JavaScript standard library!

The project needs your help! Please consider supporting of core-js on Open Collective or Patreon:
> https://opencollective.com/core-js
> https://www.patreon.com/zloirock

Also, the author of core-js ( https://github.com/zloirock ) is looking for a good job -)


> electron@9.1.0 postinstall /usr/local/lib/node_modules/electron
> node install.js

Downloading electron-v9.1.0-darwin-x64.zip: [=----------------] 6% ETA: 42269.4 seconds ^C
```

### 解决办法
npm config set electron_mirror http://npm.taobao.org/mirrors/electron/

npm config set electron_custom_dir "8.1.1"

然后再全局安装 Electron：

npm install electron -g

### 快速成功
```
$ npm install electron -g
/usr/local/bin/electron -> /usr/local/lib/node_modules/electron/cli.js

> electron@9.1.0 postinstall /usr/local/lib/node_modules/electron
> node install.js

+ electron@9.1.0
updated 1 package in 27.249s
```


# 其他
要理解node-gyp首先要知道什么是gyp(https://gyp.gsrc.io/index.md)。gyp其实是一个用来生成项目文件的工具，一开始是设计给chromium项目使用的，后来大家发现比较好用就用到了其他地方。生成项目文件后就可以调用GCC, vsbuild, xcode等编译平台来编译。至于为什么要有node-gyp，是由于node程序中需要调用一些其他语言编写的工具甚至是dll，需要先编译一下，否则就会有跨平台的问题，例如在windows上运行的软件copy到mac上就不能用了，但是如果源码支持，编译一下，在mac上还是可以用的。



