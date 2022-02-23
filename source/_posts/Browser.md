---
title: Browser
date: 2020-06-23 17:23:24
categories:
- Browser
tags:
- Browser
---

# 回流与重绘
`{% asset_img dom-tree.png %}`

## 渲染过程
（1）解析HTML文件，构建 DOM Tree
（2）解析CSS，构建 CSSOM Tree(CSS规则树)
（3）将 DOM Tree 和 CSSOM Tree合并，构建Render tree(渲染树)
（4）reflow(回流)：根据Render tree进行节点信息计算（Layout）
（5）repaint(重绘)：根据计算好的信息绘制整个页面（Painting）
理论上，每一次的dom更改或者css几何属性更改，都会引起一次浏览器的重排/重绘过程，而如果是css的非几何属性更改，则只会引起重绘过程。所以说
回流一定会引起重绘，而重绘不一定会引起回流。

## 回流 reflow
当render tree中的一部分(或全部)因为元素的规模尺寸，布局，隐藏等改变而需要重新构建。这就称为回流(reflow)。
每个页面至少需要一次回流，就是在页面第一次加载的时候，这时候是一定会发生回流的，因为要构建render tree。在回流的时候，浏览器会使渲染树中受到影响的部分失效，并重新构造这部分渲染树，完成回流后，浏览器会重新绘制受影响的部分到屏幕中，该过程成为重绘。

- 页面首次渲染
- 浏览器窗口大小发生改变
- 元素尺寸或位置发生改变
- 元素内容变化（文字数量或图片大小等等）
- 元素字体大小变化
- 添加或者删除可见的DOM元素
- 激活CSS伪类（例如：:hover）
- 查询某些属性或调用某些方法

一些常用且会导致回流的属性和方法：

- clientWidth、clientHeight、clientTop、clientLeft
- offsetWidth、offsetHeight、offsetTop、offsetLeft
- scrollWidth、scrollHeight、scrollTop、scrollLeft
- scrollIntoView()、scrollIntoViewIfNeeded()
- getComputedStyle()
- getBoundingClientRect()
- scrollTo()

## 重绘 repaint
当render tree中的一些元素需要更新属性，而这些属性只是影响元素的外观，风格，而不会影响布局的，比如background-color。则就叫称为重绘。

## 如何避免
CSS

避免使用table布局。
尽可能在DOM树的最末端改变class。
避免设置多层内联样式。
将动画效果应用到position属性为absolute或fixed的元素上。
避免使用CSS表达式（例如：calc()）。

JavaScript

避免频繁操作样式，最好一次性重写style属性，或者将样式列表定义为class并一次性更改class属性。
避免频繁操作DOM，创建一个documentFragment，在它上面应用所有DOM操作，最后再把它添加到文档中。
也可以先为元素设置display: none，操作结束后再把它显示出来。因为在display属性为none的元素上进行的DOM操作不会引发回流和重绘。
避免频繁读取会引发回流/重绘的属性，如果确实需要多次使用，就用一个变量缓存起来。
对具有复杂动画的元素使用绝对定位，使它脱离文档流，否则会引起父元素及后续元素频繁回流。

# IE
## 跨域请求
IE8、IE9
XDomainRequest

CORS 规范（即 XMLHttpRequest Level 2）是 HTML5 时才制定出，IE 早期版本（IE 10.4 以前）并不支持。
不过 IE 自己有一个私有对象 XDomainRequest，可以用它，不过好像最低只支持到 IE 8。更古早的 IE 6/7 你只能用 jsonp 或是后端配代理转发来处理跨域请求了。

# Chrome
## 清除缓存，强制刷新网站
`{ asset_img web_clear_cache.png }`

