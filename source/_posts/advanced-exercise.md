---
title: advanced-exercise
date: 2020-07-30 22:58:37
categories:
- Front-End
tags:
- Front-End
---

# UTF8 编码
## 方法一
string -> utf8
character -> unicode编码：
str.codePointAt();

unicode -> binary
unicode.toString(2);

二进制补位
```
0xxxxxxx

110xxxxx 10xxxxxx

1110xxxx 10xxxxxx 10xxxxxx

11110xxx 10xxxxxx 10xxxxxx 10xxxxxx

111110xx 10xxxxxx 10xxxxxx 10xxxxxx 10xxxxxx

1111110x 10xxxxxx 10xxxxxx 10xxxxxx 10xxxxxx 10xxxxxx
```

我们先举个简单的例子。把英文字母"A"转为UTF8编码。
1、“A”的charCode为65
2、65位于0-127的区间，所以“A”占一个字节
3、UTF8中一个字节的补位为0xxxxxxx，x表示的是空位，是用来补位的。
4、将65转为二进制得到1000001
5、将1000001按照从前到后的顺序，依次补到1xxxxxxx的空位中，得到01000001
6、将11000001转为字符串，得到"A"
7、最终，"A"为UTF8编码之后“A”

通过这个小例子，我们是否再次验证了UTF-8是Unicode的超集！
```js
// "中"的charCode为20013
var code = 20013;
code.toString(2); 
// => 100111000101101 等同于 01001110 00101101
```
然后，我们按照上面“A”补位的方法，来给"中"补位。
将01001110 00101101按照从前到后的顺序依此补位到1110xxxx 10xxxxxx 10xxxxxx上.得到11100100 10111000 10101101.

通过上面的步骤，我们得到了"中"的三个UTF8字节，11100100 10111000 10101101。
我们将每个字节转为16进制，得到0xE4 0xB8 0xAD;
那么这个0xE4 0xB8 0xAD就是我们最终得到的UTF8编码了。

## 验证
我们使用nodejs的buffer来验证一下是否正确。
``` js
var buffer = new Buffer('中'); 
console.log(buffer.length); // => 3
console.log(buffer); // => <Buffer e4 b8 ad>
// 最终得到三个字节 0xe4 0xb8 0xad
```

## 方法二
{% label ib_yellow@只会转义非英文字符 %}
``` js
var str = '中';
 
var code = encodeURI(str);
 
console.log(code); // => %E4%B8%AD

// 下面我们将%E4%B8%AD转为一个number数组。
var codeList = code.split('%');
 
codeList = codeList.map(item => parseInt(item,16));
 
console.log(codeList); // => [228, 184, 173]
```

## 二进制转换十六进制
``` js
var x = '11100100';
x = parseInt(x, 2); //2进制转10进制
x = x.toString(16); //10进制转16进制
```

## 十进制转2进制
``` js
let b = 4;
b.toString(2);
"100"
```

## 解析回来
用decodeURI/decodeURIComponent就可以了。
``` js
var codeList = [228, 184, 173];
 
var code = codeList.map(item => '%'+item.toString(16)).join('');
 
decodeURI(code); // => 中
```
[参考链接](https://blog.csdn.net/themagickeyjianan/article/details/80725606)

# 浏览器
## 不准使用正则表达式，纯粹用 JavaScript 的逻辑实现：在一个字符串中，找到字符“ab”
``` js
function findAB(str) {
  for(let i = 0; i < str.length; i++){
    console.log('i', i, str[i]);
    if (str[i] === 'a' && str[i + 1] === 'b') {
      console.log('ab', str[i] + str[i + 1]);
    }
  }
}
findAB('sdsdab');
```
{% label ib_yellow@注意，作业错误，此处应为：str.length - 1 %}
助教点评：
最后一个字符就是i = 4
str[i + 1]取得是什么？

### 优秀作业
``` js
function find(str) {
  let step = 0;
  for(let c of str) { // of 作用在str上就是把每个字符取出来
    if (c=== 'a') {
      step = 1;
    } else if (step === 1 && c === 'b'){
      return true;
    } else {
      step = 0;
    }
  }
  return false;
}
```

## 状态机查找abcabx
``` js
let status = false;
function foundB(c) {
  if (c === 'c' && !status) {
      status = true;
      return foundC;
  } else if (c === 'x' && status) {
      return end
  } else
      return start(c)
}
```
助教点评：不正确 不符合状态机没有副作用的特性
状态机不应该用全局变量
只能用输入参数
Q：程序不是 最好不要重复写相同的方法嘛
A：这就是状态机 你可能需要再理解和感受一下

# HTML
## 子节点翻转
``` js
function reversalChildren(nodeEle) {
  let children = Array.prototype.slice.call(nodeEle.childNodes);
  
  // for(let child of children) {
  //   nodeEle.removeChild(child);
  // }

  nodeEle.innerHTML = '';

  console.log('nodeEle', nodeEle);
  
  children.reverse();

  for(let child of children) {
    nodeEle.appendChild(child);
  }
}

// 三次重排
function reversalChildren2(nodeEle) {
  let l = nodeEle.childNodes.length;
  while(l-- > 0) {
    nodeEle.appendChild(nodeEle.childNodes[l]);
  }
}

// 两次重排 框架使用次方法
function reversalChildren3(nodeEle) {
  let range = new Range();
  range.selectNodeContents(nodeEle);

  let fragment = range.extractContents();
  let l = fragment.childNodes.length;
  while(l-- > 0) {
    fragment.appendChild(fragment.childNodes[l]);
  }
  nodeEle.appendChild(fragment);
}
```