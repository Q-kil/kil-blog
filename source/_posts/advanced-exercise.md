---
title: advanced-exercise
date: 2020-07-30 22:58:37
tags:
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

## 解析回来
用decodeURI/decodeURIComponent就可以了。
``` js
var codeList = [228, 184, 173];
 
var code = codeList.map(item => '%'+item.toString(16)).join('');
 
decodeURI(code); // => 中
```
[参考链接](https://blog.csdn.net/themagickeyjianan/article/details/80725606)