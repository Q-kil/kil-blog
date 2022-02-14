---
title: JavaScript
date: 2020-03-22 15:19:52
categories:
- JavaScript
tags:
- JavaScript
---

# 基础知识
## 基本数据类型
primitive
7种
string，number，bigint，boolean，null，undefined，symbol

## 应用类型
Object 类型、Array 类型、Date 类型、RegExp 类型、Function 类型 等

## 冻结对象
Object.freeze(obj);

## 运算符
&& 逻辑与
& 按位与

## 获取元素上的属性值
返回元素上一个指定的属性值。如果指定的属性不存在，则返回  null 或 "" （空字符串）
let attribute = element.getAttribute(attributeName);

## 函数自执行
IIFE（立即调用函数表达式）
```js
(function(){
  console.log('1')
})()
```

## 定时器
setInterval
interval: 间隔
setTimeout
timeout：超时
## 函数参数
``` js
console.log(arguments.length);
for (var i = 0; i < arguments.length; i++) {
  console.log('arg', arguments[i]);
}
```

## 函数回调
``` js
$('.facebook').click(function(){
  facebookHandle(fbLogin);
})

function fbLogin(token) {
  console.log('fb token', token);
  var fbLoginApi = 'account/third_signin';
  var parame = '{"third_token": "' + token + '","third_type":"facebook"}';

  xhrCommon('post', fbLoginApi, false, parame, function success(data){
    store.set('user', data);
    alertHandle('success', 'Login Success');
    authtokenCallback();
  }, function error(err){
    alertHandle('error', 'Login Error:'+ err.msg);
  })
}
```

## iframe
### 调用父级dom方法
window.parent.parentFn();

### 向子级发数据
frameEle.contentWindow.postMessage(message, '*');

### 向父级发数据
window.parent.postMessage(message, '*');

### 监听发来的事件
window.addEventListener('message', function(e) {
  const data = JSON.parse(e.data);
  // Where does the message come from
  const channel = data.channel;
});

## 阻止事件
### a 标签跳转
1、e.preventDefault();
2、href="javascript:void(0);"
## location
location.reload()  //刷新页面
## Math
取整 四舍五入
Math.round(67.55);   //68

向下取整
console.log(Math.floor(45.84334));//45

向上取整
console.log(Math.ceil(5.4443));//6

随机数0-1
console.log(Math.random());//0-----1之间

## userAgent
 navigator.userAgent;

## 作用域
作用域（Scope）	-
window/global Scope	全局作用域
function Scope	函数作用域
Block Scope	块作用域（ES6）
eval Scope	eval作用域 【eval() 函数会将传入的字符串当做 JavaScript 代码进行执行】

### 作用域链
变量作用域的查找是一个扩散过程，就像各个环节相扣的链条（"变量提升"一直向上找），逐次递进，这就是“作用域链”的由来。

## 点击事件
```js
<h1 onclick="test()">click</h1>
function test() {
  console.log('test');
}
```

``` js
window.addEventListener('click', () => console.log('Clicked!'));
document.getElementById('ele').addEventListener('click', () => console.log('Clicked!'));
```
第三参数
可选。布尔值，指定事件是否在捕获或冒泡阶段执行。

可能值:
true - 事件句柄在捕获阶段执行
false - 默认。事件句柄在冒泡阶段执行

options 可选
一个指定有关 listener 属性的可选参数对象。可用的选项如下：
capture:  Boolean，表示 listener 会在该类型的事件捕获阶段传播到该 EventTarget 时触发。
once:  Boolean，表示 listener 在添加之后最多只调用一次。如果是 true， listener 会在其被调用之后自动移除。

### 执行两次问题
``` js
document.getElementById("click").addEventListener("click", test, false);
function test(e) {
  e.stopPropagation(); // 防止冒泡
  console.log('click');
}
```

### 遮罩弹框
``` html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Document</title>
  <style>
    .mask{position: fixed;width: 100%;height: 100%;top: 0;left: 0;background: rgba(0,0,0,0.5);}

    .warn{width: 80%;overflow: hidden;position: absolute;top: 50%;left: 0;right: 0;margin:auto;border-radius: 8px;background-color: #fff;transform: translateY(-50%);-webkit-transform: translateY(-50%);}

    .warn .title{width: 100%;height: 50px;line-height: 57px;text-align: center;font-size: 18px;}

    .warn .content{margin: 0 auto;font-size: 14px;line-height: 20px;text-align: center;padding-left: 21px;padding-right: 21px;padding-bottom: 24px;}

    .warn .i_know{border-top: 1px solid #eee;width: 100%;height:46px;color: #4691ee;text-align: center;font-size: 16px;line-height: 46px;}

    .box {
      height: 4000px;
    }
  </style>
</head>
<body>
  <div class="box">sdfjslfslfjslf</div>
  <div class="mask">
    <div class="warn">
        <div class="title">提示</div>
        <div class="content">即将推出，敬请期待</div>
        <div class="i_know">我知道了</div>
    </div>
  </div>

  <script>
    const mask = document.getElementsByClassName('mask')[0];
    mask.addEventListener('click', (e) => {
      console.log('mask', e);
      console.log('e.target', e.target, mask);
      
      if (e.target === mask) {
        console.log('ele');
      }
    })

    const warn = document.getElementsByClassName('warn')[0];
    warn.addEventListener('click', (e) => {
      event.stopPropagation()
      event.cancelBubble = true
      console.log('warn');
    })
  </script>
</body>
</html>

```

