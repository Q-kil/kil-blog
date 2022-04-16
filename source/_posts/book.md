---
title: book
date: 2020-05-31 23:42:17
categories:
- book
tags:
- book
---

# 前端读书会
## 目的
阅读习惯，完整的去读一些书  
从简单 到 难

## Program
- [ ] CSS世界
- [ ] 精通CSS-高级Web标志解决方案
- [ ] 红宝书
- [ ] 小黄书上中（上：作用域、闭包。面试）
- [ ] JS忍者秘籍
- [ ] JS设计模式
- [ ] 重构-改善既有代码的设计
- [ ] 人月神话
- [ ] 高效前端
- [ ] 前端开发核心知识进阶
- [ ] vuejs设计与实现
- [ ]


## Society
学习，跟互联网、商业相关
- [ ] 如何阅读一本书
- [ ] REWORK （先进的商业模式，远程的工作方式）[追求增长转为追求质量]
- [ ] 暗时间
- [ ] 软技能2
- [ ] 
- [ ] 
- [ ] 



# Todo
### Program
- [ ] 程序员的自我修养
- [ ] 刻意练习 （从新手到大师）
- [ ] 数学之美

### Society
- [ ] 梵高先生
- [ ] 与神对话
- [ ] 极简美国史
- [ ] 文明之光
- [ ] 具体生活
- [ ] 软技能

大张伟
- [ ] 爱因斯坦的梦 （浪漫）


# Done
## Program
## Society
- [x] 活着


# Front-End
## Head First HTML 与 CSS
为什么要看这本书？
1. 豆瓣9.2 评分
2. 系统学一下HTML 和 CSS
3. 图文很经典

### 学习
1. 图片学习效率更高（89%效率提升）
2. 采用一种第一人称的交谈风格。提升40%（讲故事，非报告。通俗的语音。不要严肃。）
3. 如果真的想学，而且想学得更快、更深。（怎样专注起来，考虑自己怎么思考的，了解自己的学习方法）
4. 要让自己的大脑认为你学习的新东西确实很重要，对你的生活有很大影响。否则将陷入旷日持久的拉锯战中，虽然你想学新内容，但大脑却会竭尽全力地把它们拒之门外。

#### 怎么学
慢方法：
大量地重复。如果反反复复看同一个东西，即便再没有意思，你也能学会并记住。足够的反复，大脑会说：“尽管看上去好像不重要，不过，既然他这样一而再，再而三地看同一个东西，所以我假定这应该是重要的”
更快的方法：
尽一切可能让大脑活动起来，特别是开动大脑来完成不同类型的活动。
##### 如何让大脑活动起来
1. 图文（把图片放中间）。大脑：文字与图片的关系，会让更多的神经元“点火”。大脑：内容值得关注，很可能需要记下来
2. 交谈风格

##### 大脑就范
`{% asset_img on_your_marks.jpg %}`

### 建议
1、至少两种浏览器（了解不同浏览器之间的差异）

### 认识HTML
Web早已经成为全球通用的交流方式。更棒的是，你能参与其中。

标记就是尖括号括起来的词或字符，例如：<head>

元素 = 开始标记 + 内容 + 结束标记
一个元素：<h1> title </h1>

为什么结束标记有一个额外的‘/’
为了让你和浏览器知道某个特定内容在哪里结束。否则，结束标记看上去就和开始标记一样了。

<img src=".."> 简写标记

#000000 一个十六进制码

html 显示的是结构
### 深入了解超文本
好了，系好你的安全带，准备学习一些超文本吧。

href（hypertextreference 超文本引用）：告诉浏览器链接的目标文件

图像文件夹：images

'..' 读 dot dot

不同操作系统有不同文件分隔符，但是web只有一个通用分隔符‘/’

blockquote 标签：块引用
q 标签：行内引用

块元素独立特行，内联元素随波逐流。

设计一个页面时，一般先从较大的块开始（块元素），然后在完善页面时再加入内联元素。

轻松设计好布局，悠闲地喝着马提尼。

void 空元素，没有实际内容的元素: 【元素 = 开始 + 内容 + 结束】
<br>, <img>

<br/> 是XHTML语法，如果html 要兼容 xhtml的话用 <br/>, 否则html都应该用<br>

### Web之旅
www.test.com
www: 是域中一个特定服务器的名字
test.com: 这部分是域名
.com: 不同域的结尾有不同的用途，.com, .org. gov

#### 网站名和域名
网站名：www.test.com
域名：test.com

a.test.com
b.test.com
域名可以用于多个网站

#### URL
浏览器输入的web地址称为URL，或统一资源定位符
uniform resource locators
http://www.kaifa.in/index
http: 获取资源的协议
www.kaifa.in: 网站名
index： 绝对路径

#### HTTP
超文本传输协议：HyperText Transfer Protocol

a标签 锚点
<a href="#test">a</a>
target属性值告诉浏览器页面的“目标窗口”
_blank 新窗口

可以为任何元素增加title属性，工具提示

### 认识媒体
img
显示图像之前，必须先获取这个图像。

web常用3种格式图片：jpeg，png，gif
JPEG
照片和复杂图像使用
不支持透明度

png&gif
单色图像、logo、几何图形
支持透明度

img 边缘生硬，抗锯齿

### html
html5: <!doctype html>

<meta charset="utf-8">
meta: 告诉浏览器关于页面的一些信息
charset：字符编码属性
utf-8: unicode编码的一种

doctype&charset是前端的义务，必须履行

### css
<link type="text/css" rel="stylesheet" href="">
type类型html5可以省略
stylesheet样式表
rel属性：指定了html文件与所链接的文件之间的关系。我们要链接一个样式表

woff字体：web open font format
trueType字体 .ttf
openType字体 .otf
``` css
@font-face {
  font-family: 'test';
  src: url("http.woff");
  src: url("http.ttf");
}
```

css 内置规则
- @font-face
- @import 导入其他css
- @media 媒体查询

背景图像
background-image: url(http://)
url两边不需要加引号

border-style

层叠：来自多个样式表的样式都“层叠”在页面上。

### html5
section标签：可以把相关的内容分组在一起
article标签：包含独立的内容，如一个新闻报道、一个博客帖子或者一个简短的报告
大多数情况下，section和article 都会有一个 header

time标签
<time datetime="2021-07-12">2021-07-12</time>

### 表格
table
  caption 增加一个标题
tr 
  th
tr
tr
  td
tr
table
tr: 元素构成表格中的一行
