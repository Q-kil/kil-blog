---
title: ios
date: 2020-12-16 14:17:02
categorice:
- ios
tags:
- ios
- OC
---

# basis
apple download all: https://developer.apple.com/download/all/
bilibili学习地址：https://www.bilibili.com/video/BV1Tt411a7Xa?p=6

## log
NSLog(@"Text %@", object);
NSLog(@"I want to log: %@", myString);
 
int i = 1234;
NSLog(@"The number is: %d", i);

## NS前缀
NextStep ---> Cocoa ---> Foundation框架之中

## @符号
1. 将C字符串转换为OC字符串
   "jack"   @"jack"
2. OC中的绝大部分的关键字都是以@符号开头

## 注释
单行注释：
   //
多行注释：
   /* */

## 函数定义调用
``` m
#import <Foundation/Foundation.h>

void test();

int main() {
    test();
}

void test() {
    NSLog(@"test");
}
```
## 快捷键
### 编译运行
Command + R 

### 模拟器
模拟器最小化
Command + M

### storyboard
撤销
Command + Z

## icon
### 1x2x3x
1x: 100 x 100
2x: 200 x 200
3x: 300 x 300

### create
https://www.canva.com/design/DAEQd2a45Rk/1V4999fQpblK7jG9pUyH5w/edit

### 批量生成不同尺寸图片
https://appicon.co/#app-icon


## 调试
### 无线网调试
设置：window > Devices and Simulators
勾选上：Connect via network

1.通过数据线将真机连接至Xcode
2.打开Xcode -> 顶部菜单栏 -> Window -> Devices and Simulators -> 选择你的机器 -> 勾选 Connect via network (如下)

### 支持最新14.6
Step 1
Download iOS 14.6 support files
https://github.com/JinjunHan/iOSDeviceSupport/raw/master/DeviceSupport/14.6.zip
Step 2
Extract the zip content
Step 3
Paste it at
/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/DeviceSupport
Step 4
Restart xcode.
## 模拟器
### 清理
Simulator > Device > Erase all content and setting
删除所有内容和设置

## 推送到TestFligth
皮卡堂 > Any iOS Device(arm64)
Product > Archive

# 型号尺寸
iphone 12 mini   宽：376，高：812
iphone 12        宽：390，高：844

## icon
iPad Pro	167px × 167px (83.5pt × 83.5pt @2x)
`{% asset_img icon.png %}`

# OC
Objective-C是C语言的严格超集
面向对象的C语言

## 扩展名
| 扩展名 | 内容类型  |
| :--- | :--- |
| .h | 头文件。头文件包含类，类型，函数和常数的声明。 |
| .m | 源代码文件。这是典型的源代码文件扩展名，可以包含 Objective-C 和 C 代码。 |
| .mm | 源代码文件。带有这种扩展名的源代码文件，除了可以包含Objective-C和C代码以外还可以包含C++代码。仅在你的Objective-C代码中确实需要使用C++类或者特性的时候才用这种扩展名。 |

## 创建OC文件
Xcode -> Create a new Xcode project -> OS X -> Command Line Tool
中国人的探索精神就是这样，没有
`{% asset_img explore.png %}`


## basis
1. OC相对于C
  a. 在C的基础上新增了一小部分面向对象的语法
  b. 将C的复杂的、繁琐的、可恶的语法封装的更为简单

2. OC程序的源文件的后缀名是.m m代表message 代表OC中最重要的一个机制   消息机制
   C程序的源文件的后缀名.C

3. main函数仍是OC程序的入口和出口
   int类型的返回值  代表程序的结束状态
   main函数的参数：仍然可以接收用户在运行程序的时候传递数据给程序
                 参数也可以不要

4. #import指令
   1）.以#号开头，是1个预处理指令
   2）.作用： 是#inlcude指令的增强版，讲文件的内容在预编译的时候拷贝写指令的地方
   3）.增强： 同1个文件无论#import多少次，只会包含1次
             如果#include指令要实现这个效果  就必须要配合条件编译指令来实现
             而#import指令只需要直接包含就可以  其他什么都不用做

