---
title: Angular-doc
date: 2020-01-13 17:57:58
categories:
- Angular
tags:
- Angular
---
# why
只有Angular能一站式解决 其他的都是库的分集合治平台

我对 React 也很熟，但是当我面对 Redux 那一堆东西的时候，我感觉我疯了
还有 Saga 那一堆

当然我还是喜欢 React 的，它有自己原创的设计之美
那是一种不同的美感

高阶函数

Angular 这个框架现在的问题最大
太重、太封闭了
社区根本跟不上他们

Vue 和 React 拿来写小程序都很快很方便，但是 Angular 要拿来做小程序几乎是不可能的

# 基础
## @angular/core 
ViewChild
{ static: true }引入了该选项以支持动态创建嵌入式视图

# angular.cn
## 架构概览
组件定义视图，组件使用服务（依赖注入）

模块、组件和服务都是使用装饰器的类

### 模块
和 JavaScript（ES2015） 的模块不同而且有一定的互补性。 
NgModule 可以将其组件和一组相关代码（如服务）关联起来，形成功能单元。

### 服务与依赖注入
对于与特定视图无关并希望跨组件共享的数据或逻辑，可以创建服务类。 服务类的定义通常紧跟在 “@Injectable()” 装饰器之后。该装饰器提供的元数据可以让你的服务作为依赖被注入到客户组件中。

HttpClient.get() 默认情况下把响应体当做无类型的 JSON 对象进行返回。 如果指定了可选的模板类型 <Hero[]>，就会给返回你一个类型化的对象。

RxJS Subject
``` ts
private searchTerms = new Subject<string>();

// Push a search term into the observable stream.
search(term: string): void {
  this.searchTerms.next(term);
}
```
Subject 既是可观察对象的数据源，本身也是 Observable。 你可以像订阅任何 Observable 一样订阅 Subject。

你还可以通过调用它的 next(value) 方法往 Observable 中推送一些值，就像 search() 方法中一样。

## 模块
NgModule 是一个带有 @NgModule() 装饰器的类。@NgModule() 装饰器是一个函数，它接受一个元数据对象，该对象的属性用来描述这个模块。其中最重要的属性如下。

declarations（可声明对象表） —— 那些属于本 NgModule 的组件、指令、管道。

exports（导出表） —— 那些能在其它模块的组件模板中使用的可声明对象的子集。

imports（导入表） ——  数组中，这里是该应用所需外部模块的列表。

providers —— 本模块向全局服务中贡献的那些服务的创建器。 这些服务能被本应用中的任何部分使用。（你也可以在组件级别指定服务提供者，这通常是首选方式。）

bootstrap —— 应用的主视图，称为根组件。它是应用中所有其它视图的宿主。只有根模块才应该设置这个 bootstrap 属性。

``` ts
import { NgModule }      from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
@NgModule({
  imports:      [ BrowserModule ],
  providers:    [ Logger ],
  declarations: [ AppComponent ],
  exports:      [ AppComponent ],
  bootstrap:    [ AppComponent ]
})
export class AppModule { }
```

## 组件
组件的元数据告诉 Angular 到哪里获取它需要的主要构造块，以创建和展示这个组件及其视图。 具体来说，它把一个模板（无论是直接内联在代码中还是引用的外部文件）和该组件关联起来。 该组件及其模板，共同描述了一个视图。
下面的例子中就是 HeroListComponent 的基础元数据：
``` ts
@Component({
  selector:    'app-hero-list',
  templateUrl: './hero-list.component.html',
  providers:  [ HeroService ]
})
export class HeroListComponent implements OnInit {
/* . . . */
}
```

selector：是一个 CSS 选择器
templateUrl：该组件的 HTML 模板文件相对于这个组件文件的地址
providers：当前组件所需的服务提供者的一个数组

## 服务与DI
组件应该把诸如从服务器获取数据、验证用户输入或直接往控制台中写日志等工作委托给各种服务。通过把各种处理任务定义到可注入的服务类中，你可以让它被任何组件使用。 通过在不同的环境中注入同一种服务的不同提供者，你还可以让你的应用更具适应性。

依赖注入（dependency injection）
要把一个类定义为服务，就要用 @Injectable() 装饰器来提供元数据，以便让 Angular 可以把它作为依赖注入到组件中

### 模拟数据
``` ts
import { Observable, of } from 'rxjs';
getHeroes(): Observable<Hero[]> {
  return of(this.HEROES);
}
```


# 知识
## 组件-conponent
- 一个组件类
- 一个HTML模版
- 组件专属的样式

## 模板语法
### 属性型指令
属性型指令改变一个元素的外观或行为。
例如，内置的 NgStyle 指令可以同时修改元素的多个样式。

