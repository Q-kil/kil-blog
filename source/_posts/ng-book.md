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
    // 服务提供者，默认情况下是空的 
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
提供程序用于依赖项注入。所以让一项服务
在整个应用程序中注入，我们将在此处添加它。

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


## TypeScript
### TypeScript对ES5的五大改进
- type
- classes
- decorators
- imports
- language utilities (eg: destructuring)

TypeScript/ES6中还有许多其他特性
• Interfaces
• Generics
• Importing and Exporting Modules
• Decorators
• Destructuring

### type
类型检查好处
- 有助于编写代码，编译时防止错误
- 有助于阅读代码，澄清了作者的意图

#### 函数声明
在声明函数时，可以使用类型作为参数和返回值：
``` js
function greetText(name: string): string {
  return "Hello" + name;
}
```

#### 数组声明
数组是用数组类型声明的。但是，因为数组是一个集合，我们还需要指定数组中对象的类型。
- `array<type>`
- type[]
``` js
private jobs: Array<string> = ['IBM', 'Google'];
private jobss: string[] = ['Apple', 'Dell'];
```

#### 枚举类型
“枚举”的类型。在“枚举”类型的定义中列举出所有可能的取值，被说明为该“枚举”类型的变量取值不能超过定义的范围。应该说明的是，枚举类型是一种基本数据类型
枚举通过命名数值来工作
``` ts
enum Role {Employee, Manager = 3, Admin};
private role: Role = Role.Employee; // 枚举的默认初始值为0
private role2: Role = Role.Manager; // 3
```
enum Role {Employee = 3, Manager, Admin};
枚举的值从那里开始递增，这意味着Manager是4，Admin是5


#### Any
如果忽略给定变量的类型，则any是默认类型。变量为any允许它接收任何类型的值


#### Void
使用void意味着不需要类型。这通常在函数中没有返回值：


#### Classes
ES5 使用protype
ES6 new class
``` js
class Vehicle {
}
```
类可以有属性、方法和构造函数。
##### 属性
属性定义附加到类实例的数据。
例如，一个名为人可能有名字、姓氏和年龄等属性。
类中的每个属性都可以有一个类型。

##### 方法
方法是在对象上下文中运行的函数。
要对对象调用方法，我们首先要有一个对象的实例。
``` ts
var p: Person  = new Person();
p.first_name = 'Felipe';
p.greet();
```

##### 构造函数 constructor
构造函数是一种特殊的方法，当类的新实例正在创建。
通常，构造函数是执行新的对象。
构造函数方法必须命名为构造函数。
它们可以有选择地接受参数，但不能返回任何值，因为当类是正在实例化（即正在创建类的实例，没有其他值可以返回）。

实例化一个类:
``` ts
new ClassName()
```

在TypeScript中，每个类只能有一个构造函数。
这与ES6不同，ES6允许一个类有多个构造函数，只要它们有不同数量的参数。

当我们想要参数化我们的新实例时，构造函数可以接受参数创造。
``` ts
class Person {
  first_name: string;
  last_name: string;
  age: number;

  constructor(first_name: string, last_name: string, age: number) {
    this.first_name = first_name;
    this.last_name = last_name;
    this.age = age;
  }
}

// 在创建对象时为我们设置人员的姓名和年龄
var p: Person = new Person('Felipe', 'Coury', 36);
```

##### 继承 Inheritance
面向对象编程的另一个重要方面是继承。
继承表示类从父类接收行为的方法。
那我们可以重写、修改或扩展新类上的这些行为。

重用Report类向用户显示数据的方式:
``` ts
class Report {
  data: Array<string>;

  constructor(data: Array<string>) {
    this.data = data;
  }

  run() {
    this.data.forEach(function(line) { console.log(line); });
  } 
}

class TabbedReport extends Report {
  headers: Array<string>;

  constructor(headers: string[], values: string[]) {
    super(values)
    this.headers = headers;
  }
  run() {
    console.log(this.headers);
    super.run();
  } 
}
```

##### 公用程序 Utilities
ES6和扩展TypeScript提供了许多语法特性，使编程真的很有趣。
两个重要体现：
- 箭头函数
- 模板字符串

``` ts
// ES5
var data = ['Alice Green', 'Paul Pfifer', 'Louis Blakenship'];
data.forEach(function(line) { console.log(line); });

// Typescript
data.forEach( (line) => console.log(line) );
```

只有一个参数时，括号是可选的。可以使用=>语法作为一种表达：
``` ts
var evens = [2,4,6,8];
var odds = evens.map(v => v + 1);
```

模板字符串特点：
1.字符串中的变量（不强制与+连接）
2.多行字符串
``` ts
// 写在反勾号里面
var greeting = `Hello ${firstName} ${lastName}`;

var template = `
 <div>  
   <h1>Hello</h1>
   <p>This is a great website</p>
 </div>
 `
```


