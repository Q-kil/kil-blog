---
title: Observable(可观察对象)
date: 2019-11-05 10:41:15
categories:
- Rxjs
tags:
---

获取前后路由变化 地址
``` js
this.router.events
  .pipe(filter((evt: any) => evt instanceof RoutesRecognized), pairwise())
  .subscribe((events: RoutesRecognized[]) => {
    console.log('previous url', events[0].urlAfterRedirects);
    console.log('current url', events[1].urlAfterRedirects);
  });
```

## router.events(路由事件)
在每次导航中，Router都会通过 Router.events 属性发布一些导航事件。这些事件的范围涵盖了从开始导航到结束导航之间的很多时间点。

返回 Observable

## Observable
### what
可观察对象支持在应用中的发布者和订阅者之间传递消息。 在需要进行事件处理、异步编程和处理多个值的时候，可观察对象相对其它技术有着显著的优点。

可观察对象是声明式的 —— 也就是说，虽然你定义了一个用于发布值的函数，但是在有消费者订阅它之前，这个函数并不会实际执行。 订阅之后，当这个函数执行完或取消订阅时，订阅者就会收到通知。

### why
可观察对象可以发送多个任意类型的值 —— 字面量、消息、事件。无论这些值是同步发送的还是异步发送的，接收这些值的 API 都是一样的。 由于准备（setup）和清场（teardown）的逻辑都是由可观察对象自己处理的，因此你的应用代码只管订阅并消费这些值就可以了，做完之后，取消订阅。无论这个流是击键流、HTTP 响应流还是定时器，对这些值进行监听和停止监听的接口都是一样的。

由于这些优点，可观察对象在 Angular 中得到广泛使用，也同样建议应用开发者好好使用它。

### how
作为发布者，你创建一个 Observable 的实例，其中定义了一个订阅者（subscriber）函数。 当有消费者调用 subscribe() 方法时，这个函数就会执行。 订阅者函数用于定义“如何获取或生成那些要发布的值或消息”。

要执行所创建的可观察对象，并开始从中接收通知，你就要调用它的 subscribe() 方法，并传入一个观察者（observer）。 这是一个 JavaScript 对象，它定义了你收到的这些消息的处理器（handler）。 subscribe() 调用会返回一个 Subscription 对象，该对象具有一个 unsubscribe() 方法。 当调用该方法时，你就会停止接收通知。

## pipe (Operators 操作符)
### what
简而言之，就是可以与当前的 let 操作符一起使用的函数。无论名称起的是否合适，这就是它的由来。基本上来说，pipeable 操作符可以是任何函数，但是它需要返回签名为 <T, R>(source: Observable<T>) => Observable<R> 的函数。

现在 Observable 中有一个内置的 pipe 方法 (Observable.prototype.pipe)，它可以用类似于之前的链式调用的方式来组合操作符 (如下所示)。

There is also a pipe utility function at rxjs/util/pipe that can be used to build reusable pipeable operators from other pipeable operators.

在 rxjs/util/pipe 中还有一个名为 pipe 的工具函数，它可用于构建基于其他 pipeable 操作符的可复用的 pipeable 操作符。

### why
打补丁的操作符主要是为了链式调用，但它存在如下问题:

- 任何导入了补丁操作符的库都会导致该库的所有消费者的 Observable.prototype 增大，这会创建一种依赖上的盲区。如果此库移除了某个操作符的导入，这会在无形之中破坏其他所有人的使用。使用 pipeable 操作符的话，你必须在每个用到它们的页面中都导入你所需要用到的操作符。

- 通过打补丁的方式将操作符挂在原型上是无法通过像 rollup 或 webpack 这样的工具进行“摇树优化” ( tree-shakeable ) 。而 pipeable 操作符只是直接从模块中提取的函数而已。

- 对于在应用中导入的未使用过的操作符，任何类型的构建工具或 lint 规则都无法可靠地检测出它们。例如，比如你导入了 scan，但后来不再使用了，但它仍会被添加到打包后的文件中。使用 pipeable 操作符的话，如果你不再使用它的简化，lint 规则可以帮你检测到。

- 函数组合 ( functional composition )很棒。创建自定义操作符也变得非常简单，它们就像 rxjs 中的其他所有操作符一样。你不再需要扩展 Observable 或重写 lift 。

``` js
import { range } from 'rxjs/observable/range';
import { map, filter, scan } from 'rxjs/operators';

const source$ = range(0, 10);

source$.pipe(
  filter(x => x % 2 === 0),
  map(x => x + x),
  scan((acc, x) => acc + x, 0)
)
.subscribe(x => console.log(x))
```

## filter (Operators 操作符)
发出符合给定条件的值

![](/img/js/rxjs_filter.png)

- 示例 1: 过滤出偶数
``` js
// RxJS v6+
import { from } from 'rxjs';
import { filter } from 'rxjs/operators';

// 发出 (1,2,3,4,5)
const source = from([1, 2, 3, 4, 5]);
// 过滤掉奇数
const example = source.pipe(filter(num => num % 2 === 0));
// 输出: "Even number: 2", "Even number: 4"
const subscribe = example.subscribe(val => console.log(`Even number: ${val}`));
```

- 示例 2: 基于属性过滤对象
``` js
// RxJS v6+
import { from } from 'rxjs';
import { filter } from 'rxjs/operators';

// 发出 ({name: 'Joe', age: 31}, {name: 'Bob', age:25})
const source = from([{ name: 'Joe', age: 31 }, { name: 'Bob', age: 25 }]);
// 过滤掉年龄小于30岁的人
const example = source.pipe(filter(person => person.age >= 30));
// 输出: "Over 30: Joe"
const subscribe = example.subscribe(val => console.log(`Over 30: ${val.name}`));
```


## instanceof
instanceof 左操作数是一个类，右操作数是标识对象的类。如果左侧的对象是右侧类的实例，则返回true.而js中对象的类是通过初始化它们的构造函数来定义的。即instanceof的右操作数应当是一个函数。所有的对象都是object的实例。如果左操作数不是对象，则返回false,如果右操作数不是函数，则抛出typeError。

instanceof 运算符是用来测试一个对象是否在其原型链原型构造函数的属性。其语法是object instanceof constructor

instanceof 操作符用来比较两个操作数的构造函数。只有在比较自定义的对象时才有意义。 如果用来比较内置类型，将会和 typeof 操作符 一样用处不大。

``` js
function Foo() {}
function Bar() {}
Bar.prototype = new Foo();

new Bar() instanceof Bar; // true
new Bar() instanceof Foo; // true

// 如果仅仅设置 Bar.prototype 为函数 Foo 本身，而不是 Foo 构造函数的一个实例
Bar.prototype = Foo;
new Bar() instanceof Foo; // false
```

[typeof 和 instanceOf的区别](https://segmentfault.com/a/1190000000730982)


## pairwise (Operators 操作符)
pairwise<T>(): OperatorFunction<T, [T, T]>

将连续发射对成组在一起，并以两个值的数组形式发射它们。

![](./img/js/rxjs_pairwise.png)