``` zsh
ng generate directive highlight
```
``` ts
import { Directive, ElementRef } from '@angular/core';

@Directive({
  selector: '[appHighlight]'
})
export class HighlightDirective {
    constructor(el: ElementRef) {
       el.nativeElement.style.backgroundColor = 'yellow';
    }
}
```
``` html
<p appHighlight>Highlight me!</p>
```


### 结构型指令
特点：
+ 带有 * 的指令
+ 结构型指令会通过添加、删除和操纵它们的宿主元素等方式塑造或重塑 DOM 的结构

list
- *ngFor
- *ngIf
- *ngSwitch

#### 优先使用星号（*）语法
星号（*）语法比不带语法糖的形式更加清晰。 如果找不到单一的元素来应用该指令，可以使用<ng-container>作为该指令的容器。

#### <ng-template>元素
<ng-template>是一个 Angular 元素，用来渲染 HTML。 它永远不会直接显示出来。 事实上，在渲染视图之前，Angular 会把 <ng-template> 及其内容替换为一个注释。

如果没有使用结构型指令，而仅仅把一些别的元素包装进 <ng-template> 中，那些元素就是不可见的。 在下面的这个短语"Hip! Hip! Hooray!"中，中间的这个 "Hip!"（欢呼声） 就是如此。
``` html
<p>Hip!</p>
<ng-template>
  <p>Hip!</p>
</ng-template>
<p>Hooray!</p>
```


### 插值语法 
插值  { {} } 会把属性的值作为文本渲染出来

### 属性绑定语法
属性绑定语法 [], 在模板表达式中使用属性值
[title]="product.name"

### 事件绑定
事件绑定是通过把事件名称包裹在圆括号 () 中

# 大漠穷秋-angular教程
在计算机领域，任何东西研究到最底层都和“算法”、“数据结构”、“设计模式”有关。而就我所知，很多朋友并不具备研究这些内容的基础知识，不过是白白浪费自己的时间而已。
带你学会开车，而不是教你设计发动机
这个系列的内容非常看重“概念模型”（Mental Model）的构建。“核心价值”
并没有掌握这门框架的精髓

## debug
请把你本地 launch.json 文件里面的内容改成这样：
``` json
{
    "version": "0.2.0",
    "configurations": [
        {
            "type": "chrome",
            "request": "launch",
            "name": "Chrome",
            "url": "http://localhost:4200",
            "webRoot": "${workspaceRoot}"
        }
    ]
}
```

## Schematics 与代码生成器
@angular/cli 内置的 add 命令

### angular-cli
``` zsh
$ ng g m pages/suit/suit-routing --flat            
CREATE src/app/pages/suit/suit-routing.module.ts (197 bytes)

生成一个module的service。 ng g service test --module=app
```



## [组件]概念
几乎所有前端框架都在玩`组件化`，而且最近都不约而同地选择了“标签化”这种思路，Angular 也不例外。

对新版本的 Angular 来说，一切都是围绕着“组件化”展开的，组件是 Angular 的核心概念模型。
``` ts
import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.scss']
})
export class AppComponent implements OnInit {
}  
```
+ @Component：这是一个 Decorator（装饰器），其作用类似于 Java 里面的 Annotation（注解）。Decorator 这个特性目前处于 Stage 2（草稿）状态，还不是 ECMA 的正式规范


## [组件]模板的使用
`模板是编写Angular组件最重要的一环`
+ 对比各种 JS 模板引擎的设计思路
+ Mustache（八字胡）语法
+ 模板内的局部变量
+ 属性绑定、事件绑定、双向绑定
+ 在模板里面使用结构型指令 *ngIf、*ngFor、ngSwitch
+ 在模板里面使用属性型指令 NgClass、NgStyle、NgModel
+ 在模板里面使用管道格式化数据
+ 一些小 feature：安全导航、非空断言

对比各种 JS 模板引擎的设计思路
几乎每一款前端框架都会提供自己的模板语法：
+ 在 jQuery 如日中天的时代，有 Handlebars 那种功能超强的模板
+ React 推崇 JSX 模板语法
+ 当然还有 Angular 提供的那种与“指令”紧密结合的模板语法
综合来说，无论是哪一种前端模板，大家都比较推崇“轻逻辑”（logic-less）的设计思路。

简而言之，所谓“轻逻辑”就是说，你不能在模板里面编写非常复杂的 JavaScript 表达式。比如，Angular 的模板语法就有规定：

+ 你不能在模板里面 new 对象
+ 不能使用 =、+=、-= 这类的表达式
+ 不能用 ++、-- 运算符
+ 不能使用位运算符

为什么要“轻逻辑”？

