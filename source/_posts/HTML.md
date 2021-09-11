---
title: HTML
date: 2020-04-20 14:33:13
categories:
- HTML
tags:
- HTML
---

# 基础
heperText Markup Language 超文本标记语言
WEB的结构
## lang
// TODO: Y
zh-cmn-Hans
## a
``` html
<a href="pref.html" target="view_window">Preface</a>
<a href="https://www.baidu.com" target="_blank">1</a>
<a href="https://www.baidu.com" target="_self">1</a>
```
href属性告诉浏览器链接的目标文件
view_window、view_frame、_blank、_self、_parent、_top

``` html
<a href="mailto:{email}?subject={subject}&body={content}">
    Send us an email
</a>

<a href="tel:{phone}">
    Call us
</a>

<a href="sms:{phone}?body={content}">
    Send us a message
</a>   
```

## favico缓存破坏
<link rel="icon" href="/favicon.ico?v=2" />    

## label
HTML <label> 元素（标签）表示用户界面中某个元素的说明。

## 文字
```
<b>字体加粗</b>
<i>斜体字体</i>
<u>下划线</u>
要为文本加下划线，您应该应用包含CSS text-decoration属性设置为 underline 的样式。

<s>删除线（不在相关）</s>
<del>已删除</del>

上标：X<sup>2</sup>
下标：Y<sub>3</sub>

块级引用
<blockquote>Words can be like X-rays, if you use them properly—they’ll go through anything. You read and you’re pierced.</blockquote>
```

## form
### 多选
```
<input type="checkbox" name="love" value="" checked="checked" \>唱歌
<input type="checkbox" name="love" value=""  \>跳舞
```

## frame
frameset 弃用
frame  弃用

现在使用  iframe
HTML内联框架元素 (<iframe>) 表示嵌套的browsing context。它能够将另一个HTML页面嵌入到当前页面

## 手风琴
``` html
<div class="wrapper">
    <details>
        <summary>
            Click me to see more details
        </summary>

        <p>
            Lorem ipsum dolor sit amet consectetur adipisicing elit. Ut eum perferendis eius. Adipisci velit et similique earum quas illo odio rerum optio, quis, expedita assumenda enim dicta aliquam porro maxime minima sed a ullam, aspernatur corporis.
        </p>
    </details>
</div>
```

## mark高亮
``` html
<p>&lt;mark&gt; 元素用于 <mark>高亮</mark> 文本</p>
```

## video
poster 属性指定在视频下载时或在用户点击播放按钮之前显示的图像。
``` html
<div>
  <video controls poster="https://img-blog.csdnimg.cn/20190301125102646.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MTAxMDE5OA==,size_16,color_FFFFFF,t_70">
    <source src="http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4"
    type="video/mp4"></video>
</div>
```

controls 和 autoplay属性是“布尔属性” 没有值。例如：如果有controls属性，视频控件就会出现
controls：播放器会提供一些控件，可以控制视频和音频的播放
autoplay：一旦页面加载视频就会开始播放
width height

不同格式：
<source .mp4>
<source .webm>

## 文件拖入
<div (drop)="onDropPart($event)"></div>
const f0 = e.dataTransfer.files[0];

# 路径
## 相对路径
..\windows\system32\cmd.exe

./ 当前目录
../ 父级目录
/ 根目录

项目用相对路径是常识
## 绝对路径
C:\windows\system32\cmd.exe

## 引用
js/a.js  当前路径  ./js/a.js

## 前端
js文件的相对路径是以引用该js文件的页面为基准
css文件的相对路径是以自身的位置为基准



# 历程
## what is it?
html是一种网页标记语言，叫超文本标记语言，我们平时上网所看到的所有网页均来自于html，英文全称Hyper Text（超文本） Markup（标记） Language（语言）。
但严格讲，它并不算编程语言而是属于标记语言（标记标签 markup tag）。所以，不论你是否是程序员，这个语言最好掌握。

## 历史
- html1.0 - 2.0（1991-1995）
  18个元素，支持超文本
- html3.2（1997.1）
  3.0期初设计主要用来兼容2.0的，且过于复杂如表格，文字绕排和复杂数学元素的显示，浏览器厂商也根本不鸟，最后挂了。
  html的标准就很不规范，加之浏览器之间的竞争，会产生只有自家浏览器支持的特性，也正因如此，那时候的浏览器对html页面中的错误都很宽容，这反而加重了页面的不标准性，很多web从业者写了更多的不标准页面。
  谁能统治浏览器，谁就能统治宇宙！浏览器为了保持领先，不停地增加自己的专用扩展包。战争的受害者永远都是百姓，这害得很多web开发者甚至要写两个单独的页面来做兼容，有的兼容差的，搞得浏览器还得想想怎么去显示。开发人员会经常会对着浏览器大骂：“他妈的支持个标准真有这么难吗?!”
