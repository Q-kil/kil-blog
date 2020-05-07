---
title: Error
date: 2020-04-10 19:03:42
categories:
- Error
tags:
- Error
---


# Error
`{% asset_img get_parame.png %}`

原因：方法上面没有属性 getUserToken().parame


# webpack
## sass-loader
Module build failed: TypeError: this.getResolve is not a function
sass-loader的版本过高导致的编译错误，当前最高版本是8.x，需要退回到7.3.1