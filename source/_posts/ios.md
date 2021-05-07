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
bilibili学习地址：https://www.bilibili.com/video/BV1Tt411a7Xa?p=6

## log
NSLog(@"Text %@", object);
NSLog(@"I want to log: %@", myString);
 
int i = 1234;
NSLog(@"The number is: %d", i);

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

# 型号尺寸
iphone 12 mini   宽：376，高：812
iphone 12        宽：390，高：844


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