## 操作css
``` js
// 在单个语句中设置多个样式
elt.style.cssText = "color: blue; border: 1px solid black";
// 或者
elt.setAttribute("style", "color:red; border: 1px solid blue;");

// 设置特定样式，同时保持其他内联样式值不变
elt.style.color = "blue";

// IE 不支持 ele.style = ``; 只能使用
elt.style.color = "blue";
```

### 获取元素的样式
``` js
var div = document.querySelector("div");
console.log(div.style.width);  //什么也没有
var sty = div.currentStyle || window.getComputedStyle(div,null);
console.log(sty.width);   //100px;
```

### remove class
```js
const divs = document.getElementsByTagName('div');
for (let i = 0; i < divs.length; i++) {
  divs[i].classList.remove('light');
}
document.getElementsByClassName('green')[0].classList.add('light');
```

## 操作html
``` js
let vertionEle = `<div style="position:fixed; left: 2px; bottom: 2px; color: #fff;"><span>游戏版本：${appVersion.appVersion}</span><br><span>内核版本：${gamecoreVersion}</span></div>`
ele.insertAdjacentHTML('beforeend', vertionEle);
```

```
位置名称的可视化
<!-- beforebegin -->
<p>
  <!-- afterbegin -->
  foo
  <!-- beforeend -->
</p>
<!-- afterend -->
```

## setTimeout & setInterval
setTimeout()方法设置一个定时器，该定时器在定时器到期后执行一个函数或指定的一段代码。
setInterval() 方法重复调用一个函数或执行一个代码段，在每次调用之间具有固定的时间延迟。

## 对象添加健值对
object[key] = value

### 对象长度
Object.getOwnPropertyNames(op_def.AvatarSlot).length

## url 解码
decodeURIComponent('https%3A%2F%2Fosd-alpha.tooqing.com');

## 当前 url
window.location.href

## document
滚动条位置：
document.documentElement.scrollTop

距离父级高度：
document.getElementById('onlinePlayerCount').offsetTop

## window
窗口高度：
window.innerHeight

alert( window.innerWidth ); // 整个窗口的宽度
alert( document.documentElement.clientWidth ); // 减去滚动条宽度后的窗口宽度

### addEventListener
```js
function setLaunch() {
  var e = document.getElementById("launch");
  if (e) {
    console.log('e', e, e.clientWidth, e.clientHeight);
    
      var n = document.documentElement
        , o = e.clientWidth
        , r = e.clientHeight
        , t = n.getBoundingClientRect()
        , i = t.width
        , a = t.height;
      o > i && (e.style.width = i + "px"),
      r != a && (e.style.height = a + "px")

      console.log('t', t);
      console.log('&&', o > i && (e.style.width = i + "px"));
      
  }
}
window.setLaunch = setLaunch,
window.onload = function(e) {
  window.setLaunch(),
  // window.addEventListener("resize", window.setLaunch)
  window.addEventListener("resize",debounce(function(e){
    console.log("end of resizing");
    window.setLaunch();
  }));
}
function debounce(func){
  var timer;
  return function(event){
    if(timer) clearTimeout(timer);
    timer = setTimeout(func,1000,event);
  };
}
```

## String
### slice()、substr()、substring() 区别
操作长度：
substr(start, length?)
start: 要抽取的子串的起始下标; 如果是负数，那么该参数声明从字符串的尾部开始算起的位置。也就是说，-1 指字符串中最后一个字符，
length：可选。子串中的字符数。必须是数值。如果省略了该参数，那么返回从 stringObject 的开始位置到结尾的字串。

``` js
let code = random.substr(-1, 4);
console.log('code', code); // 5

console.log('12345'.substr(-4, 4)); // 2345

public static generateSmsCode(len = 4): string {
  const random = Math.random().toString();
  const code = random.substr(-len, len);
  return code;
}
```

注：MDA 它并非JavaScript核心语言的一部分，未来将可能会被移除掉。如果可以的话，使用 substring() 替代它.

操作索引
slice(start,end?)
start: 要抽取的片断的起始下标。如果是负数，则该参数规定的是从字符串的尾部开始算起的位置。也就是说，-1 指字符串的最后一个字符，-2 指倒数第二个字符，以此类推。
end: 紧接着要抽取的片段的结尾的下标。若未指定此参数，则要提取的子串包括 start 到原字符串结尾的字符串。如果该参数是负数，那么它规定的是从字符串的尾部开始算起的位置。

substring(start, end?)
start: 必需。一个非负的整数
end: 选填。不含尾