- html4.0（1997.12）
  战争总有结束的时候，这个救世主就是W3C万维网协会（world Wide Web Consortium）！他们看不下去了，认为这是互联网最基础的问题，应该得以解决，若这样战下去，是没有希望的，没有标准何来统一？于是，他们想制定出一个“标准”，将html分割成两种语言，一个负责表现，一个负责结构，这样岂不是更好？于是最初的html+css分离的html4.0标准诞生了，要求浏览器厂商也遵从这些标准，这确实解决了很多问题，但仍然有不完美，这就是后话了，起码世界安静了，能让开发人员睡个好觉了。
- html4.01（1999.12）
  4.01闪亮登场，这个版本成了未来10年的经典款。相对于4.0只是做了稍许改变，做了些修补。正当大家各自安好便是晴天的时候，xhtml1.0来了。
- xhtml1.0（2001）
  这个期间诞生了一个新事物，xml，可扩展标记语言，它被设计用来传输和存储数据。语法严谨，对比html简直就是别人家的孩子，于是他们在了解接触中杂交出了xhtml1.0。xhtml承诺，因为它严格，又是90后，新方法多。只要遵从它的标准，天下即可统一。可问题是，80后和70后们，根本看不惯90后的做法，因为他们对4.01已经非常钟情，只需要完善4.01即可，根本不想要也不想懂xhtml的新方法。因为4.01比较灵活，而xhtml语法确实太过严谨。
  标签必须都小写
  非空标签必须成对出现
  标签顺序必须正确
  所有属性必须使用双引号
  不允许属性最简化或省略
  这是违反鲁棒性原则（对自己输出要严格， 对他人的输入要灵活）的，因为xhtml并没有增加新的tag，它只是要求按照XML的规范来要求HTML，并定义了一个新的MIME type，application/xhtml+xml。W3C的初衷是想让浏览器强行检查错误，如果页面有HTML错误，浏览器就要显示错误信息。而实际情况是大家已经用4.01的标准做了大量不符合要求的网页了，你这么一搞，那就是啪啪打脸啊，自然不被大家认可，这也不符合浏览器向后兼容的原则。后来，W3C不得已，就在xhtml 1.0的标准之后加了一个附录C，允许开发者自己选择是使用XHTML语法或是旧的MIME type，来分发页面。因为旧的MIME type不会触发浏览器的强错误检查。也就是说，很多网站虽然宣称自己符合xhtml1.0标准，但并不能保证完全无错。主要要看web服务器使用的是那种mime type来分发的。但是，W3C仍不死心啊！又在XHTML 1.1中取消了附录C，还是让大家全部使用新的MIME type来分发，并要求大家把文档标记成xml。结果很显然，然并卵！W3C锲而不舍啊，在后来流产的XHTML 2.0身上，还是非要强行错误检查，强行检查错误就是如果你页面有错误，网页显示就是黄屏，哪怕只有一个小错误，你丫别想看这个网页了！这要是不失败难道还等着程序员给它送上神坛么？而且这个情况正好解释了乱战期间的先实现后标准的现象存在的合理性。因为，先有标准再来实现是行不通的。
- html5（2014.10）
  上面的教训也为后来制定下一代标准，即html5的时候交了学费。所以，在html5诞生初期，带着鲁棒性原则的思想主线，向后兼容就成了h5最重要的原则。h5不但兼容4.01的大部分特性，还引入了许多新特性，甚至可以直接将旧网页的第一行改成<!doctype html>，让它变成一个HTML5页面，照样都会生成相同的DOM树，在浏览器里也会正常解析。老的已经运行了十几年，开发者确实已经需要更多特性来满足日益发展的需求了。h5正好满足了这个需求，不但支持博客、视频、图形功能，还有一大堆用来构建web应用的功能，所以，h5的成功就不难理解了。现在h5已经不单只一个技术或标准了，它已成为了一个技术合集的简称，在移动端的表现更像是一批黑马。但是，要注意的是，HTML5并不是直接由W3C制定的，w3c好像经历太多后累觉不爱了，觉得4.01可以作为最后一个版本了，html就这样吧。但总有一些另外的声音，Opera的伊恩-克森这时就提出来再改进下html的建议，但W3C的投票结果是NO，他们认为HTML已死，xHTML2才是未来，真是打不死的小强，死心不改啊！于是，Opera，Apple等浏览器厂商脱离W3C成立了WHATWG。接下来WHATWG的工作效率非常高，因为他们的工作组成员就是浏览器厂商，他们不仅可以说加就加，还可以实现，大家不断地提出一些好点子并且逐一做到了浏览器中，并且在短时间得出了一些成果。反观W3C的xHTML2没有什么实质性的进展，特别是从实现的角度来看，用原地踏步形容都不足为过。2006年蒂姆-伯纳斯-李（这个人也是牛的一逼，最好google下）写博文承认因为想法太不切实际了，导致失败，并建议重建HTML工作组。于是，2007年W3C组建了HTML5工作组并投票通过在WHATWG工作组的既有成果上开始工作而非从头开始。于是有了两个工作组并行的现象：一个专治，一个民主。但这都不重要了，重要的是只要他们的设计原则是统一的，对吗！