``` m
#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool { 
        // insert code here...
        NSLog(@"Hello, World!");
    }
    return 0;
}
```

@autoreleasepool 自动释放池
NSLog 函数，来自 Foundation.h
   1). 作用：是printf函数的增强版，向控制台输出信息
   2). 语法：
         NSLog(@"格式控制字符串", 变量列表)；
      最简单的语法：
         NSLog(@"要输出的信息")；

### NSString
NSSting 类型的指针变量，专门用来存储OC字符串的地址

OC的字符串常量必须要使用1个前缀@符合
   "jack" C语言的字符串
   @"jack" OC字符串常量

NSString *str = @"jack"

NSLog(str);
如果要使用NSLog函数输出OC字符串的值，那么使用占位符%@
NSLog(@"大家好，我叫%@", str);

### NSNumber
NSArray、NSDictionary、NSSet 等集合对象只能保存对象，如果要保存 char、short、int、float、double、BOOL 或指向结构的指针等基础数据类型，则可以先将这些基本数据类型封装成 NSNumber 对象，再存入集合对象。
NSNumber 类用来包装基本数据类型。
NSValue 是 NSNumber 的父类。
不能直接用 NSNumber 对象做计算，只能提取值。

// 包装基本数据类型
NSNumber *intNumber = [NSNumber numberWithInteger:100];
NSNumber *floatNumber =[NSNumber numberWithFloat:24.58];
NSNumber *boolNumber = [NSNumber numberWithBool:YES];

# iOS 流程

## 最终目的
打包一个公司iOS app

## 技术栈
- Cordova
    打包工具

## 预测会出现的问题
- 证书安装

## cordova
npm install -g cordova
v10.0.0

### open
``` zsh
macs-Mac-mini:test-app mac$ open platforms/ios/HelloCordova.xcodeproj/
```
error:
Showing Recent Messages
Signing for "HelloCordova" requires a development team. Select a development team in the Signing & Capabilities editor.