```js
alert("abc".substr(1,2)); // returns "bc"
alert("abc".substring(1,2)); // returns "b"
```

### indexOf()、match()、search()区别
操作索引，返回下标
indexOf
search: 检索字符串中子字符串，或检索与正则表达式匹配的子字符串
``` js
str.search(/DEF/) // 4
```

正则表达式操作，返回值
``` js
str = '1 abc 2 def 3';
str.match(/\d+/g) // ["1", "2", "3"]
```

## 宽高
### 网页全文的高度和宽度
获取的是body中的 内容 的高度，不会受到body本身的高度影响
如果body给定了固定高度/宽度 ，获取的依然是body里面内容的高度
``` js
document.body.scrollHeight    //文档高度 body中内容的高度
document.body.scrollWidth     //文档宽度 **body中内容的宽度**
```

受body高度影响
``` js
document.body.clientHeight
document.body.clientWidth
```

### 屏幕的高度和宽度（屏幕像素）
获取整个屏幕的高\宽度
这是一个固定值
``` js
window.screen.height    //屏幕高度
window.screen.width     //屏幕宽度
```

### 获取屏幕可工作区域的高度和宽度（去掉状态栏）
只去除了上面的状态栏，打开控制台不受影响
这是一个固定值，不受浏览器窗口大小而改变
``` js
window.screen.availHeight    //可视区域去除状态栏高度
window.screen.availWidth    //可视区域去除状态栏宽度（和上面的值一样）
```

### 网页可见区域的高度和宽度
``` js
window.innerHeight
window.innerWidth     //没有去除滚动条的宽度

document.documentElement.clientHeight
document.documentElement.clientWidth    //去除滚动条的宽度
```

## document
document.documentElement与document.body
document代表的是整个文档(对于一个网页来说包括整个网页结构)，document.documentElement是整个文档节点树的根节点，在网页中即html标签；
document.body是整个文档DOM节点树里的body节点，网页中即为body标签元素。

### Element.clientHeight

### execCommand
当一个HTML文档切换到设计模式时，document暴露 execCommand 方法，该方法允许运行命令来操纵可编辑内容区域的元素。
bool = document.execCommand(aCommandName, aShowDefaultUI, aValueArgument)
返回值
一个 Boolean ，如果是 false 则表示操作不被支持或未被启用。
copy
拷贝当前选中内容到剪贴板。启用这个功能的条件因浏览器不同而不同，而且不同时期，其启用条件也不尽相同。使用之前请检查浏览器兼容表，以确定是否可用。

## Number
格式化数字，使整数部分每三位加一个逗号
```js
const num = 23333,
num.toLocaleString(); // 23,333

const num = 2333333;
num.toLocaleString('zh', { style: 'currency', currency: 'CNY' });  
'¥2,333,333.00'

const num = 2333333;
num.toLocaleString('zh', { style: 'currency', currency: 'USD' });  
'US$2,333,333.00'
```
## element
### 设置属性
Element.setAttribute()

## 操作类
Element.classList 是一个只读属性，返回一个元素的类属性的实时 DOMTokenList 集合。
但是你可以使用 add() 和 remove() 方法修改它。
``` js
const div = document.createElement('div');
div.className = 'foo';

// 初始状态：<div class="foo"></div>
console.log(div.outerHTML);

// 使用 classList API 移除、添加类值
div.classList.remove("foo");
div.classList.add("anotherclass");

// <div class="anotherclass"></div>
console.log(div.outerHTML);
```

## 网络
``` js
window.addEventListener("load", function() {
  this_.networkStatus = navigator.onLine ? "online" : "offline";

  window.addEventListener("online",  networkStatus);
  window.addEventListener("offline", networkStatus);

  function networkStatus(event) {
    this_.networkStatus = navigator.onLine ? "online" : "offline";
  }
});
```

## 时间日期
yyyy-MM-dd HH:mm:ss
年-月-日 时:分:秒
大写是为了区分“ 月”与“ 分”

顺便说下HH为什么大写，是为了区分 12小时制与 24小时制。
小写的h是12小时制，大写的H是24小时制。

时间戳
new Date().getTime()
Date.now()

某一天
new Date('2021-04-01T03:24:00');

### moment
毫秒
moment().valueOf() 

#### UTC
moment.utc().format();
"2021-04-09T12:29:31Z"

moment.utc(1617971728931).format();
"2021-04-09T12:35:28Z"

### 一天的开始和结束
方法一
``` js
let zero = new Date(new Date(result[0]).toLocaleDateString()).getTime();
console.log('00:00', zero);
let end = new Date(new Date(result[1]).toLocaleDateString()).getTime() + 24 * 60 * 60 * 1000 - 1;
console.log('59:59', end);
```

方法二
``` js
var now = new Date();
now.setHours(00, 00, 00, 0);
console.log(now.getTime());

let e = new Date('2021-04-01T03:24:00');
e.setHours(23, 59, 59, 999);
console.log('e', e.getTime());
```

