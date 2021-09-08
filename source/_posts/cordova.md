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

## 清除PhoneGap缓存
在Xcode，cmd + shift + k中清理项目

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

## 支付
https://github.com/j3k0/cordova-plugin-purchase/blob/master/doc/api.md

## ios隐藏状态栏
https://github.com/katzer/cordova-plugin-hidden-statusbar-overlay/tree/aef5a90d2161dd9d363242523883757a51d0fad0#phonegap-build
cordova-plugin-hidden-statusbar-overlay

## 自定义插件开发
### 全局安装插件工具plugman
plugman是用于Apache Cordova项目的插件的安装和卸载等命令行工具。
``` zsh
$ npm install -g plugman
```

### 创建插件
定义一个最简单的Toast插件
#### 插件创建
``` 
plugman create --name [插件名] --plugin_id [插件id] --plugin_version [插件版本]
```

```zsh
$ cd plugins
# niekaifa @ niekaifadeMacBook-Pro in ~/ikyu/code/cordova-plugin/plugins [15:18:17] 
$ plugman create --name ToastDemo --plugin_id cordova-plugin-toastdemo --plugin_version 1.0.0
```

#### 插件配置
进入插件目录，添加插件支持的平台环境
``` zsh
$ cd ToastDemo
$ plugman platform add --platform_name android
$ plugman platform add --platform_name ios
```
添加之后将在ToastDemo目录下产生android和ios两个目录，此处只定义android环境的ToastDemo
生成的文件内容如图所示

修改plugin.xml
``` xml
<?xml version='1.0' encoding='utf-8'?>
<plugin id="cordova-plugin-toastdemo" version="1.0.0" xmlns="http://apache.org/cordova/ns/plugins/1.0" xmlns:android="http://schemas.android.com/apk/res/android">
  <name>ToastDemo</name>
  <!-- js调用模块；src为调用插件的js文件路径 -->
  <js-module name="ToastDemo" src="www/ToastDemo.js">
  <!-- target 为插件安装后的调用前缀，如：cordova.plugins.ToastDemo.[插件方法名] -->
  <!-- <clobbers target="cordova.plugins.ToastDemo" -->
  <!-- 可以自定义，调用时；ToastDemo.[插件方法名] -->
    <clobbers target="ToastDemo" /></js-module>

  <!-- android 环境配置项 -->
  <platform name="android">
    <!-- 插件配置，target为插件安装时，Cordova项目android环境配置文件的位置 -->
    <!-- 插件安装时会将config-file 标签中的内容添加到 res/xml/config.xml 文件中 -->
    <config-file parent="/*" target="res/xml/config.xml">
    <!-- name 为对应 www/Toast.js 文件中的调用名称 -->
      <feature name="ToastDemo">
      <!-- value 为插件安装到项目后 ToastDemo.java 文件路径，即包路径 -->
      <!-- 此处修改一下，将其改为通用Cordova插件的安装目录 -->
      <!-- <param name="android-package" value="cordova-plugin-toast.ToastDemo" /> -->
        <param name="android-package" value="org.apache.cordova.toastdemo.ToastDemo" />
      </feature>
    </config-file>
    <config-file parent="/*" target="AndroidManifest.xml"></config-file>
    <!-- src 为插件目录中java源文件路径，target-dir 为插件安装项目中后源文件路径 -->
    <!-- 此处将 target-dir 修改为与包路径一致 -->
    <!-- <source-file src="src/android/ToastDemo.java" target-dir="src/cordova-plugin-toastdemo/ToastDemo" /> -->
    <source-file src="src/android/ToastDemo.java" target-dir="src/org/apache/cordova/toastdemo" />
  </platform>
</plugin>
```

修改ToastDemo.js
``` js
var exec = require('cordova/exec');

// export.showToast 的 showToast 为插件安装后js调用的方法名，其中传递的参数可以为任意多个（arg0，arg1， arg2.., success, error)
exports.showToast = function (arg0, success, error) {
    // success error 为成功 失败回调
    // ToastDemo 为 plugin.xml 中配置的 feature 的name名
    // 参数中的'showToast'为给 ToastDemo.java 判断的 action 参数
    exec(success, error, 'ToastDemo', 'showToast', [arg0]);
};
```

