---
title: advanced
date: 2020-07-10 18:18:35
categories:
- Front-End
tags:
- Front-End
- JavaScript
---

# JS
## 语言通识
`{% asset_img language.png%}`

`{% asset_img type.png%}`

`{% asset_img js01.png%}`

## 乔姆斯基谱系
乔姆斯基谱系：是计算机科学中刻画形式文法表达能力的一个分类谱系，是由诺姆·乔姆斯基于 1956 年提出的。它包括四个层次：
0- 型文法（无限制文法或短语结构文法）包括所有的文法。
1- 型文法（上下文相关文法）生成上下文相关语言。
2- 型文法（上下文无关文法）生成上下文无关语言。
3- 型文法（正规文法）生成正则语言。

## BNF
巴科斯范式 Backus Normal Form

是一种用于表示上下文无关文法的语言，上下文无关文法描述了一类形式语言。它是由约翰·巴科斯（John Backus）和彼得·诺尔（Peter Naur）首先引入的用来描述计算机语言语法的符号集。

`{% asset_img bnf.png %}`
`{% asset_img bnf02.png %}`

### 理解
[链接](https://www.cnblogs.com/huiyenashen/p/4445676.html)
BNF 规定是推导规则(产生式)的集合，写为：

<符号> ::= <使用符号的表达式>
这里的 <符号> 是非终结符，而表达式由一个符号序列，或用指示选择的竖杠'|' 分隔的多个符号序列构成，每个符号序列整体都是左端的符号的一种可能的替代。从未在左端出现的符号叫做终结符。

基本原理
      BNF类似一种数学游戏：从一个符号开始（叫做起始标志，实例中常用S表示），然后给出替换前面符号的规则。BNF语法定义的语言只不过是一个字符串集合，你可以按照下述规则书写，这些规则叫做书写规范（生产式规则），形式如下：
      symbol := alternative1 | alternative2 ...
      每条规则申明:=左侧的符号必须被右侧的某一个可选项代替。替换项用“|”分割（有时用“::=”替换“:=”，但意思是一样的）。替换项通常有两个符号和终结符构成。之所以叫做终结符是因为没有针对他们的书写规范，他们是书写过程的终止（符号通常被叫做非终止符，也有人叫非终端）。


       BNF就是巴科特·瑙尔式的缩写， 在计算机的史前时代（1950s)，曾有一位大师，他奠定了现代计算机的基础，在他老人家的诸多成就之中，包括了对形式语言的研究，和发明了高级语言：FORTRAN。 为了纪念他老人家，我们把他提出的一套描述语言的方法叫做BNF。它以递归方式描述语言中的各种成分，凡遵守其规则的程序就可保证语法上的正确性。BNF由于其简洁、明了、科学而被广泛接受，成为描述各种程序设计语言的最常用的工具。
       其实BNF很简单，::=表示定义     |表示或    尖括号(<>)括起来的是非终结符 
　　所谓非终结符就是语言中某些抽象的概念不能直接出现在语言中的符号，终结符就是可以直接出现在语言中的符号。
　　比如：C语言的声明语句可以用BNF这样描述： 
　　<声明语句> ::= <类型><标识符>; | <类型><标识符>[<数字>]; 
　　这一句中<声明语句>这个非终结符被定义成了两种形式（上面用|隔开的两部分），同时在这里引入了三个终结符: 分号; 左方括号[，右方括号 ]。 
　　<类型> ::= <简单类型> | <指针类型> | <自定义类型> 
　　<指针类型> ::= <简单类型> * | <自定义类型> * 
　　<简单类型> ::= int|char|double|float|long|short|void 
　　<自定义类型> ::= enum<标识符>|struct<标识符>|union<标识符>|<标识符>
　　到这里就基本上把<类型>定义清楚了。

　　<数字> ::= 0x<十六进制数字串> | 0<八进制数字串> | <十进制数字串> 
　　<十六进制数字串> ::= <十六进制数字> | <十六进制数字串><十六进制数字> 
　　<八进制数字串> ::= <八进制数字> | <八进制数字串><八进制数字> 
　　<十进制数字串> ::= <十进制数字> | <十进制数字串><十进制数字> 
　　<十六进制数字> ::= <十进制数字> | A | B | C | D | E | F 
　　<十进制数字> ::= <八进制数字> | 8 | 9 
　　<八进制数字> ::= 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 
　　到这里就把<数字>定义清楚了 

