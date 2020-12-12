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

# npm
npm —— nodejs package manager
cnpm —— 企业npm
yarn —— Facebook

## 包
### rimraf
The UNIX command rm -rf for node.

### npm-run-all
A CLI tool to run multiple npm-scripts in parallel or sequential.

Both run-s and run-p are shorthand commands. run-s is for sequential, run-p is for parallel. We can make simple plans with those commands.

### wait-on
wait-on is a cross-platform command line utility which will wait for files, ports, sockets, and http(s) resources to become available (or not available using reverse mode)

```
wait-on file1 && NEXT_CMD # wait for file1, then exec NEXT_CMD 
wait-on f1 f2 && NEXT_CMD # wait for both f1 and f2, the exec NEXT_CMD 
wait-on http://localhost:8000/foo && NEXT_CMD # wait for http 2XX HEAD 
wait-on https://myserver/foo && NEXT_CMD # wait for https 2XX HEAD 
wait-on http-get://localhost:8000/foo && NEXT_CMD # wait for http 2XX GET 
wait-on https-get://myserver/foo && NEXT_CMD # wait for https 2XX GET 
wait-on tcp:4000 && NEXT_CMD # wait for service to listen on a TCP port 
wait-on socket:/path/mysock # wait for service to listen on domain socket 
wait-on http://unix:/var/SOCKPATH:/a/foo # wait for http HEAD on domain socket 
wait-on http-get://unix:/var/SOCKPATH:/a/foo # wait for http GET on domain socket
```

``` json
"electron:serve": "wait-on http-get://localhost:4200/ && npm run electron:serve-tsc && electron . --serve",
```

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

# API
## fs 文件系统
### fs.existsSync(path)
path <string> | <Buffer> | <URL>
返回: <boolean>
如果路径存在，则返回 true，否则返回 false。

## path
path.resolve
方法会把一个路径或路径片段的序列解析为一个绝对路径。


### posix
path.posix 返回POSIX(Mac/Linux)系统的path执行
返回的对象总会按照POSIX(Mac/Linux)的方式处理路径。

## os操作系统
### os.homedir()
返回当前用户的主目录的字符串路径。



# 升级
## 使用npm安装全局n模块
npm install -g n

## 使用n模块升级node
### 升级到稳定版
sudo n stable

安装成功 node -v

### 最新版
n latest


## 更新全局安装包
npm update -g jshint

设置环境变量
To reset the command location hash either start a new shell, or execute PATH="$PATH"
PATH="$PATH"
root@VM-0-4-ubuntu:~# node --version
v15.3.0

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
## script
npm 允许在package.json文件里面，使用scripts字段定义脚本命令。

### 传参
--

### 执行顺序
如果是并行执行（即同时的平行执行），可以使用&符号。
$ npm run script1.js & npm run script2.js
如果是继发执行（即只有前一个任务成功，才执行下一个任务），可以使用&&符号。
$ npm run script1.js && npm run script2.js

### 钩子
npm 脚本有pre和post两个钩子。举例来说，build脚本命令的钩子就是prebuild和postbuild。

"prebuild": "echo I run before the build script",
"build": "cross-env NODE_ENV=production webpack",
"postbuild": "echo I run after the build script"

用户执行npm run build的时候，会自动按照下面的顺序执行。
npm run prebuild && npm run build && npm run postbuild

### 简写形式
四个常用的 npm 脚本有简写形式。

npm start是npm run start
npm stop是npm run stop的简写
npm test是npm run test的简写
npm restart是npm run stop && npm run restart && npm run start的简写



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

## debug
{
  "version": "0.2.0",
  "configurations": [
      {
          "type": "node",
          "request": "launch",
          "name": "Launch Program",
          "program": "${workspaceFolder}/state.js"
      }
  ]
}

# 最简单的服务器
``` js
const http = require('http');

http.createServer(function(req, res) {
  console.log('req', req);
  res.end('Hello world');
}).listen(8082);
```