最重要的原因是怕影响运行性能，因为模板可能会被执行很多次。
``` html
<ul>
    <li *ngFor="let race of races">
        {{race.name}}
    </li>
</ul>
```
很明显，浏览器不认识 *ngFor 和 {{…}} 这种语法，因此必须在浏览器里面进行“编译”，获得对应的模板函数，然后再把数据传递给模板函数，最终结合起来获得一堆 HTML 标签，然后才能把这一堆标签插入到 DOM 树里面去。

如果启用了 AOT，处理的步骤有一些变化，@angular/cli 会对模板进行“静态编译”，避免在浏览器里面动态编译的过程。

而 Handlebars 这种模板引擎完全是运行时编译模板字符串的，你可以编写以下代码：

``` ts
//定义模板字符串
var source=`
<ul>
    {{#each races}}
        <li>{{name}}</li>
    {{/each}}
</ul>
`;

//在运行时把模板字符串编译成 JS 函数
var templateFn=Handlebars.compile(source);

//把数据传给模板函数，获得最终的 HTML
var html=templateFn([
    {name:'人族'},
    {name:'神族'},
    {name:'虫族'}
]);
```

注意到 Handlebars.compile 这个调用了吧？这个地方的本质是在运行时把模板字符串“编译”成了一个 JS 函数。

鉴于 JS 解释执行的特性，你可能会担忧这里会有性能问题。这种担忧是合理的，但是 Handlebars 是一款非常优秀的模板引擎，它在内部做了各种优化和缓存处理。模板字符串一般只会在第一次被调用的时候编译一次，Handlebars 会把编译好的函数缓存起来，后面再次调用的时候会从缓存里面获取，而不会多次进行“编译”。

上面我们多次提到了“编译”这个词，因此很显然这里有一个东西是无法避免的，那就是我们必须提供一个 JS 版的“编译器”，让这个“编译器”运行在浏览器里面，这样才能在运行时把用户编写的模板字符串“编译”成模板函数。

有一些模板引擎会真的去用 JS 编写一款“编译器”出来，比如 Angular 和 Handlebars，它们都真的编写了一款 JS（TS）版的编译器。而有一些简单的模板引擎，例如 Underscore 里面的模板函数，只是用正则表达式做了字符串替换而已，显得特别简陋。这种简陋的模板引擎对模板的写法有非常多的限制，因为它不是真正的编译器，能支持的语法特性非常有限。

因此，评估一款模板引擎的强弱，最核心的东西就是评估它的“编译器”做得怎么样。但是不管怎么说，毕竟是 JS 版的“编译器”，我们不可能把它做得像 G++ 那么强大，也没有必要做得那么强大，因为这个 JS 版的编译器需要在浏览器里面运行，搞得太复杂浏览器拖不动！

以上就是为什么大多数模板引擎都要强调“轻逻辑”的最根本原因。

对于 Angular 来说，强调“轻逻辑”还有另一个原因：在组件的整个生命周期里面，模板函数会被执行很多次。你可以想象，Angular 每次要刷新组件外观的时候，都需要去调用一下模板函数，如果你在模板里面编写了非常复杂的代码，一定会增加渲染时间，用户一定会感到界面有“卡顿”。

人眼的视觉延迟大约是 100ms 到 400ms 之间，如果整个页面的渲染时间超过 400ms，界面基本上就卡得没法用了。有一些做游戏的开发者会追求 60fps 刷新率的细腻感觉，60 分之 1 秒约等于 16.7ms，如果 UI 整体的渲染时间超过了 16.7ms，就没法达到这个要求了。

轻逻辑（logic-less）带来了效率的提升，也带来了一些不方便，比如很多模板引擎都实现了 if 语句，但是没有实现 else，因此开发者们在编写复杂业务逻辑的时候模板代码会显得非常啰嗦。

目前来说，并没有完美的方案能同时兼顾运行效率和语法表现能力，这里只能取一个平衡。


### Mustache 语法
Mustache 语法也就是你们说的双花括号语法 {{…}}，老外觉得它像八字胡子，很奇怪啊，难道老外喜欢侧着头看东西？

好消息是，很多模板引擎都接受了 Mustache 语法，这样一来学习量又降低了不少，开心吧？

关于 Mustache 语法，你需要掌握 3 点：

+ 它可以获取到组件里面定义的属性值
+ 它可以自动计算简单的数学表达式，如加减乘除、取模
+ 它可以获得方法的返回值

AngularJS 是第一个把“双向数据绑定”这个特性带到前端来的框架，这也是 AngularJS 当年最受开发者追捧的特性，之一。

根据 AngularJS 团队当年讲的故事，“双向数据绑定”这个特性可以大幅度压缩前端代码的规模。大家可以回想一下 jQuery 时代的做法，如果要实现类似的效果，是不是要自己去编写大量的代码？尤其是那种大规模的表单，一大堆的赋值和取值操作，都是非常丑陋的“面条”代码，而有了“双向数据绑定”特性之后，一个绑定表达式就搞定。

目前，主流的几款前端框架都已经接受了“双向数据绑定”这个特性。

当然，也有一些人不喜欢“双向数据绑定”，还有人专门写了文章来进行批判，也算是前端一景。

在模板里面使用`结构型指令`
Angular 有 3 个内置的结构型指令：*ngIf、*ngFor、ngSwitch。ngSwitch 的语法比较啰嗦，使用频率小一些。

特别注意：一个 HTML 标签上只能同时使用一个结构型的指令。

因为“结构型”指令会修改 DOM 结构，如果在一个标签上使用多个结构型指令，大家都一起去修改 DOM 结构，到时候到底谁说了算？

那么需要在同一个 HTML 上使用多个结构型指令应该怎么办呢？有两个办法：

加一层空的 div 标签
加一层 <ng-container>

在模板里面使用`属性型指令`
使用频率比较高的 3 个内置指令是：NgClass、NgStyle、NgModel。

## [组件]组件间通讯
组件之间有几种典型的关系：父子关系、兄弟关系、没有直接关系。
通讯方案:
- 直接的父子关系：父组件直接访问子组件的 public 属性和方法
- 直接的父子关系：借助于 @Input 和 @Output 进行通讯
- 没有直接关系：借助于 Service 单例进行通讯
- 利用 cookie 和 localstorage 进行通讯
- 利用 session 进行通讯

在 ProductAlertsComponent 类的定义中，定义一个带 @Input() 装饰器的 product 属性。@Input() 装饰器指出其属性值是从该组件的父组件商品列表组件中传入的。
在组件类中，用 @Output() 装饰器和一个事件发射器 EventEmitter() 实例定义一个名为 notify 的属性。这可以让商品提醒组件在 notify 属性发生变化时发出事件。

### 单例通信
随着Angular 6的问世，我们获得了这个新的闪亮工具，用于对应用程序中的依赖项进行建模。官方名称为“可摇树的提供者 ”，我们通过使用装饰器的新providedIn属性来使用它@Injectable。
我们可以将其providedIn视为反向指定的依赖项。现在，不再是模块提供所有服务，而是服务本身声明应该在哪里提供…
模块可以是providedIn在'root'或在任何可用的模块（例如providedIn: SomeModule）。除此之外'root'，实际上是AppModule（因此是根注入器）的别名，这是一个很好的便利功能，它节省了我们AppModule在代码库中的所有导入。

`{% asset_img inject.png %}`

cart.service.ts
``` ts
export class CartService {
  items = [];

  addToCart(product) {
    this.items.push(product);
  }

  getItems() {
    return this.items;
  }

  clearCart() {
    this.items = [];
    return this.items;
  }
}
```


## [组件]内容投影
须知：自定义标签里面是无法嵌套标签的
``` html
<div class="panel panel-primary">
  <div class="panel-heading">
    <ng-content></ng-content>
  </div>
  <div class="panel-body">
      内容
  </div>
  <div class="panel-footer">
      底部
  </div>
</div>
```

``` html
<test-child-two>
    <h3>这是父层投影进来的内容</h3>
</test-child-two>
```

## 指令
- Component 是 Directive 的子接口，是一种特殊的指令
- 属性型指令：用来修改 DOM 元素的外观和行为，但是不会改变 DOM 结构，Angular 内置指令里面典型的属性型指令有 ngClass、ngStyle。
- 结构型指令：可以修改 DOM 结构，内置的常用结构型指令有 *ngFor、*ngIf 和 NgSwitch



# 注意点
- node_modules  用命令行删除比较快
- cli 创建项目的时候，--style=sass
- dependencies：运行时也会依赖的，打包时会打包合并到发布的模块里面去
  devDependencies：开发时的依赖，不需要打包出去，发布到线上
- yarn.lock  会锁定版本号，安装的时候会直接读这个文件，所以比较快
- ng serve ; 不是 ng server ； serve动词，表示服务
- e2e end2end，集成测试
- package.json 里面的依赖版本，不要使用～，锁死版本号；～的话，会解析最新版本，会导致每个人机器上都不一样
- ng g c UserMng 驼峰法则会自动展开变成中划线

# 坑
- node-sass

# 教程
## Angular 核心概念
- 集成开发环境@angular/cli
- Angular 三大核心概念：Component，Module, Route
- Angular 架构特色：依赖注入，数据绑定

## 异步加载，按需加载
Angular 加载最小模块是 module，不是component
每个模块 不超过 200k

## 路由
路由规划
路由守卫

## Angular 架构特色
依赖注入
只需要在 类的 constructor构造函数 里面声明出来，我要一个service

双向绑定

## HttpInterceptor 处理所有请求异常

# 核心概念：component
内容摘要：
- 把CSS与编译器改成SCSS
- 导入Bootstrap和font-awesome
- 插值语法和表达式
- 在模版内定义局部变量
- 值绑定[]，事件绑定()，双向绑定[()]
- 内置结构型指令用法：*ngIf, *ngFor, ngSwitch
- 内置属性型指令用法：NgClass, NgStyle, NgModel
- 小工具：管道，安全导航，非空断言


## 导入Bootstrap和font-awesome
src/style.scss
``` scss
@import "~bootstrap/dist/css/bootstrap.min.css";
@import "~font-awesome/css/font-awesome.min.css";
```

``` html
<button type="button" class="btn btn-primary">Primary</button>
<button type="button" class="btn btn-secondary">Secondary</button>

<i class="fa fa-angle-down"></i>
<i class="fa fa-area-chart"></i>
<i class="fa fa-american-sign-language-interpreting fa-2x"></i>
<i class="fa fa-at"></i>
```

## 插值语法和表达式
最基本的内容
jquery时代：handlebars 前端模版库；现代库也是借鉴了的
双花括号：{{ value }}
支持：属性，基本的运算（轻逻辑），方法
``` html
{{ title }} {{ 1-1 }} {{getValue()}}
```

安全导航运算符（ ? ）
``` html
<p>The item name is: {{item?.name}}</p>
```

非空断言运算符（!）
``` html
<p>The item's color is: {{item.color!.toUpperCase()}}</p>
```

## 在模版内定义局部变量
使用语法 #
``` html
<input #heroInput>
<p>{{heroInput.value}}</p>
<button class="btn btn-success" (click)="sayHello(heroInput.value)">局部变量</button>
```

## 值绑定[]，事件绑定()，双向绑定[()]
``` html
<img [src]="imgSrc" />
<button class="btn btn-success" (click)="changeSrc()">修改图片src</button>
```

``` html
<button class="btn btn-success" (click)="btnClick($event)">测试事件</button>
```

``` html
<font-resizer [(size)]="fontSizePx"></font-resizer>
<div [style.font-size.px]="fontSizePx">Resizable Text</div>
```

## 内置结构型指令用法：*ngIf, *ngFor, ngSwitch
``` html
<div *ngFor="let item of items; let i = index"></div>
```

``` html
<div [ngSwitch]="2">
  <p *ngSwitchCase="1">1</p>
  <p *ngSwitchCase="2">2</p>
</div>
```

## 内置属性型指令用法：NgClass, NgStyle, NgModel
``` html
<div [ngClass]="currentClass">ngClass</div>
currentClass = {'save': true, 'color': false};

[ngClass]="{
  'aside__menu--active': menu.id === selectedMenuId
}"

<div [ngStyle]="currentStyles">
currentStyles = {'font-style':  this.canSave      ? 'italic' : 'normal'}
```

## 小工具：管道，安全导航，非空断言
管道，数据格式化：把左边的当成参数传递给右边
``` html
<div>{{ currentTime | date: 'yyyy-MM-dd hh:mm:ss'}}</div>
```

安全导航
``` html
<p>{{ current?.name }}</p>
```

### async
AsyncPipe
*ngFor 会重复渲染这些英雄对象。注意，*ngFor 在一个名叫 heroes$ 的列表上迭代，而不是 heroes。$ 是一个约定，表示 heroes$ 是一个 Observable 而不是数组。
``` html
<li *ngFor="let hero of heroes$ | async" >
```

# component 通信
## 父子
父传子：@Input
子传父：@Output EventEmitter
父调用子：
- 模版局部变量#child
-  @ViewChild('child') child: ChildComponent;

## 兄弟
- Subject
- localStorge


# 生命周期
钩子 就是 事件
`{% asset_img life1.png %}`
`{% asset_img life2.png %}`
先去加载内容投影的例子，再去加载自身视图
`{% asset_img life3.png %}`

组件是带有视图的指令
Component extends Directive

构造函数里面最好只做一些简单的赋值操作，不要做复杂的逻辑
获取服务端数据、业务逻辑等不要实现在构造函数里面
想知道详细的原因请看这篇解释http://misko.hevery.com/code-reviewers-guide/flaw-constructor-does-real-work/

## ngOnChanges
调用：
- 在 ngOnInit() 之前
- 所绑定的一个或多个输入属性的值发生变化时都会调用。（@Input属性发生变化的时候被调用）
  非@Input属性改变不会调用ngOnChanges


# 动效 animations
web-animation方案，超前
Angular animations 有点怪怪的，建议用CSS3
开源动效库：
https://github.com/jiayihu/ng-animate


# 动态组件

根据自己的业务，场景，写不同的组件，不是写死的组件

``` ts
//这里引用模板里面定义的dyncomp容器标签
  @ViewChild("dyncomp", { read: ViewContainerRef, static: true })
  dyncomp: ViewContainerRef;

  comp1: ComponentRef<Child11Component>;
  comp2: ComponentRef<Child11Component>;

  constructor(
    private resolver: ComponentFactoryResolver) {

  }

  ngAfterContentInit() {
    console.log("动态创建组件的实例...");
    const childComp = this.resolver.resolveComponentFactory(Child11Component);
    this.comp1 = this.dyncomp.createComponent(childComp);
    this.comp1.instance.title = "111";
    this.comp1.instance.btnClick.subscribe((param) => {
      console.log("--->" + param);
    });

    /**
     * createComponent方法可以调用很多次，会动态创建出多个组件实例
     * 方法有第二个参数，表示组件渲染的顺序
     */
    this.comp2 = this.dyncomp.createComponent(childComp);
    this.comp2.instance.title = "第二个子组件";
  }

  public destoryChild(): void {
    this.comp1.destroy();
    this.comp2.destroy();
  }
```

# ShadowDOM
性能高，现在不需要改
``` ts
@Component({
  selector: 'shadow-dom-mode',
  encapsulation:ViewEncapsulation.Native,
  templateUrl: './shadow-dom-mode.component.html',
  styleUrls: ['./shadow-dom-mode.component.scss']
})
```

# ViewChild与ContentChild
## ViewChild
属性装饰器，用于配置一个视图查询。
在 ngAfterViewInit 钩子函数中，就能正确获取查询的元素
``` ts
@ViewChild('avatarEle') avatarEle: ElementRef;

// dom
this.avatarEle.nativeElement;
```

# 指令
存在原因：自定义标签 无法使用标签原有属性；创建指令，让他有标签属性
``` html
<child-one class="无法使用" my-attr="创建指令，让他拥有属性"></child-one>
```

官方提供指令：
https://angular.io/api?type=directive

``` ts
import { Directive, ElementRef, HostListener, HostBinding, Input } from '@angular/core';

@Directive({
  selector: '[my-high-light]'
})
export class MyHighLightDirective {
  @Input()
  highlightColor: string;

  // @HostBinding("style.border")
  // border:string;

  @HostBinding("class")
  myClass: string;

  constructor(private el: ElementRef) {
    console.log(el);
    el.nativeElement.style.backgroundColor = '#ff3300';
  }

  @HostListener('mouseenter') onMouseEnter() {
    this.highlight(this.highlightColor);
  }

  @HostListener('mouseleave') onMouseLeave() {
    this.highlight(null);
  }

  private highlight(color: string) {
    //这里在操作DOM
    //这种操作代码非常丑陋
    this.el.nativeElement.style.backgroundColor = color;
    //this.$("p")
  }
}
```

# 模块
## 基本概念
- Angular的模块是业务模块，是用来组织业务的
- 每个应用至少有一个根模块
- 每个组件必须属于一个模块，而且只能属于一个模块
- 模块是@angular/cli打包的最小单位【编译出来的，一个一个的js】
- 模块也是Router异步加载时的最小单位

`{% asset_img module.png %}`

## 编译文件
wendor.js：angular内核，和周边的工具
polyfills.js：腻子脚本

## 路由
- 前端开发为什么要路由
- 路由基本用法（同步路由与router-outlet）
- 路由与懒加载模块
- N层嵌套路由
- 共享模块
- 监听路由事件
- 传递和获取路由参数（单个参数、矩阵式参数）
- 用代码触发路由导航

路由出口
``` html
<router-outlet></router-outlet>
```

方法一：
app-routing.module.ts
``` ts
import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { HeroesComponent } from './heroes/heroes.component';

const routes: Routes = [
  { path: 'heroes', component: HeroesComponent }
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
```

方法二：
app.module.ts
``` ts
@NgModule({
  declarations: [
    AppComponent,
    TestComponent
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    RouterModule.forRoot([
      { path: 'test', component: TestComponent}
    ]),
    // FormsModule,
    ReactiveFormsModule
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
```

这个方法之所以叫 forRoot()，是因为你要在应用的顶层配置这个路由器。 forRoot() 方法会提供路由所需的服务提供者和指令，还会基于浏览器的当前 URL 执行首次导航。

activeRoute：当前路由的实例

imports: [RouterModule.forRoot(routes, {preloadingStrategy: PreloadAllModules})],
forRoot：我这个router模块，在启动的时候，把路由配置项{} 传给他

路由事件怎么监听的？
注射到构造器里面，angular运行时会检查构造器里面声明的属性

默认导航
``` ts
{ path: '', redirectTo: '/dashboard', pathMatch: 'full' },
```

### 注册路由
app.module.ts
``` ts
@NgModule({
  declarations: [
    AppComponent,
    TestComponent
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    RouterModule.forRoot([
      { path: 'test', component: TestComponent}
    ])
  ]
})
```

### 路由要规划的
为了：
SEO：Search Engine Optimization（搜索引擎优化）
SSR：Server-Side Rendering(服务器端渲染)

### 为什么需要路由
- 没有router，浏览器的前进后退按钮没法用
- 没有router，你将无法把URL拷贝并分享给你的朋友

### 路由传参
path：'home/:page' 待会收到参数时，放到page这个key里面作为他的值

取参
``` ts
this.activatedRoute.params.subscribe

this.activatedRoute.queryParams.subscribe
```

矩阵式传参（合法的，用的人不是很多，html之父说了这个，w3c没有规范）
``` html
<a [routerLink]="['test', {id: 111, name: 'damo'}]">段子</a>
```

``` ts
this.router.navigate(['test'], {queryParams: {page: 1, name: 222}});
```

### 路由加载方式
懒加载
loadChildren

智能预加载：空闲的时候，悄悄加载

#### 预加载策略
PreloadingStrategy
- 全部预加载：PreloadAllModules
- 部分预加载：MyPreloadingStrategy
``` ts
@NgModule({
  declarations: [
    AppComponent
  ],
  imports: [
    BrowserModule,
    AppRoutingModule
  ],
  providers: [MyPreloadingStrategy],
  bootstrap: [AppComponent]
})


import { NgModule } from '@angular/core';
import { Routes, RouterModule, PreloadAllModules } from '@angular/router';

const routes: Routes = [
  {
    path: "test",
    loadChildren: "./router-test/router-test.module#RouterTestModule"
  },
  {
    path: "preload",
    data:{preload:true},
    loadChildren: "./preload/preload.module#PreloadModule"
  },
];

@NgModule({
  imports: [RouterModule.forRoot(routes, {preloadingStrategy: PreloadAllModules})],
  exports: [RouterModule]
})
export class AppRoutingModule { }

import { Route,PreloadingStrategy } from '@angular/router';
import { Observable, of } from "rxjs";
// import "rxjs/add/observable/of";
// import { of } from 'rxjs/observable/of';


export class MyPreloadingStrategy implements PreloadingStrategy {
    preload(route: Route, fn: () => Observable<any>): Observable<any>{
        // return route.data&&route.data.preload?fn():Observable
        // of()
        if (route.data&&route.data.preload) {
            return fn()
        } else {
            return of(null);
        }
    }
}
```
### 高级玩法
- [加载策略]如何预加载模块？
- [加载策略]如何自定义预加载策略？
- [路由守卫]如何控制模块加载？
- [路由守卫]如何控制非授权访问?
- [路由守卫]如何保护用户输入的内容不丢失？



用户在输入表单的时候，由于一些失误（意外的触发导航），导致所有内容全部丢失
一些网站：国企，政府，银行；这种傻逼的行为
有情怀的，希望构建友好的用户界面，误操作保存


guard
``` ts
export const appRoutes:Routes=[
    {
        path:'jokes',
        data:{preload:true},
        canLoad:[AuthGuard],
        canActivate:[AuthGuard],
        loadChildren: () => import('./jokes/jokes.module').then(m => m.JokesModule)
    },
];

@NgModule({
	imports: [RouterModule.forRoot(appRoutes)],
	exports: [RouterModule]
})
export class AppRoutingModule { }
```

#### 激活路由
ActivateRoute
获取路由的参数
activatedRoute.queryParamMap.subscribe

#### 路由器事件
Router.events
获取前路由和当前路由
RoutesRecognized
``` ts
this.router.events
  .pipe(filter((evt: any) => evt instanceof RoutesRecognized), pairwise())
  .subscribe((events: RoutesRecognized[]) => {
    console.log('previous url', events[0].urlAfterRedirects);
    console.log('current url', events[1].urlAfterRedirects);
    let previous_url = events[0].urlAfterRedirects;
    if (previous_url !== '/signin' && previous_url !== '/sms-signin') {
      localDB.set('previous_url', {url: events[0].urlAfterRedirects});
    }
  });
```

## 表单
- 模版驱动型表单
- 响应式表单
- 动态表单
- 数据校验

### 数据校验-内置校验规则
- required
- requireTrue
- minLength
- maxLength
- pattern
- nullValidator
- compose
- composeAsync

### 例子
#### 表单构建器
FormBuilder 服务生成控件
FormBuilder 服务有三个方法：control()、group() 和 array()。这些方法都是工厂方法，用于在组件类中分别生成 FormControl、FormGroup 和 FormArray。
``` html
<form [formGroup]="checkoutForm" (ngSubmit)="onSubmit(checkoutForm.value)">
  <div>
    <label for="name">
      Name
    </label>
    <input id="name" type="text" formControlName="name">
  </div>
  <button class="button" type="submit">Purchase</button>
</form>
```
引入了  ReactiveFormsModule
``` ts
export class TestComponent {
  price = 1000000;
  checkoutForm;
  constructor(
    private formBuilder: FormBuilder
  ) {
    this.checkoutForm = this.formBuilder.group({
      name: '',
      address: ''
    });
  }

  onSubmit(customerData) {
    console.log('customer', customerData);
  }
}
```

#### 手动创建实例
``` ts
profileForm = new FormGroup({
  firstName: new FormControl(''),
  lastName: new FormControl(''),
  address: new FormGroup({
    street: new FormControl(''),
    city: new FormControl(''),
    state: new FormControl(''),
    zip: new FormControl('')
  })
});
```

# implements 
在TypeScript中，有Class类和interface接口，接口只定义类型的成员或者方法的契约，就是如果你implements了我的契约，那你必须得在类中必须有接口的所有成员（属性），按照契约来实现，如果没有按照接口声明的类型编写，IDE支持TypeScript就会警告报错，编译也会报错，将错误修复在部署之前。
``` ts
// angular 定义了一个OnInit的接口，
// 所有实施`implements`这个接口的Class必须要实现成员ngOnInit
interface OnInit {
  ngOnInit(): void
}

export class HeroesComponent implements OnInit {
  hero = 'windstorm';
  constructor() { }

  ngOnInit() {
  }

}
```


# rxjs
Reactive Extensions

是promise的火力增强版

`{% asset_img rxjs.png %}`

最常用的23个Operator（操作员，接线员）
- 创建型：Create/ defer/ from/ interval/ just
- 变换型：map/ flatMap/ scan
- 过滤型：filter/ debounce
- 组合型：join/ merge/ zip
- 异常处理型：catch/ retry
- 工具型：delay/ subscribe
- 条件判断型：all/ contains/ takeWhile
- 数学运算和聚合函数型：average
- 连接型：connect
- 数据结构转换型：to

如何还想偷懒：map，filter

## 搜索延时
``` ts
import { Subject } from 'rxjs';

public searchTextStream: Subject<string> = new Subject<string>();

this.searchTextStream.pipe(debounceTime(500), distinctUntilChanged()).subscribe(() => {
      this.loadData();
    });

search() {
  this.commonQuery.keyword = this.keyword;
  this.searchTextStream.next(this.keyword);
}    
```    

# 引用第三方库
angular 使用 TypeScript
TypeSearch检索, 检测第三方库有没有声明文件
[TypeSearch](https://microsoft.github.io/TypeSearch/)

## 如何引用
声明文件是纽带
### 有声明文件
无需额外做什么，只需在需要模块的地方使用 import 来导入即可
``` ts
import * as dragonBones from '../../assets/js/dragonBones';
```

using published libraries
声明文件
``` zsh
npm install d3 --save
npm install @types/d3 --save-dev
```

### 无声明文件
在 src/typings.d.ts 文件下
``` ts
declare var G2: any;
declare var TooqingCore;
```
使用 any 来表示忽略静态类型检查，意味者无法享受声明文件带来的智能提示快感。
像 G2 ，我们可以在项目的任意位置直接使用它，但也仅仅只能识别 G2 变量，而实例的方法或属性是不可知的。
``` ts
const g2 = new G2();
g2. // 输入 `.` 后是不会有任何方法或属性
```
除此之外 TypeScript 编译过程中也不会对 G2 做任何类型检查，G2 是否真的存在只能由自己把握。

对于 Angular 而言，是需要额外在 .angular-cli.json 的 scripts 节点上明确加载这些模块。
.angular-cli.json
``` json
"scripts": ["../node_modules/@antv/g2/dist/g2.min.js"],
// game-core
"scripts": [
  "node_modules/game-core/release/js/tooqing.js"
],
```

## 引用第三方库 dragonBones
错误引用法：
在assets 文件下建了js文件，把dragonBones相关文件复制进去
一直无法用到声明文件的智能提示

猛哥解决办法：
根目录新建lib文件，把dragonBones相关文件复制进去
然后，鼠标放在 dragonBones 上面，使用编辑器自动修复引用
`{% asset_img dragonBones.png %}`

# 依赖注入
providers  依赖提供者
https://cloud.tencent.com/developer/article/1542963
https://angular.cn/guide/dependency-injection-providers
https://juejin.im/post/6844903592797683719