## iOS
### 创建一个标识符
[Register a new identifier](https://developer.apple.com/account/resources/identifiers/add/bundleId)

#### 删除标识符
The App ID 'XXXXX' appears to be in use by the App Store, so it can not be removed at this time.
解决方案：
在App Strore Connect 找到与此App ID 相关的App，将套装ID修改成别的
然后再进行删除
注意：
如果曾经上传过这个bundle ID 的二进制文件到App Strore Connect，将无法删除

### 套装ID
假设在开发者网站已经创建了两个App ID ，一个是：
精确型
Explicit App ID  为 :  com.companyA.oneApp，
App ID Description Name  为：oneApp。

另外一个是：
通配型
Wildcard App ID  为： com.companyB.* 
App ID Description Name  为：twoApp。

### Capabilities部分

Capabilities部分是说明你的app需要具有哪些能力，需要哪些你就勾选哪些，具体说明如下（本人非ios开发者，很多只是字面翻译，具体请查询相关文档）：

Access WiFi Information：访问wifi信息 比如你要用到获取WiFi的SSID信息，需要开启该功能
App Groups：开启数据共享 比如公司多个app之间数据需要共享，可以开启这个功能
Apple Pay Payment Processing：Apple Pay支付处理，需要苹果支付的需要开启
Associated Domains：通用链接，通过唯一的网址，就可以链接到App中具体的视图，不需要特殊的schema。如果用户没有安装App则链接到对应的普通网页。
AutoFill Credential Provider：自动填充凭据提供程序
ClassKit：ClassKit框架
Custom Network Protocol(Supported only on:macOS)：自定义网络协议（仅mac系统上支持）
Data Protection：应用程序加密
Fonts：字体
Game Center：游戏中心
HealthKit：健康框架
HomeKit：家庭框架
Hotspot：app内自动连接热点
iCloud：iCloud 同步数据
In-App Purchase：应用内支付
Inter-App Audio：音频流发送
Low Latency HLS：低延迟
Mac(Supported only on:macOS)：
Multipath：扩展连接
Network Extensions：网络扩展（vpn&wifi）
NFC Tag Reading：近场通讯
Personal VPN：个人vpn
Push Notifications：消息推送
Sign In with Apple：苹果账号登录
SiriKit：siri框架
System Extension(Supported only on:macOS)：系统扩展（仅mac支持）
User Management(Supported only on:tvOS)：用户管理（仅tvOS支持）
Wallet：票据凭证
Wireless Accessory Configuration：无线附件配置

## Xcode
### 账号登录
Xcode -> xcode server -> account
`{% asset_img ios02.png %}`
### 调试
Automatically manage signing
自动配置证书,自动创建和更新证书

`{% asset_img ios00.png %}`
`{% asset_img ios01.png %}`

创建的证书名称是开发者的名字后面括号加上我电脑的名称。
https://developer.apple.com/account/resources/certificates/list

### Certificate
证书是用来给应用程序签名的，只有经过签名的应用程序才能保证他的来源是可信任的，并且代码是完整的，未经修改的。

相信大家入门程序员的时候，大多都是在 VC 或 VS 上打 C/C++ 入门的，那时候一切都很简单，code-build-link-run，并没有什么认证过程，而由于苹果对其生态圈管理严格，任何在 iOS 上跑的程序都需要经过苹果的“同意”。所以，不论是 AppStore，还是 Xcode 本地 build 的项目，苹果都需要验证这个应用的身份。


# 学习appleapi文档
https://developer.apple.com/documentation/webkit/wkwebviewconfiguration
干净清晰
https://developer.apple.com/documentation/technologies
一上来先列个目录
把api分类一下，每个大类下面有一句话描述用户可能要用这个类别api做的事情




# 问题
## 移动端ios使用new Date(“2021-02-03 00:00:00“)获取时间为NAN
使用ionic4+angular8框架开发app
在ios端使用如下代码获取时间毫秒数,控制台打印显示NAN

new Date("2021-02-03 00:00:00").getTime()
1
android端显示正常，获取结果为1612281600000
经网上查阅资料使用new Date()移动端兼容性如下图所示
`{% asset_img ios_date.png %}`

解决办法
根据上图采用第四种解决办法，将"-“替换为”/"

let time = "2021-02-03 00:00:00";
let formatTime = time.replace(/-/g, '/')
new Date(newTime).getTime()

移动端vConsole控制台成功输出毫秒数1612281600000
————————————————
版权声明：本文为CSDN博主「renjiantaotie」的原创文章，遵循CC 4.0 BY-SA版权协议，转载请附上原文出处链接及本声明。
原文链接：https://blog.csdn.net/renjiantaotie/article/details/113630560

## XCode Command Line Tools
使用 macOS 时，Apple 自家的 XCode Command Line Tools 基本上很难绕开。比如你想用 Homebrew 安装点什么东西，它都会依赖 XCode CLT。

比较不幸地是，如果你更新了 macOS，那你就得重新安装 XCode。如果你重新安装 XCode，那么匹配版本的 CLT 也得重新安装。更为不幸的是，最近使用 xcode-select --install 安装 CLT，经常失败。遂起了手动安装的念头。

摸索后步骤如下：

Apple 家官网：https://developer.apple.com/download/more/
以 Apple ID 登录
在搜索框搜索 Command Line Tools
打开你 macOS 上的 XCode，检查其版本号
下载对应版本的 Command Line Tools 镜像（*.dmg）
从镜像里手工安装

# In-App Purchase

## base
iOS支付框架：[StoreKit](https://developer.apple.com/cn/documentation/storekit/)
跨平台

## App 内购买项目类型
4种
pkt使用: 消耗型项目

### 提供app内购买项目
文档：https://developer.apple.com/cn/documentation/storekit/in-app_purchase/#topics
首先需要签署《付费应用程序协议》。您签署协议之后即可提交报税表。

### 创建app内购买项目
https://help.apple.com/app-store-connect/?lang=zh-cn#/devae49fb316

### 确定用户状态

## 测试



## issues
### App Store 服务器通知网址 (URL)
https://help.apple.com/app-store-connect/?lang=zh-cn#/dev0067a330b

