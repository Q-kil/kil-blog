---
title: js-error
date: 2020-02-26 17:18:43
categories:
- JavaScript
tags:
- js-error
---

# js
## [object]
``` js
console.log(`$_model_cart:${carts}`);
```
输出：`[object object]`

### [object Object]
console.log('Update is loaded stringify:' + JSON.stringify(data));

## const 声明
const sprite;
Uncaught SyntaxError: Missing initializer in const declaration
使用const关键字声明常量。需要一个常量的初始化程序；也就是说，您必须在声明它的同一条语句中指定它的值（这很有意义，因为以后无法更改）

## 语法错误
``` js
4.toString(2);
Uncaught Syntax Error: Invalid or unexpected token
```