方法三
``` js
export function DayStart(date) {
  const weeHours = moment(date).startOf('day').valueOf();
  console.log('weeHours', weeHours);
  return weeHours;
}

export function DayEnd(data) {
  const end = moment(data).endOf('day').valueOf();
  console.log('end', end);
  return end;
}
```


## 位运算
### 二进制或运算符
二进制或运算符（|）逐位比较两个运算子，两个二进制位之中只要有一个为1，就返回1，否则返回0。
``` js
0 | 3 // 3
```

上面代码中，0和3的二进制形式分别是00和11，所以进行二进制或运算会得到11（即3）。
位运算只对整数有效，遇到小数时，会将小数部分舍去，只保留整数部分。所以，将一个小数与0进行二进制或运算，等同于对该数去除小数部分，即取整数位。
``` js
2.9 | 0 // 2
-2.9 | 0 // -2
```

需要注意的是，这种取整方法不适用超过32位整数最大值2147483647的数。
``` js
2147483649.4 | 0;
// -2147483647
```

### 左移运算符
左移运算符（<<）表示将一个数的二进制值向左移动指定的位数，尾部补0，即乘以2的指定次方。向左移动的时候，最高位的符号位是一起移动的。
``` js
// 4 的二进制形式为100，
// 左移一位为1000（即十进制的8）
// 相当于乘以2的1次方
4 << 1
// 8

-4 << 1
// -8
```

如果左移0位，就相当于将该数值转为32位整数，等同于取整，对于正数和负数都有效。
``` js
13.5 << 0
// 13

-13.5 << 0
// -13
```

### 或运算符
&

## Base64
``` js
let encodedData = window.btoa("Hello, world"); // 编码
let decodedData = window.atob(encodedData);    // 解码
```

## while语句
一个 while 语句只要指定的条件求值为真（true）就会一直执行它的语句块。一个 while 语句看起来像这样：
```js
async function go() {
  while(true) {
    green();
    await sleep(1000);
    yellow();
    await sleep(300);
    red();
    await sleep(200);
  }
}
```

### do while
do...while 语句创建一个执行指定语句的循环，直到condition值为 false。在执行statement 后检测condition，所以指定的statement至少执行一次。
do
   statement
while (condition);

## Array
Array.prototype.fill()
fill() 方法用一个固定值填充一个数组中从起始索引到终止索引内的全部元素。不包括终止索引。
arr.fill(value[, start[, end]])
value
用来填充数组元素的值。
start 可选
起始索引，默认值为0。
end 可选
终止索引，默认值为 this.length。

### from
对一个类似数组或可迭代对象创建一个新的，浅拷贝的数组实例。
``` js
// 从String生成数组
Array.from('foo');
// ['f', 'o', 'o']

// 从Set生成数组
Array.from(new Set(['foo', 'bar']))
// ['foo', 'bar']

// 从Map生成数组
const map = new Map([[1, 2], [2,4]])
Array.from(map);
// [[1,2], [2,4]]
```

### map
Array map()

### 删除
头部
shift()

尾部
pop()

中间
splice(索引，长度)
第三个参数 可以添加元素
改变原数组

### join
join() 方法将一个数组（或一个类数组对象）的所有元素连接成一个字符串并返回这个字符串.
``` js
const elements = ['Fire', 'Air', 'Water'];

console.log(elements.join());
// expected output: "Fire,Air,Water"
```


## 
本地离线存储 localStorage 长期存储数据，浏览器关闭后数据不丢失;
会话存储 sessionStorage 的数据在浏览器关闭后自动删除;

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
### for or
#### 跳过本次循环
``` js
const array = [1, 2, 3, 4, 5];

for (const item of array) {
  if(item == 3) continue;
  console.log('item: ', item);
}
item:  1
item:  2
item:  4
item:  5
```

#### 终止循环
``` js
const array = [1, 2, 3, 4, 5];

for (const item of array) {
  if(item == 3) return; // break
  console.log('item: ', item);
}
```

### forEach
``` js
array.forEach(item => {
  if(item == 3) break;//continue //SyntaxError: Illegal break statement
  console.log('item: ', item);
});
```

``` js
array.forEach(item => {
  if(item == 3) return;
  console.log('item: ', item);
});
item:  1
item:  2
item:  4
item:  5
```

## reduce
reduce() 方法对数组中的每个元素执行一个由您提供的reducer函数(升序执行)，将其结果汇总为单个返回值。
场景：累计器, 计算数组里的总值。

参数：
- callback(返回的值，当前值)
- initialValue 第一次调用callback函数时的第一个参数值

``` js
const array = [{label: 1, value: 1}, {label: 2, value: 2}, {label: 3, value: 3}, {label: 4, value: 4}];
const acc = array.reduce((pre, cur, index) => {
  console.log('pre', pre, cur, index);
  if (index === 1) {
    return pre.value + cur.value;
  } else {
    return pre + cur.value;
  }
});
console.log('acc', acc); // 10
```

