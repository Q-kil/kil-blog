---
title: android
date: 2021-02-05 14:29:06
tags:
---

# basic
## create
如果您的应用需要旧版库支持，请选中 Use legacy android.support libraries 复选框。

## log


## @SuppressWarnings
可以标注在类、字段、方法、参数、构造方法，以及局部变量上。

作用：告诉编译器忽略指定的警告，不用在编译完成后出现警告信息。
使用：
  @SuppressWarnings(“”)
  @SuppressWarnings({})
  @SuppressWarnings(value={})

## final
用final修饰的变量是不可变的

## 网络调试
工具：Charles
- Let your phone and PC or MAC in a same LAN
- Launch Charles which you installed (default proxy port is 8888)
- Setup your phone's wifi configuration: set the ip of delegate to your PC or MAC's ip, port of delegate to 8888
- Lauch your app in your phone. And monitor http requests on Charles.- 