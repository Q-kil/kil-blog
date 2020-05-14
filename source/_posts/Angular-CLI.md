---
title: Angular-CLI
date: 2019-10-21 21:33:49
categories:
- Angular
tags:
- Angular-CLI
---

# 把所有零散的Node工具都集成起来
## cli 背景
在很早的时候，前端是没有好的工具，开发，测试，打包，部署，压缩
2009年，出现nodejs，前端Big Bang；以前都是刀耕火种


## 集成工具
- webpack
- typeScript编译器
单元测试
- karma
- jasmine
- Protractor 自动测试所有路由
- material.angular.io ui

最后集成一个angular.json

# 指令
``` zsh
ng version
```

``` BASH
$ ng g c app
CREATE src/app/app/app.component.ts (257 bytes)
已有app文件，使用此指令依然创建app文件

正确方法：
ng g c app --flat
CREATE src/app/app.component.ts (257 bytes)
默认不创建文件夹，在已有app文件下
```

### 本地版本升级 6 -> 7
``` BASH
$ npm uninstall -g @angular/cli
$ npm install -g @angular/cli@7.x.x
$ ng -v
```
