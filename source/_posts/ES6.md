---
title: ES6
date: 2020-03-21 12:30:39
categories:
- ECMAScript
tags:
- ES6
---

# 介绍
## 历史
### ECMAScript 和 JavaScript 关系
+ ECMA是标准，JS是实现
  - 类似于HTML5是标准，IE10、Chrome、FF都是实现
  - 换句话说，将来也能有其他XXXScript来实现ECMA
+ ECMAScript简称**ECMA或ES**
+ 目前版本
  - 低级浏览器主要支持ES 3.1
  - 高级浏览器正在从ES 5过渡到ES 6

### 历史版本
| 时间 | ECMA | 解释 |
| -- | -- | -------- |
| 2015.06 | ES 6.0 | ES 6.0预计发布正式版；JavaScript.next开始指向ES 7.0 |

### JS历史
JS是艾奇仅仅10天时间设计出的原型
语音必有迭代的过程，它总有一些自己的问题

Java是世界上最流行的语言，没有之一。原因是：非常严谨、死板
开心的语言，不严谨，无法开发大型项目

## 兼容性
ES6 推出来的时候，各路浏览器已经出来了，没法兼容所有的浏览器
[**ES6兼容性查看表**](http://kangax.github.io/compat-table/es6/)

ES6(ES2015)兼容情况
IE10+、Chrome、FireFox、

编译、转换（bable）
+ 在线转换
+ 提前编译

# 目录
## 变量
## 函数
## 数组
## 字符串
## 面向对象
## Promise
## generator
## 模块化

# 变量
## ES5 变量问题
1、可以重复声明：
```js
var a = 1;
var a = 5;
``` 

2、无法限制修改
PI = 3.1415926

3、没有块级作用域

## 新增变量声明
let   不能重复声明，变量-可以修改，块级作用域
const  不能重复声明，常量-不能修改，块级作用域

### 块级作用域有什么
``` js
<input type="button" value="按钮1">
<input type="button" value="按钮2">
<input type="button" value="按钮3">

window.onload = function() {
  var aBtn = document.getElementsByTagName('input');

  for(var i =0; i<aBtn.length; i++) {
    aBtn[i].onclick=function() {
      alert(i); // 点击三个按钮都是 3
    }
  }

  // 以前解决这个问题，创建一个封闭空间，封在里面; 利用函数作为作用域,垫一层
  // TODO: 不理解去看原生JS教程
  (function (i) {
    aBtn[i].onclick=function() {
      alert(i); // 点击三个按钮 0 , 1 , 2
    }
  })(i);

  // 现在用ES6
  for(let i =0; i<aBtn.length; i++) {
    aBtn[i].onclick=function() {
      alert(i); // 点击三个按钮 0 , 1 , 2
    }
  }
}
```

## 函数
### 新增箭头函数
借鉴python lambda
``` js
function 名字() {

}

() => {

}
```

1、如果只有一个参数，（）可以省
2、如果只有一个return，{} 可以省

``` js
let show = function() {

};

let show = () => {

}
```

#### 圆括号可以省略
``` js
let show = a => {
  return a*2
}
```

#### 花括号可以省略
``` js
let show = a=> a*2
```

### 函数参数
#### 参数扩展/展开
收集剩余的参数
``` js
function show(a, b, ...args) {
}
show(3, 5, 3, 6, 7);
```
+ *Rest Parameter必须是最后一个













