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
``` html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Document</title>
  <script crossorigin src="https://unpkg.com/react@16/umd/react.development.js"></script>
  <script crossorigin src="https://unpkg.com/react-dom@16/umd/react-dom.development.js"></script>
  <script src="https://unpkg.com/babel-standalone@6/babel.min.js"></script>
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
</html>
```

React 基于组件开发的框架
组件怎么写的呢，以class形式存在
`作为一个组件，应该有些最基本的功能。比如说能渲染出来，有一些状态，有生命周期`

### 继承React组件
继承的意义：不用一切从0开始。
对于任何一个有追求的class来说 ， 都得有constructor，`constructor中最重要的一点是继承父级属性`

React组件特别方便，一旦写完，不需要实例化，不需要new它，你只需要像一个标签一样使用它。
``` html
<script type="text/babel">
  class Test extends React.Component {
    constructor(...args) { //参数扩展
      super(...args);
    }

    // 对于React里面的组件来说，它什么方法都可以没有，必须得有render()
    // 不加render()方法会报错
    render() {
      // 不加return 也会报错
      // 所有组件都是可见的
      return <span>123</span>;
    }
  }

  window.onload = function() {
    let oDiv = document.getElementById('div1');

    ReactDOM.render(
      // <span>123</span>,
      <Test></Test>,
      oDiv
    );
  }
</script>
```  

### 组件传值
``` html
<script type="text/babel">
  class Item extends React.Component {
    constructor(...args) {
      super(...args);
    }

    render() {
      return <li>{this.props.str}</li>;
    }
  }

  window.onload = function() {
    let oDiv = document.getElementById('div1');

    ReactDOM.render(
      // <span>123</span>,
      <ul>
        // 组件长的像标签
        <Item str="abc"></Item>
        <Item str="ddd"></Item>
      </ul>,
      oDiv
    );
  }
</script>
``` 

### 组件嵌套组件
``` html
<script type="text/babel">
class Item extends React.Component {
    constructor(...args) {
      super(...args);
    }

    render() {
      return <li>{this.props.str}</li>;
    }
  }

  // 组件里面套组件
  class List extends React.Component{
    constructor(...args) {
      super(...args);
    }

    render() {
      return <ul>
        <Item str="abc"></Item>
        <Item str="ddd"></Item>
      </ul>
    }
  }

  window.onload = function() {
    let oDiv = document.getElementById('div1');

    ReactDOM.render(
      <List></List>,
      oDiv
    );
  }
</script>
```

### 组件嵌套组件-传值
``` html
  <script type="text/babel">
  class Item extends React.Component {
    constructor(...args) {
      super(...args);
    }

    render() {
      return <li>{this.props.str}</li>;
    }
  }

  // 组件里面套组件
  class List extends React.Component{
    constructor(...args) {
      super(...args);
    }

    render() {
      console.log('arr', this.props.arr);

      let aItems = [];
      // for (let i =0; i<this.props.arr.length; i++) {
      //   aItems.push(<Item str={this.props.arr[uniqueId]}></Item>);
      // }

      this.props.arr.forEach((element, index) => {
        console.log('element', element);
        aItems.push(<Item str={element} key={index}></Item>);
      });
      
      return <ul>
        {aItems}
      </ul>
    }
  }

  window.onload = function() {
    let oDiv = document.getElementById('div1');

    ReactDOM.render(
      // react 传值两种方式，一种是字符串，一种是表达式
      <List arr={['abc', 'ers', 'ids']}></List>,
      oDiv
    );
  }
</script>
```

### 组件嵌套组件-优化-映射
`['abc', 'ers', 'ids'] => [<Item str='abc' key=''></Item>, <Item str='ers' key=''></Item>, <Item str='ids' key=''></Item>]`

``` js
let aItems = this.props.arr.map(a => <Item str={a}></Item>)
```

### 组件嵌套组件-优化-终极
``` html
  <script type="text/babel">
  class Item extends React.Component {
    constructor(...args) {
      super(...args);
    }

    render() {
      return <li>{this.props.str}</li>;
    }
  }

  class List extends React.Component{
    constructor(...args) {
      super(...args);
    }

    render() {
      console.log('arr', this.props.arr);

      return <ul>
        {this.props.arr.map(a => <Item str={a} key={a}></Item>)}
      </ul>
    }
  }

  window.onload = function() {
    let oDiv = document.getElementById('div1');

    ReactDOM.render( 
      <List arr={['abc', 'ers', 'ids']}></List>,
      oDiv
    );
  }
</script>
```

# JSON
JavaScript的一个子集，现各语言已借鉴
## JSON对象
1、JSON.stringify
2、JSON.parse

