---
title: JavaScript
date: 2020-03-22 15:19:52
categories:
- JavaScript
tags:
- JavaScript
---
# 基础知识
## 点击事件
``` js
window.addEventListener('click', () => console.log('Clicked!'));
document.getElementById('ele').addEventListener('click', () => console.log('Clicked!'));
```

## 操作css
``` js
// 在单个语句中设置多个样式
elt.style.cssText = "color: blue; border: 1px solid black";
// 或者
elt.setAttribute("style", "color:red; border: 1px solid blue;");

// 设置特定样式，同时保持其他内联样式值不变
elt.style.color = "blue";
```

## setTimeout & setInterval
setTimeout()方法设置一个定时器，该定时器在定时器到期后执行一个函数或指定的一段代码。
setInterval() 方法重复调用一个函数或执行一个代码段，在每次调用之间具有固定的时间延迟。

# 待掌握
## 对象拷贝
### 浅拷贝
Object.assign() 方法用于将所有可枚举属性的值从一个或多个源对象复制到目标对象。它将返回目标对象。
``` js
let obj = {
  a: 1,
  b: {
    c: 2,
  },
}
let newObj = Object.assign({}, obj);
console.log(newObj); // { a: 1, b: { c: 2} }

obj.a = 10;
console.log(obj); // { a: 10, b: { c: 2} }
console.log(newObj); // { a: 1, b: { c: 2} }

newObj.a = 20;
console.log(obj); // { a: 10, b: { c: 2} }
console.log(newObj); // { a: 20, b: { c: 2} }

newObj.b.c = 30;
console.log(obj); // { a: 10, b: { c: 30} }
console.log(newObj); // { a: 20, b: { c: 30} }

// 注意: newObj.b.c = 30; 为什么呢..
```
这就是 `Object.assign()` 的陷阱。`Object.assign` 只是浅拷贝。 `newObj.b` 和 `obj.b` 都引用同一个对象，没有单独拷贝，而是复制了对该对象的引用。任何对对象属性的更改都适用于使用该对象的所有引用。

### 深拷贝


## 汉字排序
``` js
function zhSort(arr) {
  return arr.sort((n, m) => n.localeCompare(m));
}
```

按照字母排序
``` js
function segSort(arr) {
  let letters = "*abcdefghjklmnopqrstwxyz".split(''),
      zh = "阿八嚓哒妸发旮哈讥咔垃痳拏噢妑七呥扨它穵夕丫帀".split('');

  let segs = [],
      curr;

  letters.forEach((v, i) => {
    curr = {letter: v, data:[]};
    arr.forEach(j => {
      if((!zh[i-1] || zh[i-1].localeCompare(j) <= 0) && j.localeCompare(zh[i]) == -1) {
        curr.data.push(j);
      }
    })
    if(curr.data.length) {
      segs.push(curr);
      curr.data.sort(function(a,b){
        return a.localeCompare(b);
      });
    }
  })
  return segs;
}
let segs = segSort(['白鸽', '麻雀','黑','大象', '狗', '猫','妈妈','马', "鸡",'瘦','胖']);
console.log('segs', segs);
```

## 循环
forEach 不能中断循环（使用break或者return）。

return 必须用在方法里面

## reduce
reduce() 方法对数组中的每个元素执行一个由您提供的reducer函数(升序执行)，将其结果汇总为单个返回值。
``` js
return this.products.reduce((sum, product) => {
  console.log('product', product);

  return sum + 1;
}, 0)
```

## 模块
### require时代
a.js
``` js
module.exports = {
  a: 1
}
```
b.js
``` js
var m = require('./a')

console.log(m.a);
```

# work
## 顶级域名 一级域名
``` js
document.domain
```

# 数组
## 排序 sort()
``` js
let arr = [12, 5, 8, 99, 33, 14];
arr.sort();
console.log('sort:', arr); // sort: [ 12, 14, 33, 5, 8, 99 ]

// 需要给一个比较函数
arr.sort(function(n1, n2) {
    return n1 - n2;
});
console.log('sort:', arr); // sort: [ 5, 8, 12, 14, 33, 99 ]
```

# 关键字
## this
`this` 是 JavaScript 语言的一个关键字。
它是函数运行时，在函数体内部自动生成的一个对象，只能在函数体内部使用。
``` js
function test() {
　this.x = 1;
}
```
上面代码中，函数test运行时，内部会自动有一个this对象可以使用。

那么，this的值是什么呢？

函数的不同使用场合，this有不同的值。总的来说，this就是函数运行时所在的环境对象。下面分四种情况，详细讨论this的用法。

### 情况一：纯粹的函数调用
这是函数的最通常用法，属于全局性调用，因此this就代表全局对象。请看下面这段代码，它的运行结果是1。
``` js
var x = 1;
function test() {
   console.log(this.x);
}
test();  // 1
```