　　<标识符> ::= <字母> | <标识符> <字母数字串> 
　　<字母数字串> ::= <字母>|<十进制数字>|<字母数字串><字母>|<字母数字串><十进制数字> 
　　<字母> ::= _ | <大写字母> | <小写字母> 
　　<小写字母> ::= a|b|c|d|e|f|g|h|i|j ……  
　　<大写字母> ::= A|B|C|D|E|F|G|H|I|J …… 
　　到此为止整个声明语句就定义完了（就是说已经没有非终结符了）。

         虽然看起来很繁，但前面定义的各种非终结符都可以很容易的在别的地方重用。比如，函数声明可以定义成下面的样子： 
　　<函数声明语句> ::= <类型><标识符>(<形参表>); 
　　<形参表> ::= <类型><标识符> | <形参表>,<形参表> 
　　只用两句就描述完了，所以BNF实际上比用自然语言要简练得多（整个C语言只用一二百句就可以描述清楚），而且相当的精确，不会有自然语言中那种模棱两可的表达。如果你对BNF比较敏感的话，会发现C里面的标识符不能由数字开头，而且在C里面下划线是被当做字母看待的（也就是说能用字母的地方都可以用下划线）。

## 产生式
 在计算机中指 Tiger 编译器将源程序经过词法分析（Lexical Analysis）和语法分析（Syntax Analysis）后得到的一系列符合文法规则（Backus-Naur Form，BNF）的语句

几种结构的组合产生一个新的结构，叫语法定义也叫语法产生式。

## 终结符
终结符： 最终在代码中出现的字符（ https://zh.wikipedia.org/wiki/ 終結符與非終結符)

不是代码终止的意思

# JS类型
## String
`{% asset_img code.png %}`
ASCII 0-127个字符 ；出来的较早，计算机的基础
Unicode 世界编码集
GB 国标里的字符码点跟Unicode码点不一致

UTF8 
8个比特位，1个字节，默认用一个字节表示一个字符

UTF16
16个比特位，2个字节表示一个字符
`{% asset_img utf.png %}`

控制位
`{% asset_img utf02.pngs %}`


# 浏览器工作原理
## 浏览器总论
`{% asset_img browser.png %}`
最后显示在计算机上的是图片的形式 Bitmap，最后传给显卡驱动设备，转换成人眼可识别的光信号。

浏览器目标：
从URL -> Bitmap （过程是浏览器渲染的基础流程）

## 状态机
有限状态机**处理字符串**
`{% asset_img state.png %}`

意义：在各个状态加入自己的逻辑，处理业务

debug 添加监视
`{% asset_img state02.png %}`

## HTTP
浏览器的第一步：http状态解析
- http状态
- header

### 网络模型
`{% asset_img http.jpg %}`

``` js
new Request({
  method: "POST",     // TCP 层
  host: "127.0.0.1",  // IP 层
  post: "8088"        // TCP 层
  path: "/"        // method 和 path 都是HTTP协议要求的
  headers: {
    ["X-Foo2"]: "customed"  // HTTP协议要求
  }
})
```


### TCP与IP的一些基础知识
- 流
- 端口
  每一个软件都会从网卡去拿数据，哪一个数据是分配给哪一个软件的，需要用到端口概念
- node 对应 require('net')

- 包
  TCP 传输的就是一个一个数据包的概念
- IP 地址
  数据包 从那到那
- node没有，node 调用C++ 库。libnet/libpcap
  libnet: 负责构造IP包并且发送
  libpcap: 负责从网卡抓所有的流经你的网卡的IP包


### HTTP
- request
- response

必须先由客户端发起一个 request，服务端发送一个 response

HTTP 协议是文本型的协议，所有内容都是字符串

method: GET/POST

#### http协议 request
`{% asset_img request.png %}`

第一步HTTP请求总结
- 设计一个HTTP请求的类
- content type是一个必要的字段，要有默认值
- body是kv格式
- 不同的content-type影响body的格式
- content length