# 语义化
## 为什么需要语义化
- 易修改、易维护。
- 无障碍阅读支持。
- 搜索引擎友好，利于 SEO。
- 面向未来的 HTML，浏览器在未来可能提供更丰富的支持。

## 结构语义化
语义元素均有一个共同特点——他们均不做任何事情。换句话说，语义元素仅仅是页面结构的规范化，并不会对内容有本质的影响。

## 头部
<header>元素有两种用法，第一是标注内容的标题，第二是标注网页的页眉

## 尾部
footer

## 导航栏
导航栏使用<nav>看起来是理所当然的，进一步，它也用于一组文章的链接。一个页面可以包含多个<nav>元素，但通常仅仅在页面的主要导航部分使用它。

## 主要内容
<main>标签来标识主体内容

## 文章
<article>表示一个完整的、自成一体的内容块。如文章或新闻报道。<article>应包含完整的标题、文章署名、发布时间、正文。当语义与表现发生冲突，例如有时需要将文章分多个页面显示，那么需要把每个页面的文章区域都用<article>标记。

文章中包含插图时，使用新的语义元素<figure>标签。

## 侧边栏
aside

## 标题
多级别的目录
hgroup
  h1
  h2

## 缩写
abbr

## 加粗，强调
strong : 这个词在整个文章中的重要性

em : 这个词在这个句子里面的重音是什么

## 图片+详情
figure
  img
  figcaption

loading=lazy 属性 来推迟图像的加载，直到用户滚动到它们为止。(现在支持的浏览器还不全面)

## 列表
ol 有序列表
ul 无序列表

分为：
   有序列表:<ol></ol> 
   & 
   无序列表:<ul></ul>

1）有序列表： 用于显示具有统一特征的有序数据

<ol type="i" start="3">
  <li>新闻1</li>
  <li>新闻2</li>
  <li>新闻3</li>
  <li>新闻4</li>
</ol>

属性   值              描述
type   1 数字(默认)    排序
       a 字母
       A 大写字母A
       i 小写罗马
       I 大写罗马
start  数字           起始数字


2）无序列表：用于显示同一特征的无限数据

<ul type="circle">
  <li>...</li>
  <li>...</li>
  <li>...</li>
</ul>

属性   值                  
type   disc 实心圆(默认)     
       circle  空心圆
       square 实心矩形
       none  无

## 术语
dfn

## 预定义格式文本
pre

## 例子
samp

## 代码
code

# H5
先科普一下，HTML5并不是一项技术，而是一个标准。
标准的意思就是：学生准则手册。你可以按照准则做，甚至可以超出准则更加严格的要求自己，也可以不按照准则来，但是会被老师训斥小伙伴讨厌，别人都不找你玩，就像IE6一样。

那HTML5这些标准浏览器厂商到底姿持不姿持呢？这要看他们各自的尿性了。像chrome这种不仅在很多标准上支持的非常好，还积极上进很多地方超出了标准，支持一些标准中还是草案的部分。

所以其实要么我们是作为理论派讨论HTML5标准，要么是作为实践派讨论HTML5标准在某浏览器的应用。但是实际上我们在说到H5的时候，并不是指标准，也不是指标准的应用，而是一个硬生生造出来的奇怪概念合集，所以我是旗帜鲜明的反对这个称呼的。

最近一年的时间，我主要靠这个东西养家（并没有家）糊口。所以我是懂得甲方打电话过来询问，“你是不是会做H5开发？”的时候，我知道他们要的是那种可以在朋友圈分享的，看起来很酷炫的小页面，他们实际要的东西拆开来看大概包括以下技术点;

