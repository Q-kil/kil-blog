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

# 函数
## 新增箭头函数
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

### 圆括号可以省略
``` js
let show = a => {
  return a*2
}
```

### 花括号可以省略
``` js
let show = a=> a*2
```

## 函数参数
### 参数扩展/数组展开
1、收集剩余的参数
``` js
function show(a, b, ...args) {
}
show(3, 5, 3, 6, 7);
```
+ *Rest Parameter必须是最后一个

2、展开数组
   展开后的效果，跟直接把数组的内容写在这儿一样
``` js
let a = [1,2,3];
let b = [4,5,6];
let arr = [...a, ...b] // [1,2,3,4,5,6]
```

## 默认参数
``` js
function show(a, b=1, c=3){};
```

# 解构赋值
1、左右两边结构必须一样
2、右边必须是个东西
3、声明和赋值不能分开（必须在一句话里完成）
``` js
let arr = [1, 2, 3];
let a = arr[0];
let b = arr[1];

// 解构赋值
// 数组
let [a, b, c] = [1, 2, 3]

// 对象
let {a, b, c} = {a: 2, b: 3, c:4}
```

# 数组
## map 映射
一个对一个
``` js
let arr = [3, 4, 6];

let result = arr.map(item => item*2);
result // [6, 8, 12]

// 成绩
let score = [23, 34, 99, 22, 44];

let result = score.map(item => item>=60?'及格':'不及格');
score //[23, 34, 99, 22, 44]
result //[不及格，不及格，及格，不及格，不及格]
```

## reduce 汇总
一堆出来一个
求和，求平均数
``` js
let arr = [12, 68, 190, 390];

let result = arr.reduce(function (tmp, item, index) {
  if (index!=arr.length-1) {
    return tmp + item;
  } else {
    return (tmp + item)/arr.length;
  }
})
```

## filter 过滤器
``` js
let arr = [12, 5, 8, 99, 36];

let result = arr.filter(item => {
  if (item%3 == 0) {
    return true;
  } else {
    return false;
  }
})
result // 12, 99, 36

// 简写
let result = arr.filter(item => item%3 == 0);
```

## forEach 迭代
``` js
let arr = [4, 5, 6, 7];

arr.forEach((item, index) => {
  console.log(index + ':' + item);
})
```

# 字符串
## 多了两个新方法
`startsWith`
``` js
let str = 'htts://www.google.com';

if (str.startsWith('http://')) {
  alert('普通网址');
} else if(str.startsWith('htts://')) {
  alert('加密网址');
} else {
  alert('其他');
}
```

`endsWith`
``` js
let str = '1.txt';

if (str.endsWith('.txt')) {
  alert('文本文件');
} else if (str.endsWith('.jpg')) {
  alert('JPG图片');
} else {
  alert('其他');
}
```

## 字符串模板
` 反单引号
1、直接把变量塞到字符串里面  ${变量}
2、可以折行
``` js
let srt = '<div>\
  <h1>' + title + '</h1>\
  </div>';

let str2 = `<div>
  <h1>${titel}</h1>
  </div>`;  
```        

# 面向对象
## ES4, ES5 写法
1、类 和 构造函数 不分的...
2、类 散开了
``` js
function User(name, pass) {
  this.name = name;
  this.pass = pass;
}

User.prototype.showName = function() {
  alert(this.name);
}
User.prototype.showPass = function() {
  alert(this.pass);
}

var u1 = new User('kil', 123456);
u1.showName();
u2.showPass();
```

## ES6 写法
``` js
class User{
  constructor(name, pass) { // 构造函数 或着 构造器
    this.name = name;
    this.pass = pass;
  }

  showName() {  // 注意：此处写的是class，不是json 。json的话，showName： function(){}
    alert(this.name);
  }
  showPass() {
    alert(this.pass);
  }
}
```

1、`class`关键字，专门的构造器
2、class里面直接加方法

## 继承
归根到底，最有价值的
面向对象：我可以不断完善我的东西，增加功能
站在前人的肩膀上，才能走得越来越远。人类社会就是这么发展的。
继承一个已有的类，来扩展它的功能。

### ES4, ES5写法
``` js
function VipUser(name, pass, level) {
  User.call(this, name, pass);

  this.level = level;
}

VipUser.prototype = new User();
VipUser.prototype.constructor = VipUser;

VipUser.prototype.showLevel = function() {
  alert(this.level);
}

var v1 = new VipUser('kil', '123456', 3);
v1.showName();
v1.showPass();
V1.showLevel();
```

### ES6写法
``` js
class VipUser{
  constructor(name, pass, level) {
    super(name, pass);

    this.level = level;
  }

  showLevel() {
    alert(this.level);
  }
}
```

## 面向对象-实例
### 基本的React 实例
``` js
<script crossorigin src="https://unpkg.com/react@16/umd/react.development.js"></script>
  <script crossorigin src="https://unpkg.com/react-dom@16/umd/react-dom.development.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/babel-core/5.8.23/browser.min.js"></script>
  <script type="text/babel">
    window.onload = function() {
      let oDiv = document.getElementById('div1');

      ReactDOM.render(
        <span>123</span>,
        oDiv
      );
    }
</script>
</head>
<body>
  <div id="div1"></div>
</body>
```

React 基于组件开发的实例（以class存在）

### 继承React
继承的意义：不用从0开始。
对于一个有追求的class ， 都得有constructor





