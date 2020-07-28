---
title: Error
date: 2020-04-10 19:03:42
categories:
- Error
tags:
- Error
---


# Error
`{% asset_img get_parame.png %}`

原因：方法上面没有属性 getUserToken().parame


# webpack
## sass-loader
Module build failed: TypeError: this.getResolve is not a function
sass-loader的版本过高导致的编译错误，当前最高版本是8.x，需要退回到7.3.1


# Angular
ERROR in Could not resolve module ./pages/suit/suit.module relative to app/app-routing.module.ts

# vue
## 操作DOM
### error
vue是虚拟DOM，不应该使用操作原生DOM的方式
``` js
document.getElementById('pixi').appendChild(app.view);
```

### right
``` html
<div ref="pixi"></div>
```
``` js
(this.$refs['pixi'] as HTMLElement).appendChild(app.view);
```

`ref` 被用来给元素或子组件注册引用信息。引用信息将会注册在父组件的 `$refs` 对象上。如果在普通的 DOM 元素上使用，引用指向的就是 DOM 元素；如果用在子组件上，引用就指向组件实例

`as` 类型断言
语法：
- 值 as 类型
- <类型>值

`<>` 语法在 ts 中也表示范型；建议在使用类型断言时，统一使用 `值 as 类型`

延伸：
语法：CAST (expression AS data_type)

expression：任何有效的SQServer表达式。
AS：用于分隔两个参数，在AS之前的是要处理的数据，在AS之后是要转换的数据类型。
data_type：目标系统所提供的数据类型，包括bigint和sql_variant，不能使用用户定义的数据类型。

# JS
Uncaught SyntaxError: Invalid or unexpected token
未捕获的SyntaxError：无效或意外的令牌