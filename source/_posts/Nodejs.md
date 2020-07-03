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