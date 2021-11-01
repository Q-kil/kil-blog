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

# studio
## 搜索
Ctrl+Shift+F

# aab
Android App Bundle是Google在2018年推出的Apk动态组件化打包技术，通过AAB格式的App Bundle文件为你的设备动态组装apk来安装。其本质就是把Apk拆分成了多个模块，之前是把一个大而全的apk装到你手机里面，但是你其实用不到这么多东西，把暂时不需要的东西拿出来，这样就会节省很多的资源空间。除了效率和模块化之外，Android App Bundle现在还通过为新安装推出应用程序签名密钥升级提供更高的安全性。
注意：Android App Bundle (AAB) 与 APK 不同，AAB纯粹是为了上传Google Play而设计的，用户无法直接使用安装到手机上，测试AAB文件参考章节手机安装使用AAB格式文件

2021年8月开始Google Play要求新发布应用必须使用Android App Bundle（AAB）格式，即.aab格式文件；更新已经上架的应用还可以继续使用apk格式文件上传

详情参考Google官方博客说明：New Android App Bundle and target API level requirements in 2021

注：Google Play同时要求应用适配Android11，即 targetSdkVersion要求大于等于30。从2021年8月开始发布新应用必须设置targetSdkVersion大于等于30；从2021年11月开始更新已经上架的应用必须设置targetSdkVersion大于等于30。
HBuilderX3.1.0+版本已适配支持Android11，参考https://ask.dcloud.net.cn/article/193设置targetSdkVersion

