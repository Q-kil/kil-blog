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