## 模块规范
https://juejin.cn/post/6844903744518389768
背景：开发 UI 层通用组件，这样项目组就不需要重复造轮子。其中有一个高频使用的组件就是 dialog.js
`<script src="dialog.js"></script>`
会产生两个问题：命名冲突和文件依赖

### AMD
第二行math.add(2, 3)，在第一行require('math')之后运行，因此必须等math.js加载完成。也就是说，如果加载时间很长，整个应用就会停在那里等。
这对服务器端不是一个问题，因为所有的模块都存放在本地硬盘，可以同步加载完成，等待时间就是硬盘的读取时间。但是，对于浏览器，这却是一个大问题，因为模块都放在服务器端，等待时间取决于网速的快慢，可能要等很长时间，浏览器处于"假死"状态。
因此，浏览器端的模块，不能采用"同步加载"（synchronous），只能采用"异步加载"（asynchronous）。这就是AMD规范诞生的背景。

Asynchronous Module Definition
异步模块定义

AMD模块定义的方法非常清晰，不会污染全局环境，能够清楚地显示依赖关系

require([module], callback);


``` js
// a.js
define(function (){
  return {
    a:'hello world'
  }
});
// b.js
require(['./a.js'], function (moduleA){
    console.log(moduleA.a); // 打印出：hello world
});
```


### commonJS
2009年，美国程序员Ryan Dahl创造了node.js项目，将javascript语言用于服务器端编程。
这标志"Javascript模块化编程"正式诞生

服务器环境
``` js
// a.js
// 相当于这里还有一行：var exports = module.exports;代码
exports.a = 'Hello world';  // 相当于：module.exports.a = 'Hello world';

// b.js
var moduleA = require('./a.js');
console.log(moduleA.a);     // 打印出hello world
```

### ES6
ES6 在语言标准的层面上，实现了模块功能，而且实现得相当简单，完全可以取代 CommonJS 和 AMD 规范，成为浏览器和服务器通用的模块解决方案。
``` js
/** 定义模块 math.js **/
var basicNum = 0;
var add = function (a, b) {
    return a + b;
};
export { basicNum, add };
/** 引用模块 **/
import { basicNum, add } from './math';
function test(ele) {
    ele.textContent = add(99 + basicNum);
}
```

### UMD
umd是AMD和CommonJS的糅合
AMD 浏览器第一的原则发展 异步加载模块。
CommonJS 模块以服务器第一原则发展，选择同步加载，它的模块无需包装(unwrapped modules)。
这迫使人们又想出另一个更通用的模式UMD （Universal Module Definition）。希望解决跨平台的解决方案。
UMD先判断是否支持Node.js的模块（exports）是否存在，存在则使用Node.js模块模式。
在判断是否支持AMD（define是否存在），存在则使用AMD方式加载模块。

## 防抖&节流
[字节跳动] 鼠标滚动的时候，会触发很多次事件，如何解决的？
这里选择的方法应该是节流，可以拓展讲到防抖和节流，防抖是指连续触发的时候只会执行一次，停止触发 N 秒后才能继续执行，而节流是指如果你持续触发事件，每隔一段时间，只执行一次事件。
像防止按钮多次点击就用防抖，像是监听滚动事件就用节流，

rxjs：debounceTime(200), 舍弃掉在两次输出之间小于指定时间的发出值


# work
## 顶级域名 一级域名
``` js
document.domain
```

# 数组
## 排序 sort()
默认排序顺序是在将元素转换为字符串，然后比较它们的UTF-16代码单元值序列。
修改元素组。
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

### arr.sort([compareFunction])
compareFunction 可选
用来指定按某种顺序进行排列的函数。如果省略，元素按照转换为的字符串的各个字符的Unicode位点进行排序。
firstEl
第一个用于比较的元素。
secondEl
第二个用于比较的元素。

如果指明了 compareFunction ，那么数组会按照调用该函数的返回值排序。即 a 和 b 是两个将要被比较的元素：
如果 compareFunction(a, b) 小于 0 ，那么 a 会被排列到 b 之前；
如果 compareFunction(a, b) 等于 0 ， a 和 b 的相对位置不变。备注： ECMAScript 标准并不保证这一行为，而且也不是所有浏览器都会遵守（例如 Mozilla 在 2003 年之前的版本）；
如果 compareFunction(a, b) 大于 0 ， b 会被排列到 a 之前。
compareFunction(a, b) 必须总是对相同的输入返回相同的比较结果，否则排序的结果将是不确定的。

