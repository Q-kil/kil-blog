---
title: Angular依赖包
date: 2019-10-21 12:16:16
categories:
- Angular
tags:
---

### 基础包
#### @angular-core
实现Angular的核心功能，低级服务和实用程序
- 为组件，视图层次结构，更改检测，渲染和事件处理定义基础结构。
- 定义为Angular构造提供元数据和上下文的装饰器。
- 为依赖项注入 (DI)，国际化 (i18n) 以及各种测试和调试工具定义基础结构。

常用模块
- NgModule： 模块定义装饰器
- Component： 组件定义装饰器
- Directive： 指令定义装饰器
- Pipe： 管道定义装饰器
- ElmentRef： 元素引用
- ViewChild： 获取子元素
- Render： 渲染
- Input： 接受参数传入
- Output： 事件输出
- EventEmitter： 出发自定义事件
- PipeTransform： 管道接口
- Injectable： 服务定义装饰器

#### @angular/common
实现基本的Angular指令和管道

模块
- CommonModule：通用模块，包含内置指令ngIf，ngFor

#### @angular/platform-browser
支持在不同的浏览器上执行Angular应用。
BrowserModule包含在通过CLI创建的任何应用程序中，并且它会重新导出CommonModule和ApplicationModule导出，从而使基本的Angular功能可用于该应用程序。

常用模块
- platformBrowser：AoT编译
- BrowserModule：浏览器支持，注意该模块导入了CommonModule，然后导出去，所以引用了这个模块也就引用了CommonModule

#### @angular/platform-browser-dynamic
angular应用的入口模块

模块
- platformBrowserDynamic：JIT编译

#### @angular/compiler
用于在运行时运行angular编译器以创建ComponentFactorys 的低级服务，以后可用于创建和呈现Component实例。