第二步send函数编写
- 在Request的构造器中收集必要的信息
- 设计一个send函数，把请求真实发送到服务器
- send函数应该是异步的，所以返回Promise

response 格式
`{% asset_img response.png %}`

第三步发送请求到服务端（重要）
- 设计支持已有的connection或者自己新建connection
- 收到数据传给parser
- 根据parser的状态resolve Promise

第四步response解析（重要）
- Response必须分段构造，所以我们要用一个 ResponseParser来 "装配"
- ResponseParser分配处理ResponseText，我们用状态机来分析文本的结构

最后一步response body解析
- Resonse的body可能根据Content-Type有不同的结构，因此我们会采用子Parser的结构来解决问题
- 以TrunkBodyParser为例，我们同样用状态机来处理body的格式

#### HTML解析
第一步 Parse模块的文件拆分
- 为了方便文件管理，把parser单独拆到文件中
- parser接受HTML文本作为参数，返回一颗DOM树

第二步 用FSM实现HTML的分析
- 用FSM来实现HTML的分析
- 在HTML标准中，已经规定了HTML的状态 [whatwg](https://html.spec.whatwg.org/multipage/parsing.html#tokenization)
- Toy-Browser只挑选其中一部分状态，完成一个最简版本

第三步 解析标签
三种tag：
- 开始标签
- 结束标签
- 自封闭标签

总结：
- 主要的标签有：开始标签，结束标签和自封闭标签
- 在这一步我们暂时忽略属性

第四步 创建元素
- 在状态机中，除了状态迁移，我们还会要加入业务逻辑
- 我们在标签结束状态提交标签token

第五步 处理属性
- 属性值分为单引号、双引号、无引号三种写法，因此需要较多状态处理
- 处理属性的方式跟标签类似
- 属性结束时，把属性加到标签Token上

第六步 用token构建DOM树
Tree construction 第一步
- 从标签构建DOM树的基本技巧是使用栈
- 遇到开始标签时创建元素并入栈，遇到结束标签时出栈
- 自封闭节点可视为入栈后立即出栈
- 任何元素的父元素是它入栈前的栈顶

第七步 将文本节点加到DOM树
- 文本节点与自封闭标签处理类似
- 多个文本节点需要合并

#### CSS计算
环境准备：
npm install css (css == css parser, 把css的代码变成 AST抽象语法树)
根据这颗抽象语法树，抽出各种CSS规则，应用到HTML元素上

第一步 收集CSS规则
- 遇到style标签时，我们把CSS规则保存起来
- 这里我们调用CSS Parser来分析CSS规则
- 仔细研究此库分析CSS规则的格式

第二步 添加调用
计算CSS时机
- 创建一个元素后，立即计算CSS
- 理论上，当我们分析一个元素时，所有CSS规则已经收集完毕
- 在真实浏览器中，可能遇到写在body的style标签，需要重新CSS计算的情况，这里我们忽略

第三步 获取父元素序列
- 在computeCSS函数中，我们必须知道元素的所有父元素才能判断元素与规则是否匹配
- 我们从上一步骤的stack，可以获取本元素所有的父元素
- 因此我们首先获取的是 ”当前元素“，所以我们获取得和计算父元素匹配的顺序是从内向外

第四步 选择器与元素的匹配
- 选择器也要从当前元素向外排列
- 复杂选择器拆成针对单个元素的选择器，用循环匹配父元素队列

第五步 计算选择器与元素匹配
- 根据选择器的类型和元素属性，计算是否与当前元素匹配
- 这里仅仅实现了三种基本选择器，实际的浏览器中要处理复合选择器
- 可选：实现复合选择器，实现支持空格的Class选择器

第六步 生成computed属性
- 一旦选择匹配，就应用选择器到元素上，形成computedStyle

# CSS
## 总论
第一步：找到一条好的线索，建立一个基础知识的骨架结构
线索：学习一门语言，先从语法入手

语法
• [css2.1](https://www.w3.org/TR/CSS21/grammar.html#q25.0)
• https://www.w3.org/TR/css-syntax-3

## 规则
普通规则和@规则
`{% asset_img css.png %}`
### At-rules
• @charset : https://www.w3.org/TR/css-syntax-3/
• @import :https://www.w3.org/TR/css-cascade-4/
• @media :https://www.w3.org/TR/css3-conditional/ 【重要】
• @page : https://www.w3.org/TR/css-page-3/
• @counter-style :https://www.w3.org/TR/css-counter-styles-3 
• @keyframes :https://www.w3.org/TR/css-animations-1/ 【重要】
• @fontface :https://www.w3.org/TR/css-fonts-3/ 【重要】
• @supports :https://www.w3.org/TR/css3-conditional/
• @namespace :https://www.w3.org/TR/css-namespaces-3/

### css-rule
`{% asset_img css01.png %}`

- Selector
  + https://www.w3.org/TR/selectors-3/ 
  + https://www.w3.org/TR/selectors-4/ 制定中
- Key
  + Properties
  + Variables: https://www.w3.org/TR/css-variables/
- Value
  + https://www.w3.org/TR/css-values-4/

### 完整的标准列表
#### 收集标准
爬虫抓取w3c网站上的内容
[w3c所有的标准和草稿](https://www.w3c.org/TR/)
[w3c css标准](https://www.w3c.org/TR/?tag=css)

#### 标题和url提取出来
控制台中输入：
``` js
Array.prototype.slice.call(document.querySelector('#container').children).filter(e => 
  e.getAttribute('data-tag').match(/css/)).map(e =>
  ({name: e.children[1].innerText, url: e.children[1].children[0].href})
)
```

JSON.stringify() 一下

### 实验
爬取w3c css的一些内容，并且做一些过滤
推荐学习方法：面对大量的信息的时候，用一些自动化的手段（程序员的老本行），帮助我们做一些枯燥的收集工作

## 选择器
### 语法
#### 简单选择器
- * （通用选择器，可以选中任何的元素，相当于没有选择器）
- div svg|a （div 叫做type selector 类型选择器，选择的是元素的tagName属性）
- .class （可以用空白做分隔符，指定多个class，只要匹配一个就可以）
- #id （严格匹配）
- [attr=value] （属性选择器，等号前面加浪线，就表示像class一样，可以支持拿空格分隔的值的序列，如果前面加单竖线表示这个属性以这个值开头即可，属性选择器强大，如果对优先级没有考虑可以代替class id
- :hover （伪类选择器，元素的特殊状态，跟HTML属性也没有关系，多半来自于交互；带函数的伪类选择器）
- ::before (伪元素选择器，选中一些原本不存在的元素，如果不选就不存在一个元素)

注：
HTML命名空间
- HTML
- SVG
- MathML
如果想选SVG里面的特定元素或MathML里面特定的元素，必须要用到单竖线（命名空间分隔符）
HTML命名空间分隔符是冒号
SVG 标签里面有一个跟HTML重名的a标签

#### 复合选择器
- <简单选择器><简单选择器><简单选择器>
- * 或者 div 必须写在最前面

#### 复杂选择器
- <复合选择器> <sp> <复合选择器>
- <复合选择器> " > " <复合选择器>
- <复合选择器> " ~ " <复合选择器>
- <复合选择器> " + " <复合选择器>
- <复合选择器> " || " <复合选择器>

### 优先级
`{% asset_img css02.png %}`

### 伪类
链接/行为
- :any-link
- :link :visited
- :hover
- :active
- :focus
- :target

树结构
- :empty
- :nth-child()
- :nth-last-child()
- :first-child :last-child :only-child

逻辑型
- :not伪类
- :where :has

选择器写的复杂，意味HTML结构写的不合理
### 伪元素
给页面添加修饰性的内容
- ::before
- ::after
- ::first-line
- ::first-letter

`{% asset_img css03.png %}`
`{% asset_img css04.png %}`

## CSS排版
### 盒(box)
`{% asset_img css05.png %}`

### 正常流
Normal Flow

正常流排版
- 收集盒进行
- 计算盒在行中的排版
- 计算行的排布

BFC IFC
`{% asset_img css06.png %}`
正常流里面有两种 Formatting Context
- 块格式化上下文（Block Formatting Context，BFC）
- 行级格式化上下文（Inline Formatting Context，IFC）

文字只能放IFC里

#### 行级排布
基线对齐
`{% asset_img css07.png %}`

##### 文字在字体里面的定义
文字有宽和高，加上基线
`{% asset_img css08.png %}`
origin 就是基线
yMin 就是基线到低缘的距离
bearingX 决定了一个默认的字间距
advance  整个占的空间


##### 行模型
line-top
text-top
base-line    以英文为主，用来对齐的线
text-bottom   top,bottom 只要字体大小不变，它们就不变；如果使用多种字体混排，top和bottom是由fontSize最大的一个字体决定的; 文字的上缘下缘是两条固定的线
line-bottom   如果行高是大于文字的高度的时候；如果和盒混排会涉及line-top,bottom偏移的问题；盒的先后顺序和盒的尺寸都会影响line-top,bottom这个位置，盒不影响text-top,bottom

第一个特别注意的问题
行内盒 inline-block 它的基线是随着自己里面的文字去变化的；不建议给行内盒使用基线对齐的；使用vertical-align


#### 块级排布
##### float与clear
clear：找一块干净的空间，浮动

老一辈用float clear排版
重排行为

#### margin折叠
从上往下排，受盒模型影响
`{% asset_img css09.png %}`
叠出来的高度跟最大的margin的高度相等，这个现象叫margin collapse, 也叫留白的折叠现象，也叫边距折叠。
古老的印刷行业也是这种排版体系。
注意：只会发生在BFC里面

单看float ，单看边距折叠，单看BFC 都不难。如果三个现象叠加到一起，就是古代前端的最大难题。现在面试BFC也是在这里面

#### BFC合并
正常流最困难的部分

##### Block
- Block Container: CSS2.1标准里面定义的；里面有BFC的
  + 能容纳正常流的盒，里面就有BFC
- Block-level Box：外面有BFC的
- Block Box = Block Container + Block-level Box: 里外都有BFC的
  + 这个不能理解，就无法理解BFC合并现象

##### Block Container
基本上是一些 display 这样的效果
- block
- inline-block
- table-cell (table-row 不是)
- flex item (display: flex, 子元素如果没有特殊的display)
- grid cell
- table-caption (表格的标题)

所有能够容纳里面不是特殊的display的模式的，它里面默认就是正常流

##### Block-level Box
`{% asset_img css10.png %}`

##### 设立BFC
什么时候什么样的盒，它会创建BFC呢，Establish BFC

- floats
- absolutely positioned element
- block containers(such as inline-blocks, table-cells, and table-captions)
  that are not block boxes,
    - flex items
    - grid cell
    - ......
- and block boxes with 'overflow' other than 'visible'

换一个角度记：
默认这些能容纳正常流的盒，都认为它会创建 BFC，但是只有一种情况例外，就是 Block Box 里外都是 BFC
并且 overflow 是 visible

##### BFC合并
- block box && overflow: visible
  + BFC合并与float
  + BFC合并与边距折叠


### Flex排版
- 收集盒进行
- 计算盒在主轴方向的排布
- 计算盒在交叉轴方向的排布

## 动画与绘制
### 动画
CSS控制表现
- 控制元素的位置和尺寸的信息
- 控制绘制和最后实际看到的渲染的信息
- 交互与动画的信息

#### Animation
动画
- @keyframes定义
- animation：使用

animation 六个属性的集合
- animation-name 时间曲线
- animation-duration 动画的时长
- animation-timing-function 动画的时间曲线
- animation-delay 动画开始前的延迟
- animation-iteration-count 动画的播放次数
- animation-direction 动画的方向

@keyframes
- 百分比
- from to  （from大致相等于 0%；to 100%）

#### Transition
属性
- transition-property 要变换的属性
- transition-duration 变换的时长
- transition-timing-function 时间曲线
- transition-delay 延迟


# HTML
源流来自：XML 、 SGML（两种语言是HTML的超集）
H5以后，变成独立的语言

## 定义
### XML
DTD：文档类型定义
https://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd

### XHTML
https://www.w3.org/1999/xhtml/

HTML严格写法，每个标签都必须严格闭合，可以写XHTML版本的HTML5

### 特殊字符 special
``` html
<div>&#955; &#945; &#946; &#947; &#937;</div>
λ α β γ Ω
<div>&lambda; &alpha; &beta; &gamma; &omega;</div>
λ α β γ ω
```

必须记住的，如果直接写在html里会报错
``` html
<div>&quot; &amp; &lt; &gt; &apos;</div>
" & < > '
```

## 语法

## DOM API
DOM 掌握最高标准：灵活运用 range 和 fragment
### 事件API
Event：冒泡与捕获
先捕获后冒泡

addEventListener 默认监听冒泡事件，false
addEventListener 第三个参数 ture，捕获事件

### Range
操作半个节点或批量节点
对DOM树操作，万能的API

range: 范围
有起始点和终止点，range是不能跳的
### 创建
``` js
let range = new Range();
```

### API
由于节点换行、缩进，会产生很多空白节点
现操作某节点前后
- range.setStart(node, length)
- range.setEnd(node, length)
- range.setStartBefore
- range.setEndBefore
- range.setStartAfter
- range.setEndAfter
- range.selectNode
- range.selectNodeContents

取出range里面的内容（删）
let fragment = range.extractContents()
fragment node的子类

插入新的节点（增）
range.insertNode(document.createTextNode('aaa'))

移除半个节点，会自动补上标签

``` js
<div id="b">123<span style="background-color: pink;">456789</span>0123456789</div>
range.setStart(document.getElementById('a').childNodes[1].childNodes[0], 3);
```

# 算法
## TicTacToe
井字棋，三字旗
核心：提升编程能力











# 组件化
前端架构里面最重要的部分
## 前端架构热门的两个话题
### 组件化
从扩展html标签，引申出来的前端架构体系，主要目标复用
### 架构模式
MVC MVVM
前端跟数据逻辑层之间，如何去交互

## 组件的基本概念和基本组成部分
### Attribute
属性
attribute： 强调描述性
property:  强调从属关系

## JSX
react

### 安装
jsx是babel的插件

## parser
vue



# 工具链
覆盖前端开发的各个环节
所有工具的开端就是脚手架

generator: 脚手架；（直释：发电机，生产者）

## yeoman
通过命令行去跟用户交互

### 命令行交互
``` js
const answers = await this.prompt([
  {
    type: "input",
    name: "name",
    message: "Your project name",
    default: this.appname
  },
  {
    type: 'confirm',
    name: 'cool',
    message: 'Would you like to enable the Cool Feature?'
  }
]);
this.log('app name', answers.name);
this.log('cool feature', answers.cool);
```

### 新建文件
``` js
this.fs.copyTpl(
  this.templatePath('t.html'),
  this.destinationPath('public/index.html'),
  { title: 'Templating with Yeoman' }
)
```

### initPackage
``` js
const pkgJson = {
  devDependencies: {
    eslint: '^3.15.0'
  },
  dependencies: {
    react: '^16.2.0'
  }
};

this.fs.extendJSON(this.destinationPath('package.json'), pkgJson);
this.npmInstall();
```

# 发布系统
包含：
线上服务系统（用户使用）
程序员发布系统
发布工具（命令行工具）

## 线上服务器
编写代码部署到服务器上
把一个Express服务器，部署到线上

### 初始化一个项目
npx express-generator

## 发布服务
发布服务器和发布工具构成

### publish-server
向真实的server，copy自己的文件
向

#### 搭建
可以使用express和koa框架
这里使用http api

request和response都是流式处理

把文件通过HTTP的方式，传给我们的发布的服务器
publish-tool ——> publish-server

#### 了解Node里面的流
第一种方式是可读的流：用nodejs代码可以从流里面获取数据
[node流](https://nodejs.org/docs/latest-v13.x/api/stream.html#stream_class_stream_writable)

秒级的HTTP请求 与 工具型request传输 几分钟
### publish-tool
Content-Type: HTTP RFC标准

以package.json为例，学习流式传输
[node pipe 流](https://nodejs.org/docs/latest-v13.x/api/stream.html#stream_class_stream_readable)

### 多文件压缩包传输
npm包
archiver
unzipper

## 三个项目
发布工具
发布系统
线上服务系统

## 发布系统部署


[跳转到本文HTML](#HTML)
[跳转到本文算法](#算法)
[跳转到本文组件化](#组件化)
[跳转到本文工具链](#工具链)
[跳转到本文发布系统](#发布系统)