## 删除没元素
``` js
this.materials.splice(this.materials.findIndex(item => {
  if (item.part === part.part) {
    id = item.id;
    return true;
  }
}), 1);
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

# 时间
PST
Pacific Standard Time 太平洋标准时间 


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
#### 定义
函数嵌套函数，内层函数引用了外层函数作用域下的变量，并且内层函数在全局环境下可访问，进而形成闭包。
`{% asset_img closure.png %}`

``` js
function numGenerator() {
  let num = 1;
  num++;
  return () => {
    console.log(num);
    
  }
}
var getNum = numGenerator();
getNum();
```
#### 基本原理
在正常情况下外界是无法访问函数内部变量的，函数执行之后，上下文即被销毁。但是在函数（外层）中，如果我们返回了另一个函数，且这个返回的函数使用了函数（外层）内的变量，那么外界便能够通过
这个返回的函数获取原函数（外层）内部的变量值。

### 内存管理
基本数据类型按照值大小保存在栈空间中，占有固定大小的内存空间。
引用类型保存在堆空间中，内存空间大小并不固定，需按引用情况来进行访问。

### DOM引用
数据结构中存储 DOM 节点

原理
垃圾收集器会定期（周期性）找出那些不在继续使用的变量，然后释放其内存。

# 严格模式
"use strict";
这种模式使得Javascript在更严格的条件下运行。
"严格模式"体现了Javascript更合理、更安全、更严谨的发展方向

## 为什么
- 消除js语法的一些不合理、不严谨之处，减少怪异行为
- 消除代码运行不安全之处，保证代码运行安全
- 提高编译效率，增加运行速度
- 为js下一版本铺垫

## 严格模式中的变化
严格模式同时改变了语法及运行时行为。

### 将过失错误转成异常
- 无法再意外创建全局变量
- 静默失败的赋值操作抛出异常 
  给不可写属性赋值，给只读属性赋值，给不可扩展对象的新属性赋值
- 试图删除不可删除的属性时会抛出异常
- 对象的所有属性名唯一
- 函数的参数名唯一
- 禁止八进制数字语法
- 禁止设置 原始数据 的属性

### 简化变量的使用
- 禁用with
- eval不再为上层范围引入新变量
- 禁止删除声明变量




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

- js分为函数对象和普通对象，每个对象都有__proto__属性，但是只有函数对象才有prototype属性
- Object、Function都是js内置的函数, 类似的还有我们常用到的Array、RegExp、Date、Boolean、Number、String

- 属性__proto__是一个对象，它有两个属性，constructor和__proto__；
- 原型对象prototype有一个默认的constructor属性，用于记录实例是由哪个构造函数创建；


# call&apply&bind
## apply、call
在 javascript 中，call 和 apply 都是为了改变某个函数运行时的上下文（context）而存在的，换句话说，就是为了改变函数体内部 this 的指向。

JavaScript 的一大特点是，函数存在「定义时上下文」和「运行时上下文」以及「上下文是可以改变的」这样的概念。
例子：
``` js
function fruits() {}

fruits.prototype = {
    color: "red",
    say: function() {
        console.log("My color is " + this.color);
    }
}

var apple = new fruits;
apple.say();    //My color is red
```

但是如果我们有一个对象banana= {color : "yellow"} ,我们不想对它重新定义 say 方法，那么我们可以通过 call 或 apply 用 apple 的 say 方法：
``` js
banana = {
    color: "yellow"
}
apple.say.call(banana);     //My color is yellow
apple.say.apply(banana);    //My color is yellow
```

## apply、call 的区别
对于 apply、call 二者而言，作用完全一样，只是接受参数的方式不太一样。例如，有一个函数定义如下：
``` js
var func = function(arg1, arg2) {

};
```
调用
``` js
func.call(this, arg1, arg2);
func.apply(this, [arg1, arg2])
```
其中 this 是你想指定的上下文，他可以是任何一个 JavaScript 对象(JavaScript 中一切皆对象)，call 需要把参数按顺序传递进去，而 apply 则是把参数放在数组里。　　

通过 Array.prototype.slice.call 转化为标准数组

接下来的要求是给每一个 log 消息添加一个"(app)"的前辍，比如：
``` js
log("hello world");    //(app)hello world
```

``` js
function log(){
  var args = Array.prototype.slice.call(arguments);
  args.unshift('(app)');

  console.log.apply(console, args);
};
```

## bind
bind 返回一个新的函数，绑定了新的this，不会执行。
说完了 apply 和 call ，再来说说bind。bind() 方法与 apply 和 call 很相似，也是可以改变函数体内 this 的指向。

MDN的解释是：bind()方法会创建一个新函数，称为绑定函数，当调用这个绑定函数时，绑定函数会以创建它时传入 bind()方法的第一个参数作为 this，传入 bind() 方法的第二个以及以后的参数加上绑定函数运行时本身的参数按照顺序作为原函数的参数来调用原函数。

直接来看看具体如何使用，在常见的单体模式中，通常我们会使用 _this , that , self 等保存 this ，这样我们可以在改变了上下文之后继续引用到它。 像这样：
``` js
var foo = {W
    bar : 1,
    eventBind: function(){
        var _this = this;
        $('.someClass').on('click',function(event) {
            /* Act on the event */
            console.log(_this.bar);     //1
        });
    }
}
```

由于 Javascript 特有的机制，上下文环境在 eventBind:function(){ } 过渡到 $('.someClass').on('click',function(event) { }) 发生了改变，上述使用变量保存 this 这些方式都是有用的，也没有什么问题。当然使用 bind() 可以更加优雅的解决这个问题：
``` js
var foo = {
    bar : 1,
    eventBind: function(){
        $('.someClass').on('click',function(event) {
            /* Act on the event */
            console.log(this.bar);      //1
        }.bind(this));
    }
}
```

### 语法
function.bind(thisArg[, arg1[, arg2[, ...]]])

## call&apply&bind比较
``` js
var obj = {
    x: 81,
};

