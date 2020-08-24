---
title: cordova
date: 2020-08-08 14:01:46
categories:
- Frame
tags:
- Cordova
---

# basic
``` bash
npm i -g cordova

updata
npm i -g cordova

cordova create MyApp

可以创建的平台
cordova platform

cordova run android
```

## add plugin
```
$ cordova plugin add <path to plugin folder>
```

## remove plugin
```
$ cordova plugin rm cordova-plugin-dispaly-cutout
```

## 环境设置
error
``` bash
$ cordova run android
Checking Java JDK and Android SDK versions
ANDROID_SDK_ROOT=undefined (recommended setting)
ANDROID_HOME=undefined (DEPRECATED)
Failed to find 'ANDROID_SDK_ROOT' environment variable. Try setting it manually.
Failed to find 'android' command in your 'PATH'. Try update your 'PATH' to include path to valid SDK directory.
```

# ios
## 刘海
``` css
padding-top: env(safe-area-inset-top);
padding-bottom: env(safe-area-inset-bottom);
```

## build
### 本机测试
问题：
 "iPhone Developer" in the build settings editor

解决：
Xcode > preference > Accounts signing 证书
project > Build Settings > Signin > Code Signing Identity > debug > iOS Developer

### build ipa包
问题：
xcode archive 一直是灰色的

解决：
把配置选择为device才能选build and archive的，模拟器的肯定不能build and archive

## UIWebView 审核失败
打开终端，cd到项目根目录。
执行以下命令，就能看到哪些文件内还在有UIWebview的踪迹。

 grep -r UIWebView .
