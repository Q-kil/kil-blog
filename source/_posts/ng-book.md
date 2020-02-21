---
title: ng-book
date: 2020-02-21 23:58:50
categories:
- Angular
tags:
- Angular
---

**ng-book2-angular8**

## 前言
### 第一个应用
npm 版本大于等于 6.9.0
``` BASH
$ npm -v
```

typescript 版本大于等于 2.1
``` BASH
$ tsc --version
```

@angular/cli 版本
``` BASH
$ ng --version
```

### 文件目录结构
``` BASH
$ tree
```
├─categories
├─img
│  ├─avatar
│  ├─js
│  └─tool
├─kil
├─tags
├─_data
└─_posts

### 注意
Angular背后的一个重要概念是组件的概念。


## Angular 解读
### 文件
|-- README.md    // a useful README
|-- angular.json     // angular-cli configuration file
|-- e2e/     // end-to-end tests
|-- node_modules/   // installed dependencies
|-- package-lock.json    // npm dependencies lockfile
|-- package.json    // npm configuration
|-- src/     // our application's code
|-- tsconfig.json   // typescript config
|-- tslint.json    // linting config

### 代码
``` HTML
<app-root></app-root>
```
app 根标记
此标签由angular 定义；我们也可以自己定义标签

``` JS
import { Component, OnInit } from '@angular/core';
```
*.component.ts 文件下
解构赋值

``` JS
@Component({
  selector: 'app-hello-world',
  templateUrl: './hello-world.component.html',
  styleUrls: ['./hello-world.component.scss']
})
```
装饰器

``` JS
constructor() {
  this.name = 'Felipe'
}
```
构造函数
<span class="custom_red">constructor</span>应该是ES6中明确使用<span class="custom_red">constructor</span>来表示构造函数的，构造函数使用在<span class="custom_red">class</span>中，用来做初始化操作。当包含<span class="custom_red">constructor</span>的类被实例化时，构造函数将被调用。
可以看出，<span class="custom_red">constructor</span>的执行是在先的。
那么既然ngOnchanges是输入属性值变化的时候调用，并且ngOnInit是在ngOnchanges执行完之后才调用，而<span class="custom_red">constructor</span>是在组件就实例化的时候就已经调用了，这也就是说，在<span class="custom_red">constructor</span>中我们是取不到输入属性的值的。
[ngOnInit 和 constructor 使用场景](https://www.jianshu.com/p/af1d8f597b29)

``` JS
@NgModule({
    declarations: [
        // 声明模块里有什么东西 只能声明：组件/指令/管道
        AppComponent,
        HeroesComponent
    ],
    // 声明该模块所依赖的模块
    imports: [
        BrowserModule,
        AppRoutingModule
    ],
    // 默认情况下是空的
    providers: [],
    // 声明模块的主组件是什么
    bootstrap: [AppComponent]
})
export class AppModule { }
```
**declarations**
declarations specifies the components that are defined in this module. This is an
important idea in Angular:
You have to declare components in a NgModule before you can use them in your
templates.
You can think of an NgModule a bit like a “package” and declarations states what
components are “owned by” this module.
You may have noticed that when we used ng generate, the tool automatically added
our components to this declarations list! The idea is that when we generated a new
component, the ng tool assumed we wanted it to belong to the current NgModule.

**imports**
imports describes which dependencies this module has. We’re creating a browser
app, so we want to import the BrowserModule.
If your module depends on other modules, you list them here.


**providers**
providers is used for dependency injection. So to make a service available to be
injected throughout our application, we will add it here.

**bootstrap**
bootstrap tells Angular that when this module is used to bootstrap an app, we need
to load the AppComponent component as the top-level component.

``` JS
{{ name }}
```
模板标记

``` JS
@Input() name: string;
```
从父模板传入一个值

### 如何定义一个新组件
1、组件装饰器 A Component decorator
2、组件定义类 A component definition class

**两种方法定义模板**
``` JS
@Component({
  selector: 'app-hello-world',
  // templateUrl: './hello-world.component.html',
  template: `<p> 
              hello-world works inline!
             </p>`,
  styleUrls: ['./hello-world.component.scss']
})
```

**如何找到组件**
ng will look at the file angular.json to find the entry point to our app. Let’s trace
how ng finds the components we just built.
At a high level, it looks like this:
• angular.json specifies a "main" file, which in this case is main.ts
• main.ts is the entry-point for our app and it bootstraps our application
• The bootstrap process boots an Angular module – we haven’t talked about
modules yet, but we will in a minute
• We use the AppModule to bootstrap the app. AppModule is specified in src/ap
p/app.module.ts
• AppModule specifies which component to use as the top-level component. In this
case it is AppComponent
• AppComponent has `<app-user-list>` tags in the template and this renders our
list of users.