### 情况二：作为对象方法的调用
函数还可以作为某个对象的方法调用，这时this就指这个上级对象。
``` js
function test() {
  console.log(this.x);
}

var obj = {};
obj.x = 1;
obj.m = test;

obj.m(); // 1
```

### 情况三 作为构造函数调用
所谓构造函数，就是通过这个函数，可以生成一个新对象。这时，this就指这个新对象。
``` js
function test() {
　this.x = 1;
}

var obj = new test();
obj.x // 1
```
运行结果为1。为了表明这时this不是全局对象，我们对代码做一些改变：
``` js
var x = 2;
function test() {
  this.x = 1;
}

var obj = new test();
x  // 2
```
运行结果为2，表明全局变量x的值根本没变。

### 情况四 apply 调用
apply()是函数的一个方法，作用是改变函数的调用对象。它的第一个参数就表示改变后的调用这个函数的对象。因此，这时this指的就是这第一个参数。
``` js
var x = 0;
function test() {
　console.log(this.x);
}

var obj = {};
obj.x = 1;
obj.m = test;
obj.m.apply() // 0
```
apply()的参数为空时，默认调用全局对象。因此，这时的运行结果为0，证明this指的是全局对象。

如果把最后一行代码修改为
``` js
obj.m.apply(obj); //1
```
运行结果就变成了1，证明了这时this代表的是对象obj。

### 箭头函数中的this
在浏览器中, window 对象同时也是全局对象：
``` js
var g = 'global'
const obj = {
    g: 'g',
    a: function() { console.log(this.g) },
    b: {
        c: () => { console.log(this.g) }
    }
}
obj.a()
obj.b.c()

console.log('ggg', window.g);
VM99:4 g
VM99:6 global
VM99:12 ggg global
```

``` js
const obj = {
    a: function() { console.log(this) },
    b: {
    	c: function() {console.log(this)}
	}
}
obj.a()  // 打出的是obj对象, 相当于obj.a.call(obj)
obj.b.c() //打出的是obj.b对象, 相当于obj.b.c.call(obj.b)

// 使用箭头函数
const obj = {
    a: function() { console.log(this) },
    b: {
    	c: () => {console.log(this)}
	}
}
obj.a()   //没有使用箭头函数打出的是obj
obj.b.c()  //打出的是window对象！！
```


# fix
## 华为 和 oppo 内置浏览器 无法显示导航条
``` js
scrollHandle() {
  if (document.documentElement.scrollTop) {
  // if (window.scrollY > 0) {
    this.scrollState = true;
  } else {
    this.scrollState = false;
  }
}
```

# 内存泄露
**内存泄漏（memory leak）**
不再用到的内存，没有及时释放。
**垃圾回收机制（garbage collector）**
JavaScript 的内存基元在变量（对象，字符串等等）创建时分配，然后在他们不再被使用时“自动释放”

工具检测：
chrome - preformance

## 垃圾回收机制——GC
JavaScript 具有自动垃圾回收机制（GC:Garbage Collecation），也就是说，执行环境会负责管理代码执行过程中使用的内存。

## 原因
### 全局变量
全局变量无法通过垃圾收集器收集。
要保证一旦完成使用就把他们赋值为 null 或重新赋值 。

### 忘记移除的定时器
处理程序及其依赖项都不会被收集，因为间隔处理需要先备停止（请记住，它仍然是活动的）

### 闭包
一旦为同一个父作用域内的闭包创建作用域，作用域将被共享。
两个闭包之间的整个共享范围，这阻止了它们的垃圾收集。

### DOM引用
数据结构中存储 DOM 节点

原理
垃圾收集器会定期（周期性）找出那些不在继续使用的变量，然后释放其内存。

# 严格模式
"use strict";
严格模式对正常的 JavaScript语义做了一些更改。
- 严格模式通过抛出错误来消除了一些原有静默错误。
- 严格模式修复了一些导致 JavaScript引擎难以执行优化的缺陷：有时候，相同的代码，严格模式可以比非严格模式下运行得更快。
- 严格模式禁用了在ECMAScript的未来版本中可能会定义的一些语法。

# 原型链
如果试图引用constructor1构造的实例instance1的某个属性p1:
- 首先会在instance1内部属性中找一遍;
- 接着会在instance1.__proto__(constructor1.prototype)中找一遍,而constructor1.prototype 实际上是instance2, 也就是说在instance2中寻找该属性p1;
- 如果instance2中还是没有,此时程序不会灰心,它会继续在instance2.__proto__(constructor2.prototype)中寻找...直至Object的原型对象

搜索轨迹: instance1--> instance2 --> constructor2.prototype…-->Object.prototype

这种搜索的轨迹,形似一条长链, 又因prototype在这个游戏规则中充当链接的作用,于是我们把这种实例与原型的链条称作 原型链 .

## 轻松理解原型链
原型链图
`{% asset_img proto.png %}`
