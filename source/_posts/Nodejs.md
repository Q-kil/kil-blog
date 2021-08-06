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

# nvm
node 版本管理器
## install
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | bash


nvm   command not found
.zshrc 添加如下
```
source ~/.nvm/nvm.sh
```

## uninstall
$ nvm use system
$ npm uninstall -g a_module

## use
```zsh
$ nvm install 14.16.0
Downloading and installing node v14.16.0...
Downloading https://nodejs.org/dist/v14.16.0/node-v14.16.0-darwin-x64.tar.xz...
################################################################################################# 100.0%
Computing checksum with shasum -a 256
Checksums matched!
Now using node v14.16.0 (npm v6.14.11)
Creating default alias: default -> 14.16.0 (-> v14.16.0)
```

```zsh
$ nvm use v14.16.0
Now using node v14.16.0 (npm v6.14.11)
```

## 查看安装的版本
``` zsh
$ nvm ls
->     v12.22.1
       v14.16.0
         system
default -> 14.16.0 (-> v14.16.0)
iojs -> N/A (default)
unstable -> N/A (default)
node -> stable (-> v14.16.0) (default)
stable -> 14.16 (-> v14.16.0) (default)
lts/* -> lts/fermium (-> N/A)
lts/argon -> v4.9.1 (-> N/A)
lts/boron -> v6.17.1 (-> N/A)
lts/carbon -> v8.17.0 (-> N/A)
lts/dubnium -> v10.24.1 (-> N/A)
lts/erbium -> v12.22.1
lts/fermium -> v14.16.1 (-> N/A)
```

# npx
Node 自带 npm 模块，所以可以直接使用 npx 命令。万一不能用，就要手动安装一下。
$ npm install -g npx

## 调用项目安装的模块
npx 想要解决的主要问题，就是调用项目内部安装的模块。比如，项目内部安装了测试工具 Mocha。

$ npm install -D mocha
一般来说，调用 Mocha ，只能在项目脚本和 package.json 的scripts字段里面， 如果想在命令行下调用，必须像下面这样。

项目的根目录下执行
$ node-modules/.bin/mocha --version
npx 就是想解决这个问题，让项目内部安装的模块用起来更方便，只要像下面这样调用就行了。

$ npx mocha --version

## cordova项目
npx cordova-hcp build


# npm
npm —— nodejs package manager
cnpm —— 企业npm
yarn —— Facebook