var foo = {
    getX: function() {
        return this.x;
    }
}

console.log(foo.getX.bind(obj)());  //81
console.log(foo.getX.call(obj));    //81
console.log(foo.getX.apply(obj));   //81
```
当你希望改变上下文环境之后并非立即执行，而是回调执行的时候，使用 bind() 方法。而 apply/call 则会立即执行函数。

总结：
apply 、 call 、bind 三者都是用来改变函数的this对象的指向的；
apply 、 call 、bind 三者第一个参数都是this要指向的对象，也就是想指定的上下文；
apply 、 call 、bind 三者都可以利用后续参数传参；
bind 是返回对应函数，便于稍后调用；apply 、call 则是立即调用 。

# 其他
## 模块化
[CommonJS,AMD,CMD,ES6](https://juejin.im/post/5aaa37c8f265da23945f365c)

## 判断
``` js
*ngIf="type.type !== 'handheld' || account.role === 0">
```

## 递归
``` js
const data = {
    name: "A",
    nodes: [
        { name: "B", nodes: [{ name: "F" }] },
        { name: "C" },
        {
            name: "D",
            nodes: [
                { name: "G" },
                { name: "H" },
                { name: "I", nodes: [{ name: "J" }, { name: "K" }] }
            ]
        },
        { name: "E" }
    ]
};
function makeTree(roots) {
    function makeNode(node) {
        const $div = $("<div>").text(node.name || "");
        const $li = $("<li>").append($div);
        if (node.nodes && node.nodes.length) {
            $li.append(makeNodeList(node.nodes));
        }
        return $li;
    }
    function makeNodeList(nodes) {
        return nodes
            .map(child => makeNode(child))
            .reduce(($ul, $li) => {
            return $ul.append($li);
        }, $("<ul>"));
    }
    return makeNodeList(roots);
}

makeTree([data]).appendTo($("#tree"));


// 注意参数支持传入单根或多根，
// 如果像 travelWidely 那样只支持多根（单根是特例）也是可以的
function travelDeeply(roots: INode | INode[]) {
    function printNode(node: INode) {
        console.log(`${node.name} ${node.nodes && node.nodes.length || ""}`);
        if (node.nodes && node.nodes.length) {
            // 依次对子节点递归调用 printNode
            node.nodes.forEach(child => printNode(child));
        }
    }

    // 这里 printNode 和 node => printNode(node) 等价
    (Array.isArray(roots) ? roots : [roots]).forEach(printNode);
}

// 开始遍历
travelDeeply(data);
```

## 换行
\r - Carriage Return
\n - Line Feed

\r\n is often used in preference to \n as it displays properly on both unix and Windows.

# JSON
js的一个子集

## JSON Schema
当前后端使用 JSON 通信的时候，双方需要验证 JSON 的数据格式，比如验证 array 的长度、number 的大小、甚至于类似 object 中有某两个属性不能并存等等要求。当然这些规则都可以使用代码进行验证，但是这样写起来太繁琐了，所以为了描述并校验 JSON 的格式，JSON Schema 诞生了。

### 简单例子
``` json
{
  "$schema": "http://json-schema.org/draft-04/schema#", // 版本控制
  "$id": "http://example.com/root.json", // 定义模式的URI
  "type": "object",
  "properties": {
    "name":  { 
      "type": "string",
      "description": "......"
    },
    "email": { "type": "string" },
    "age": {
      "type": "integer",
      "minimum": 0,
      "exclusiveMinimum": false,
    },
    "telephone": {
      "type": "string",
      "pattern": "^(\\([0-9]{3}\\))?[0-9]{3}-[0-9]{4}$"
    },
    "price": {
      "description": "The price of the product",
      "type": "number",
      "exclusiveMinimum": 0
    }
  },
	"required": ["name", "email"],
  "additionalProperties": false
}
```

## 格式



# utils

## 随机字符串
Math.random().toString(36).slice(-10)
## 比较版本号
``` js
    var compareVersion = function(version1, version2) {
    const arrayA = version1.split('.');
    const arrayB = version2.split('.');

    let pointer = 0;
    while (pointer < arrayA.length && pointer < arrayB.length) {
        const res = arrayA[pointer] - arrayB[pointer];
        if (res === 0) {
            pointer++;
        } else {
            return res > 0 ? 1 : -1;
        }
    }
    console.log('next');
    
    // 若arrayA仍有小版本号
    while (pointer < arrayA.length) {
        if (+arrayA[pointer] > 0) {
            return 1;
        } else {
            pointer++;
        }
    }
    // 若arrayB仍有小版本号
    while (pointer < arrayB.length) {
        if (+arrayB[pointer] > 0) {
            return -1;
        } else {
            pointer++;
        }
    }
    // 版本号完全相同
    return 0;
};