修改ToastDemo.java 文件
``` java
package org.apache.cordova.toastdemo;

import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CallbackContext;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import android.widget.Toast;

/**
 * This class echoes a string called from JavaScript.
 */
public class ToastDemo extends CordovaPlugin {

    @Override
    public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
        if (action.equals("showToast")) {
            String message = args.getString(0);
            this.showToast(message, callbackContext);
            return true;
        }
        return false;
    }

    private void showToast(String message, CallbackContext callbackContext) {
        if (message != null && message.length() > 0) {
            Toast.makeText(cordova.getContext(), message, Toast.LENGTH_SHORT).show(); // 调用android原生Toast
            callbackContext.success(message); // 设置成功回调信息
        } else {
            callbackContext.error("Expected one non-empty string argument."); // 设置失败回调信息
        }
    }
}
```

#### 初始化插件
进入插件目录
``` zsh
# niekaifa @ niekaifadeMacBook-Pro in ~/ikyu/code/cordova-plugin/plugins/ToastDemo [15:19:21] 
$ npm init
```
提示的时候可以直接回车，使用默认值直到结束，将创建一个 package.json 文件

### 插件使用
安装插件
``` zsh
# niekaifa @ niekaifadeMacBook-Pro in ~/ikyu/code/cordova-plugin [15:56:03] 
$ cordova plugin add /Users/niekaifa/ikyu/code/cordova-plugin/plugins/ToastDemo
Installing "cordova-plugin-toastdemo" for android
Adding cordova-plugin-toastdemo to package.json
```

js调用插件
``` js
ToastDemo.showToast(“这是Toast内容”);
```

## ios plugin 防止左右滑
https://github.com/apache/cordova-plugin-wkwebview-engine

# android
## debug
### chrome not inspect
platforms > android > app > src > main > AndroidManifest.xml
<application android:debuggable="true" >

## 插件
### cordova-plugin-statusbar
状态栏不显示
<preference name="StatusBarOverlaysWebView" value="true"/>

## plugin打印log
java中添加
webView.loadUrl("javascript:console.log('log');");

LogDemo.java
``` java
/**
 * This class echoes a string called from JavaScript.
 */
public class LogDemo extends CordovaPlugin {

    @Override
    public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
        if (action.equals("printLog")) {
            String message = args.getString(0);
            this.printLog(message, callbackContext);
            return true;
        }
        return false;
    }

    private void printLog(String message, CallbackContext callbackContext) {
        if (message != null && message.length() > 0) {
            Log.v("Log","Log-v");
            String info = Integer.toString(999);
            float f = Float.parseFloat("25");
            String s = Float.toString(25.0f);
            Log.v("Log", info);
            Log.v("Log","Log-end");
            Log.v("Log", message);
            callbackContext.success(message);
        } else {
            callbackContext.error("Expected one non-empty string argument.");
        }
    }
}
```

```
V/Log: Log-v
    999
    Log-end
```

### index.html中调用
``` js
function onDeviceReady() {
    // Cordova is now initialized. Have fun!

    console.log('Running cordova-' + cordova.platformId + '@' + cordova.version);
    document.getElementById('deviceready').classList.add('ready');

    LogDemo.printLog("test");
}
```

```
V/Log: Log-v
    999
    Log-end
    test
```

## 问题
Could not find tools.jar. Please check that /Library/Internet Plug-Ins/JavaAppletPlugin.plugin/Contents/Home contains a valid JDK installation
``` zsh
$ /usr/libexec/java_home -V | grep jdk
Matching Java Virtual Machines (1):
1.8.0_272 (x86_64) "AdoptOpenJDK" - "AdoptOpenJDK 8" /Library/Java/JavaVirtualMachines/adoptopenjdk-8.jdk/Contents/Home
/Library/Java/JavaVirtualMachines/adoptopenjdk-8.jdk/Contents/Home

vim ~/.zshrc
109 export JAVA_HOME=/Library/Java/JavaVirtualMachines/adoptopenjdk-8.jdk/Contents/Home
110 export PATH=$JAVA_HOME/bin:$PATH

source ~/.zshrc
```

# ios
## 发版本
Product > Archive > Distribute App

## run
vue dist : serve

## 缓存
`{% asset_img cache.png%}`

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

### file://
XMLHttpRequest cannot load file://
Failed to load resource: The requested URL was not found on this server.  zh.json
解决办法：
https://github.com/AraHovakimyan/cordova-plugin-wkwebviewxhrfix

## ios支付
### 插件
https://github.com/j3k0/cordova-plugin-purchase

### 概述
该插件是基于事件的API。需要注册监听器的变化。
监听机制的核心是 `when()`