1. 页面素材预加载技术，可以使用createJS之中的preloadJS。我没有看preloadJS的源码，不过预加载并不是HTML5标准中更新的方法。
2. 音乐加载播放技术，createJS中同样有soundJS可以实现，而且这部分说起来确实是HTML5标准支持的内容，在上个时代并没有audio这样的标签。
3.可以滑动的页面，大多数是用了swiper.js这个Jquery插件，也有一些是手写的swipe，比较拙劣的手写版页面是不会跟手滑动的，其中touchstart等四个touch系列的事件是HTML5标准中的事件
4.可以涂抹擦除，多半是canvas叠加层，canvas是HTML5标准里面的标签，是代表了先进生产力的标签。
5.有动态的文字和图片，常见的是使用了css3或者直接使用js动画。很多时候提到HTML5多半还会带上CSS3，而CSS的分级又是另外的一个问题了，在不同的项目标准上，CSS会独立定级，以后应该不会有CSS4这个东西，所以大家也不用担心在H5以后又冒出来了C4（不过真是想用C4炸死那些每天把H5挂在嘴上的人）
6.可以填表报名，这是最基本的表单，是有网页以来就有的东西。
7.可以支持分享自定义的文案和图片，这个是用到了微信的jssdk，和HTML标准半毛钱关系都没有。
8.还有其他我想起来再补充的。

所以我们在谈论H5的时候，实际上是一个解决方案，一个看起来酷炫的移动端onepage网站的解决方案。而这个解决方案不仅包含了HTML5新增的audio标签，canvas，拖拽特性，本地存储，websocket通信，同时也包括了盒模型，包括绝对定位，包括一切前端的基本知识。

有学弟来问我说，学长我想学H5，应该从哪里开始？
我说HTML5新增特性在W3C上都可以查得到的。
学弟说，不，我想学的是H5，想做H5的页面。
于是我猜测他所指的就是上面论述的这种酷炫小页面，我就说，那你要先学习HTML，包括HTML5的新标准和之前的全部标准，然后学CSS以及CSS3，了解它们在浏览器的实现情况，原生JS了解一点就可以，大多的操作可以用Jquery，了解常用的几个Jquery插件的用法，应该就差不多了。如果想要做更酷炫的的，学一下egret或者cocos2d更好。如果要优化加载速度，还要学一下grunt一类的自动化工具。微信的sdk有很多坑，至少nodejs或者php一类的后端语言要会一点。

学弟说，那这不就是前端了么？我只是想学H5啊。

所以你看，当我们对一个概念的内涵无法统一的时候，我们根本不知道彼此之间在谈论的是什么。

”H5“本应是一个技术合集，却被意会成了一项技术，变成可以在质上而不是量上描述的概念。

对于营销来说，我们只要讲我们可以做H5或者不能做，这种定性的描述就够了。但是对于技术上，这是定量的事情，只能在具体某个技术项上是否，无法对这个本不存在的概念说是否。

就比如我遇到过有甲方说，我们之前找了一个人做H5，做的还不错，但是这个case他又说做不了，我也搞不懂H5和H5之间也有那么大差别吗？我只能笑笑和他说，世界这么大，各种各样的H5都是有的。

这就是为什么我反对H5，因为这个名词和它表示的内涵是严重不符的，这让我们难以沟通，让营销人和技术人之间产生误解，让浑水摸鱼的培训师们赚的盆满钵满，让技术新人不踏踏实实的学习技术。

# interview
什么是<!DOCTYPE>？
百科：
中文名：文档类型标签
外文名：DOCument TYPE
外语缩写：DOCTYPE
定义：标准通用标记语言的文档类型声明
<!DOCTYPE> 声明位于文档中的最前面的位置，处于 <html> 标签之前。
<!DOCTYPE> 声明不是一个 HTML 标签；它是用来告知 Web 浏览器页面使用了哪种 HTML 版本。
HTML 4.01 规定了三种不同的 <!DOCTYPE> 声明，分别是：Strict、Transitional 和 Frameset。 HTML5 中仅规定了一种：<!DOCTYPE html>
文档解析类型：
BackCompat：怪异模式，浏览器使用自己的怪异模式解析渲染页面。（如果没有声明DOCTYPE，默认就是这个模式）
CSS1Compat：标准模式，浏览器使用W3C的标准解析渲染页面。

# other
## use sass
1.vscode安装两个插件：
- Live Sass Compiler
- Live Server

2.写好scss后，点击
vscode footer Watch Sass

3.直接引入转好的css文件就可以了

# 《Head First HTML 与 CSS》








