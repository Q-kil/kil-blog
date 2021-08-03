---
title: rxjs
date: 2020-05-19 15:34:59
categories:
- JavaScript
tags:
- rxjs
---

# base
响应式编程是使用异步数据流进行编程。

# Observable
单播，对于每个订阅者，都只有一个独立的 Observable execution 与之对应
``` js
import * as Rx from "rxjs";

const observable = Rx.Observable.create((observer) => {
  observer.next(Math.random());
});

// 订阅者甲
observable.subscribe((data) => {
  console.log(data); // 0.24957144215097515 (随机数)
});

// 订阅者乙
observable.subscribe((data) => {
  console.log(data); // 0.004617340049055896 (随机数)
});
```

# Subject
主题没有值。
多播，多个订阅者收到相同的数据
Subject 也可比作事件发射器（EventEmitter），其中注册了多个事件监听器。
``` js
import * as Rx from "rxjs";

const subject = new Rx.Subject();

// 订阅者 1
subject.subscribe((data) => {
  console.log(data); // 0.24957144215097515 (随机数)
});

// 订阅者 2
subject.subscribe((data) => {
  console.log(data); // 0.24957144215097515 (随机数)
});

subject.next(Math.random());
```

# BehaviorSubject
可观察主题
BehaviorSubject包含一个值。订阅时，它会立即发出值.
BehaviourSubject将返回订阅的初始值或当前值
BehaviorSubject 是 Subject 的变体之一。BehaviorSubject 的特性就是它会存储“当前”的值。这意味着你始终可以直接拿到 BehaviorSubject 最后一次发出的值。
有两种方法可以拿到 BehaviorSubject “当前”的值：访问其 .value 属性或者直接订阅。如果你选择了订阅，那么 BehaviorSubject 将直接给订阅者发送当前存储的值，无论这个值有多么“久远”。请看下面的例子：

``` js
import * as Rx from "rxjs";

const subject = new Rx.BehaviorSubject(Math.random());

// 订阅者 A
subject.subscribe((data) => {
  console.log('Subscriber A:', data);
});

subject.next(Math.random());

// 订阅者 B
subject.subscribe((data) => {
  console.log('Subscriber B:', data);
});

subject.next(Math.random());

console.log(subject.value)

// 输出
// Subscriber A: 0.24957144215097515
// Subscriber A: 0.8751123892486292
// Subscriber B: 0.8751123892486292
// Subscriber A: 0.1901322109907977
// Subscriber B: 0.1901322109907977
// 0.1901322109907977
```
链接：https://juejin.im/post/5cb89bb551882533017e7eed

应用参考例子：https://www.it-swarm.dev/zh/rxjs/subject%E5%92%8Cbehaviorsubject%E6%9C%89%E4%BB%80%E4%B9%88%E5%8C%BA%E5%88%AB%EF%BC%9F/831140095/

## asObservable
Creates a new Observable with this Subject as the source. You can do this to create customize Observer-side logic of the Subject and conceal it from code that uses the Observable.

``` ts
commonMsgObserver = this.commonMsg$.asObservable();
```

# 取消订阅
从此用RxJS订阅的时候，时刻都不忘调用unsubscribe()以防内存泄漏。对于结束Observable，释放内存的方式有三种方式：

第一种，Observable完成值的发送，执行Observable.onComplete()

第二种，Observable发生错误，执行Observable.OnError()

第三种，订阅者主动取消订阅，执行subscription.unsubscribe()

对于Observable.onComplete()和Observable.OnError()，RxJS自身会处理这两种情况，所以不需要在代码里再手动取消订阅释放内存。对于第三种方式，Observable还在源源不断的发送值，订阅者想主动取消订阅，那就需要在代码里调用unsubscribe()取消订阅释放内存。

# distinct 
它能帮我们把相同值的资料滤掉只留一笔，RxJS 里的 distinct 也是相同的作用

# Pipeable 操作符
pipe 是 Observable 的一部分，不需要导入，并且它可以替代现有的 let 操作符。
现在 Observable 中有一个内置的 pipe 方法 (Observable.prototype.pipe)，它可以用类似于之前的链式调用的方式来组合操作符 (如下所示)。
你只需在 'rxjs/operators' (注意是复数！) 中便能提取出所需要的任何操作符。还推荐直接导入所需的 Observable 创建操作符，如下面的 range 所示:

## finalize
当 Observable 完成或报错时调用函数
``` ts
this.userService
.signIn(account, password)
.pipe(
  finalize(() => {
    this.isSubmitting = false;
  })
)
```

## delay
根据给定时间延迟发出值。
``` ts
this.tempMsg$.pipe(delay(200), take(null));
```

## take
在完成前发出N个值(N由参数决定)。
``` ts
// 发出 1,2,3,4,5
const source = of(1, 2, 3, 4, 5);
// 取第一个发出的值然后完成
const example = source.pipe(take(1));
```

## combineLatest
函数签名: combineLatest(observables: ...Observable, project: function): Observable
combineLatest 直到每个 observable 都至少发出一个值后才会发出初始值。