let version = compareVersion('0.0.3', '0.0.1');
console.log('version', version);
```

# AJAX
## 概述
AJAX即“Asynchronous JavaScript and XML”（异步的JavaScript与XML技术），指的是一套综合了多项技术的浏览器端网页开发技术。
意思就是用JavaScript执行异步网络请求。
AJAX请求是异步执行的，也就是说，要通过回调函数获得响应。

## 应用
运用XHTML+CSS来表达信息；
运用JavaScript操作DOM（Document Object Model）来运行动态效果；
运用XML和XSLT操作资料
运用XMLHttpRequest或新的Fetch API与网页服务器进行异步资料交换；
注意：AJAX与Flash、Silverlight和Java Applet等RIA技术是有区分的。

## 例子
``` js
function success(text) {
    var textarea = document.getElementById('test-response-text');
    textarea.value = text;
}

function fail(code) {
    var textarea = document.getElementById('test-response-text');
    textarea.value = 'Error code: ' + code;
}

var xhr = new XMLHttpRequest(); // 新建XMLHttpRequest对象

xhr.onreadystatechange = function () { // 状态发生变化时，函数被回调
    // this  指代 xhr
    // readyState: https://developer.mozilla.org/zh-CN/docs/Web/API/XMLHttpRequest/readyState
    if (xhr.readyState === 4) { //下载操作已完成。
        // 判断响应结果:
        if (xhr.status === 200) {
            // 成功，通过responseText拿到响应的文本:
            return success(xhr.responseText);
        } else {
            // 失败，根据响应码判断失败原因:
            return fail(xhr.status);
        }
    } else {
        // HTTP请求还在继续...
    }
}

// 发送请求:
xhr.open('GET', '/api/categories');
xhr.send();

alert('请求已发送，请等待响应...');
```

# Document
## querySelector()
指定选择器或选择器组匹配的第一个 HTMLElement对象。找不到匹配项，返回null

## querySelectorAll()
返回与指定的选择器组匹配的文档中的元素列表, 返回的对象是 NodeList。

注意：
因为返回的是一个 NodeList 需要转换为 Array
[...document.querySelectorAll('*')]

# Element
## appendChild(aChild)
aChild: 必须是节点

## append(Node or String)

## innerHTML
获取元素的内容 或 替换元素的内容

## insertAdjacentHTML
element.insertAdjacentHTML(position, text);
position
- 'beforebegin'：元素自身的前面。
- 'afterbegin'：插入元素内部的第一个子节点之前。
- 'beforeend'：插入元素内部的最后一个子节点之后。
- 'afterend'：元素自身的后面。

text
是要被解析为HTML或XML元素，并插入到DOM树中的 DOMString。

# API
## history
DOM window 对象通过 history 对象提供了对浏览器的会话历史的访问。允许你在用户浏览历史中向前和向后跳转。
可以改变浏览器的当前地址和历史，却又不会触发服务端页面请求的技术。

## 后退
window.history.back();
window.history.go(-1);

## 前进
window.history.forward();
window.history.go(1);


# 技巧
## 数组下标每次加1
currentAdIndex = -1;
this.currentAdIndex = (this.currentAdIndex + 1) % this.ads.length;
# 问题
## parse
Unhandled Promise Rejection: SyntaxError: JSON Parse error: Unexpected identifier "object"
答：
Most probably your response is already a JavaScript object and it not required to be parsed.
Remove the line var json = JSON.parse(response); and your code should work.

# 性能优化
## 调试
chrome -> performance
JS Heap 和 Nodes 线随着时间线一直在上升，并没有被垃圾回收机制回收。
## 内存泄露
### element节点移除，但element变量还在
删除element节点的时候，把element变量设置为null
``` js
var element = document.getElementById("element");

function remove() {
  element.parentNode.removeChild(element)
  element = null // 该节点占用的内存会被释放
}
```

### 删除的节点，监听的事件还在
还需要 removeEventListener

### setInterval 要清理
调用 clearInterval

### 闭包

# 数组去重
## ES6 Set (ES6中常用)
## 双层for，外层循环，内层比较，然后splice去重（ES5中常用）
``` js
function unique(array) {
  for (let i = 0; i < array.length; i++) {
    for (let j = i + 1; j < array.length; j++) {
      if (array[i] == array[j]) {
        array.splice(j, 1);
        j--;
      }
    }
  }
  return array
}
let ar = [1, 2, 2, 4];
console.log('ar', unique(ar));
```

## indexOf去重
``` js
function unique(arr) {
  let newArr = [];
  for(let i = 0; i < arr.length; i++) {
    if (arr.indexOf(arr[i]) === -1) {
      newArr.push(arr[i])
    }
  }
  return newArr
}
```

## sort()排序后，相邻比较

## includes，数组是否含有某个值

