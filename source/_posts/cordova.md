---
title: cordova
date: 2020-08-08 14:01:46
categories:
- Hybrid
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

.zshrc
``` zsh
export ANDROID_SDK_ROOT="/Applications/Android Studio.app/android-sdk-macosx"
export PATH=${PATH}:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools
``

# android
``` zsh
$ cordova run android
Current working directory is not a Cordova-based project.

mkdir www
```

## run
手机插上电脑usb，执行：cordova run android

## 问题
```
Could not resolve all files for configuration ':app:debugRuntimeClasspath'
> Could not get resource 'https://dl.google.com/dl/android/maven2/com/android/support/support-v4/maven-metadata.xml'.
    > Could not GET 'https://dl.google.com/dl/android/maven2/com/android/support/support-v4/maven-metadata.xml'.
        > Connect to 127.0.0.1:1086 [/127.0.0.1] failed: Connection refused (Connection refused)
```
思路：
curl https://dl.google.com/dl/android/maven2/com/android/support/support-v4/maven-metadata.xml
没有问题

把zsh，git，
# niekaifa @ niekaifadeMacBook-Pro in ~/.gradle [20:36:42]
$ vim gradle.properties
代理 ，关闭。就可以了


# plugin
## add plugin
```
$ cordova plugin add <path to plugin folder>
```

## remove plugin
```
$ cordova plugin rm cordova-plugin-dispaly-cutout
```

## 键盘高度





# ios

## run
vue dist : serve


## 刘海
简单操作
``` css
padding-top: env(safe-area-inset-top);
padding-bottom: env(safe-area-inset-bottom);
```

## 隐藏状态栏
Hiding at startup
During runtime you can use the StatusBar.hide function below, but if you want the StatusBar to be hidden at app startup on iOS, you must modify your app's Info.plist file.

Add/edit these two attributes if not present. Set "Status bar is initially hidden" to "YES" and set "View controller-based status bar appearance" to "NO". If you edit it manually without Xcode, the keys and values are:

<key>UIStatusBarHidden</key>
<true/>
<key>UIViewControllerBasedStatusBarAppearance</key>
<false/>

## 纵屏，不允许翻转
在config.xml中有这么一条

<preference name="Orientation" value="portrait" />

Orientation有三个值可取，分别是 default、portrait、landscape

default:意思是app可以在四个方向随意旋转。
portrait：纵向
landscape：横向

## 全屏
``` xml
<platform name="ios">
    <allow-intent href="itms:*"/>
    <allow-intent href="itms-apps:*"/>
    <preference name="AutoHideSplashScreen" value="true"/>
    <edit-config file="*-Info.plist" mode="merge" target="UIStatusBarHidden">
      <true/>
    </edit-config>
    <edit-config file="*-Info.plist" mode="merge" target="UIViewControllerBasedStatusBarAppearance">
      <false/>
    </edit-config>
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

### use WKWebView


## cordova-plugin-wkwebview-engine 出错
/Users/niekaifa/ikyu/KilFront/cordova-app/platforms/ios/HelloCordova/Plugins/cordova-plugin-wkwebview-engine/CDVWKWebViewEngine.m:104:80: error: property 'userAgent' not found on object of type 'CDVViewController *'
        wkWebView.customUserAgent = ((CDVViewController*) self.viewController).userAgent;
                                                                               ^
/Users/niekaifa/ikyu/KilFront/cordova-app/platforms/ios/HelloCordova/Plugins/cordova-plugin-wkwebview-engine/CDVWKWebViewEngine.m:375:6: error: use of undeclared identifier 'CDVUserAgentUtil'
    [CDVUserAgentUtil releaseLock:vc.userAgentLockToken];
     ^
/Users/niekaifa/ikyu/KilFront/cordova-app/platforms/ios/HelloCordova/Plugins/cordova-plugin-wkwebview-engine/CDVWKWebViewEngine.m:388:6: error: use of undeclared identifier 'CDVUserAgentUtil'
    [CDVUserAgentUtil releaseLock:vc.userAgentLockToken];

删除 platforms/    plugins/ 文件

## 问题
### webView
build ios 搞了两周。seven 几分钟 跑起来
搞搞时间很快就没了
cordova 文档
``` zsh
11577* yarn upgrade cordova-ios@6.1.0
11578* cordova plugin rm cordova-plugin-ionic-webview
11579* cordova platform add ios
11580* cordova plugin rm cordova-plugin-statusbar
11581* cordova plugin add cordova-plugin-ionic-webview
11582* cordova build ios --verbose
verbose : 打印出详细内容
11583* cordova clean ios
11584* cordova build ios --verbose
build 分为两步：prepare + compile
11585* cordova prepare ios --verbose
11586* cordova compile ios --verbose
11587* cd tooqing-webapp
11588* git pull
11589* cd ..
11590* git submodule update --remote
11591* cd tooqing-webapp
11592* vue-cli-service build --mode cordova
11593* yarn
11594* yarn build:cordova
11595* cd ..
11596* cordova build ios --verbose
```

``` html
<preference name="WKWebViewOnly" value="true" />
```

### allow-navigation not set
Internal navigation rejected: <allow-navigation not set> in Cordova on iOS
解决办法：
<allow-navigation href="*" /> 

### doc.find
edit-config for ios usage descriptions: doc.find is not a function
解决办法：
cordova platform rm ios
cordova platform add ios
cordova prepare

