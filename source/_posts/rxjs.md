---
title: rxjs
date: 2020-05-19 15:34:59
categories:
- JavaScript
tags:
- rxjs
---

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