# 热更新
`{% asset_img cordova-hot-code-push.png%}`
``` js
function checkForUpdate() {
  chcp.fetchUpdate((error, data) => {
    if (error) {
      console.log('--fetchUpdate error--', error.code, error.description);
      return;
    };

    console.log('--fetchUpdate data--', data, data.config);
    console.log('Update is loaded stringify:' + JSON.stringify(data));

    chcp.isUpdateAvailableForInstallation(function(error, data) {
      console.log('isUpdate error', error);
      console.log('isUpdate data', data);

      if (error) {
        console.log('No update was loaded => nothing to install');
        console.log('error:', error);
      } else {
        window.alert(`正在更新至版本: ${data.readyToInstallVersion}`);

        // 对比版本号
        console.log('Current content version: ' + data.currentVersion);
        console.log('Ready to be installed:' + data.readyToInstallVersion);

        chcp.installUpdate((error) => {
          if (error) {
              // 更新失败
              console.log('Failed to install the update with error code: ' + error.code);
              console.log('install', error.description);
          } else {
              // 更新成功
              console.log('Update installed!!!');
          }
        });
      }

    });
  });
}
```

## cordova-hcp build
cordova-hcp build

## chcp_updateLoadFailed
在应用 config.xml 配置中可以定义了 native side 的版本号，例如

<chcp>
    <native-interface version="5" />
</chcp>
例如当前项目 native side 的版本号是5：

如果服务器上配置文件 chcp.json 中的 min_native_interface 值为 5，那么符合要求，热更新后的 web content 能够在正常运行
如果服务器上配置文件 chcp.json 中的 min_native_interface 值为 10，高于 config.xml 文件中 <native-interface />，那么热更新将无法正常进行。此时，插件会提示错误 chcp_updateLoadFailed，提示应用需要更新升级

## net::ERR_CLEARTEXT_NOT_PERMITTED
明文禁止
原因：
使用http://172.18.218.1:5000/www/chcp.json

解决：
``` xml
<widget id="you-app-id" version="1.2.3"
xmlns="http://www.w3.org/ns/widgets" 
xmlns:android="http://schemas.android.com/apk/res/android"
xmlns:cdv="http://cordova.apache.org/ns/1.0">

<platform name="android">
  <edit-config file="app/src/main/AndroidManifest.xml" mode="merge" target="/manifest/application">
      <application android:usesCleartextTraffic="true" />
  </edit-config>
</platform>
```

#### plugin cordova-hot-code-push
##### UpdateLoaderWorker.java
Worker, that implements update download logic.
Worker，它实现更新下载逻辑。
During the download process events are dispatched to notify the subscribers about the progress.
在下载过程中，将发送流程事件以通知订阅者进度。





class  PluginResultHelper
createPluginResult  app版本信息
D/CHCP: CHCP PluginResultHelper.createDataNode add text value: appVersion: "1.0.0"
D/CHCP: CHCP PluginResultHelper.createDataNode add text value: buildVersion: "10000"
    CHCP PluginResultHelper.createDataNode add text value: previousWebVersion: ""
    CHCP PluginResultHelper.createDataNode add text value: readyToInstallWebVersion: ""
    CHCP PluginResultHelper.createDataNode add text value: currentWebVersion: "2021.03.09-14.31.23"

CHCP PluginResultHelper.getResult resultObject: {"data":{"appVersion":"1.0.0","buildVersion":"10000","previousWebVersion":"","readyToInstallWebVersion":"","currentWebVersion":"2021.03.09-14.31.23"}}

##### chcp.fetchUpdate()
###### error -1
文档
FAILED_TO_DOWNLOAD_APPLICATION_CONFIG - failed to download new application config from the server. Either file doesn't exist or some internet connection problems. Error code value is -1.

源码
String configURL = chcpXmlConfig.getConfigUrl();
Log.d("CHCP", "get config url: " + configURL); // 空

###### error -3
FAILED_TO_DOWNLOAD_CONTENT_MANIFEST

###### error -16
当调用 chcp.installUpdate 时，安装已经在进行

###### error -18
API requests are ignored until assets are installed. Please, wait.

assets folder in not yet installed assets文件夹还没有安装

###### 待看
PluginResultHelper.getResult resultObject

chcp_assetsInstalledOnExternalStorage

###### 翻译
is update available for installation
是否可以安装更新

##### manifest
chcp.manifest 文件
file 内容改变，hash 才会变
