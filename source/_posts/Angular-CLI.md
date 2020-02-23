---
title: Angular-CLI
date: 2019-10-21 21:33:49
categories:
- Angular
tags:
- Angular-CLI
---

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