## config
[config](https://docs.npmjs.com/cli/v6/commands/npm-config)
list
npm config list

set
npm config set key value

## install
npm install https://github.com/visionmedia/express throws error.

npm install express works.
---------
Because https://github.com/visionmedia/express is the URL of a web page and not an npm module. Use this flavor: git+{url}.git

git+https://github.com/visionmedia/express.git
or this flavor if you need SSH:

git+ssh://git@github.com/visionmedia/express.git

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

### class-transformer
普通对象是 `Object`类的实例对象。当使用 `{}`符号创建时，它们又被叫做 字面量 对象。类对象是具有自己定义的构造函数，属性和方法的类的实例。通常，您通过“类”表示法定义它们。
### archiver
压缩文件

### fs-extra
#### ensureFile 创建文件
确保文件存在。如果被请求的文件的目录不存在,创建这些目录。如果文件已经存在,它不修改。
异步:
createFile()
同步:
createFileSync(),ensureFileSync()


## npx
### 检查版本
查看本项目依赖版本
当前项目的路径去找：node_modules
``` zsh
$ npx webpack -v
webpack 5.11.1
webpack-cli 4.3.0
```

## npm link
把本地的模块link到一个我们的npm的标准的模块里面去
```
/usr/local/lib/node_modules/toolchain -> 
/home/kil/.npm-global/lib/node_modules/generator-toolchain -> /d/code/github/toolchain
```

## 将插件发布到npm
npm login
npm pulish


# 指令
npm 查看全局安装过的包
``` BASH
npm list --depth=0 --global
```
npm list	显示安装过的包
-g	指全局安装过的包
--depth 0	限制输出模块层级

``` BASH
$ npm list -g
/home/kil/.npm-global/lib
├─┬ node-sass@4.13.1
│ ├── async-foreach@0.1.3
```

# process
在node中，有全局变量process表示的是当前的node进程。process.env包含着关于系统环境的信息。但是process.env中并不存在NODE_ENV这个东西。NODE_ENV是用户一个自定义的变量，在webpack中它的用途是判断生产环境或开发环境的依据的。

为了查看 process的基本信息，我们可以进入到 node 的repl 环境中，然后执行 process.env 命令，查看相关信息

```
process.env {
  NVM_INC: '/Users/niekaifa/.nvm/versions/node/v14.16.0/include/node',
  npm_package_devDependencies_awesome_typescript_loader: '^5.2.1',
  npm_package_dependencies__angular_forms: '11.2.7',
  npm_package_dependencies__angular_router: '11.2.7',
  npm_package_devDependencies_source_map_loader: '^0.2.4',
  TERM_PROGRAM: 'vscode',
  npm_package_devDependencies_file_loader: '^2.0.0',
  NODE: '/Users/niekaifa/.nvm/versions/node/v14.16.0/bin/node',
  npm_config_version_git_tag: 'true',
  npm_package_dependencies_moment: '^2.23.0',
  npm_package_devDependencies_terser_webpack_plugin: '^1.2.3',
  npm_package_devDependencies_typescript: '~4.1.5',
  ANDROID_HOME: '/Users/niekaifa/Library/Android/sdk',
  NVM_CD_FLAGS: '-q',
```

## cross-env
它是运行跨平台设置和使用环境变量的脚本。

它的作用是啥？
当我们使用 NODE_ENV = production 来设置环境变量的时候，大多数windows命令会提示将会阻塞或者异常，或者，windows不支持NODE_ENV=development的这样的设置方式，会报错。因此 cross-env 出现了。我们就可以使用 cross-env命令，这样我们就不必担心平台设置或使用环境变量了。也就是说 cross-env 能够提供一个设置环境变量的scripts，这样我们就能够以unix方式设置环境变量，然而在windows上也能够兼容的。
要使用该命令的话，我们首先需要在我们的项目中进行安装该命令，安装方式如下：

npm install --save-dev cross-env

然后在package.json中的scripts命令如下如下：
``` json
"scripts": {
  "dev": "cross-env NODE_ENV=development webpack-dev-server --progress --colors --devtool cheap-module-eval-source-map --hot --inline",
  "build": "cross-env NODE_ENV=production webpack --progress --colors --devtool cheap-module-source-map",
  "build:dll": "webpack --config webpack.dll.config.js"
}
```

# API
## fs 文件系统
### fs.existsSync(path)
path <string> | <Buffer> | <URL>
返回: <boolean>
如果路径存在，则返回 true，否则返回 false。

### stat
1.异步版：fs.stat(path,callback):
    path是一个表示路径的字符串,callback接收两个参数(err,stats),其中stats就是fs.stats的一个实例；
  
2.同步版：fs.statSync(path)
   只接收一个path变量，fs.statSync(path)其实是一个fs.stats的一个实例；

3.再来看fs.stats有以下方法:
    stats.isFile()
    stats.isDirectory()
    stats.isBlockDevice()
    stats.isCharacterDevice()
    stats.isSymbolicLink() (only valid with fs.lstat())
    stats.isFIFO()
    stats.isSocket()


## path
path.resolve
方法会把一个路径或路径片段的序列解析为一个绝对路径。


### posix
path.posix 返回POSIX(Mac/Linux)系统的path执行
返回的对象总会按照POSIX(Mac/Linux)的方式处理路径。

## os操作系统
### os.homedir()
返回当前用户的主目录的字符串路径。

## request
``` js
var res = request('GET', `https://osd-alpha.tooqing.com/app/batchupdate/v${cordovaHcp.previous_batch_update_version}/chcp.manifest`);
console.log('previous', JSON.parse(res.getBody()));
```

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

## 本地和线上依赖版本统一
package-lock.json

# 最简单的服务器
``` js
const http = require('http');

http.createServer(function(req, res) {
  console.log('req', req);
  res.end('Hello world');
}).listen(8082);
```