## JSON的标准写法
1、只能用双引号
2、所有的名字都必须使用引号包起来

{a: 12, b: 5}        X
{"a": 12, "b": 5}    √ 

{a: 'abc', b: 5}     X
{"a": "abc", "b": 5} √

## JSON的简写
1、key 和 value (名字跟值) 一样的时候，可以只写一个
``` js
let a = 2;
let b = 5;

let json = {a: a, b: b, c: 55};

// 简写
let json = {a, b, c: 55};
```

2、json 里面有方法。函数可以少些 :function
``` js
let json = {
  a: 12,
  show() {
    alert(this.a);
  }
}
json.show();
```

# Promise
Promise - 承诺
异步请求

异步和同步是所有开发语言都有的事，硬件也有

ajax异步；如果不异步，那要等数据返回页面才能显示，那得疯了

异步：操作这间没啥关系，同时进行多个操作
同步：同时只能做一件事

异步
缺点：代码更复杂
同步
优点：代码简单

## 没有Promise时
异步：
``` js
axios.get('/list').then(list_data => {
  axios.get('/list/item').then(list_data => {
    // 回调地狱
  }) 
})
``` 

## Promise - 消除异步操作
用同步一样的方式，来书写异步代码

用法：
``` js
// 需要一个date，要new一个date
let oDate = new Date();

// 需要一个Array，要new一个Array
let arr = new Array();

// Promise 也一样，当需要Promise时，要new一个Promise对象
// 里面接收一个参数，是函数
let p = new Promise(function (resolve, reject) { // 函数接收两个参数：解决（成功），拒绝（失败）
  // 异步代码
});
```

### 结合jquery使用
``` js
let p = new Promise(function (resolve, reject) [
  $.ajax({
    url: 'arr.txt',
    dataType: 'json', // arr.txt 里面是一个数组，我希望你给我解析了，解析成json
    success(arr) { // 此处：JSON里面 function的简写
      resolve(arr);
    }
    err(err) {
      reject(err);
    }
  })
])

p.then(); //then 翻译汉语：然后嘞；说白了就是当p执行有结果，就会调用then

// 程序书写习惯养成：
p.then(function (){}, function (){}) // 第一个函数当成功的时候调用，第二个函数当失败的时候调用
```

### 两个Promise对象
``` js
let p1 = 
let p2 = 

// 无意义的写法,成了ajax
p1.then(){
  p2.then() {

  }
}

// Promise身上有一个all 方法
Promise.all([p1, p2]).then(function(results) { // arr是数组
  // 全部成功了
  // 接收
  let [res1, res2] = results; // 结构赋值
}, function() {
  // 至少一个失败了
})
```

### 封装一个方法
``` js
function createPromise(url) {
  return new Promise(function (resolve, reject) {
    $.ajax({
      // url: url,
      url, // 对于一个有追求的json来说，名字和值一样的话，留一个。
      dataType: 'json',
      success(arr) {
        resolve(arr);
      }
      err(err) {
        reject(err);
      }
    })
  })
}
```

### Promise 其他方法
Promise.race   竞速；允许失败，只要有一个成功的就可以


# generator
generat： 生成
generator:  生成器
普通函数，运行的话，一条道走到黑。（飞机）
generator函数，中间可以暂停。（出租车）

``` js
// 跟普通函数最大不同，就是有星号
function *show() { // 注意：不能连着写
  alert('a');

  yield; //放弃；暂时不往下执行

  alert('b');
}

let genObj = show();// 创建了一个generator对象出来
genObj.next();
genObj.next();
```

踹一脚，走一步

## yield
传参
``` js
genObj.next(10); // 无效的
genObj.next(55);
```

返回
``` js
yield 12;

// 就像切菜一样，最后需要return
return 55; // res2 value: 55
let res1 = gen.next();

console.log(res1); // {value: 12, done: false}

let res2 = gen.next(); 
console.log(res2); // {value: undefined, done: true}
```

`{% asset_img yield.png %}`

## 异步带逻辑
generator最大的好处是：当有了逻辑以后，非常方便
``` js
runner(function *() {
  let userData = yield $.ajax({url: 'getUserData', dataType: 'json});

  if (userData.type == 'vip') {
    let items = yield $.ajax({url: 'getVipItems', dataType: 'json'});
  } else {
    let items = yield $.ajax({url: 'getItems', dataType: 'json'})
  }
})
```

Promise: 一次读一堆
generator：逻辑性（对Promise进行了封装）

注意：
针对ES6中
generator yield
ES7中 推出
async await
好处：
1、不依赖于外部的 runner 了——统一、性能
2、可以用箭头函数