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