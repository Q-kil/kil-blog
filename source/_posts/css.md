---
title: css
date: 2020-03-06 19:53:06
categories:
- CSS
tags:
- CSS
---
# 浏览器兼容
``` css
-webkit-transform:rotate(-3deg); /*为Chrome/Safari*/
-moz-transform:rotate(-3deg); /*为Firefox*/
-ms-transform:rotate(-3deg); /*为IE*/
-o-transform:rotate(-3deg); /*为Opera*/
transform:rotate(-3deg); 
```



# 样式
## 超出部分省略号
``` css
overflow: hidden; // 超出的文本隐藏
text-overflow: ellipsis; // 溢出用省略号显示
white-space: nowrap; // 溢出不换行
```

## 无序列表样式
https://developer.mozilla.org/zh-CN/docs/Web/CSS/list-style

## placeholder 颜色
``` css
input {
  &::-webkit-input-placeholder {
    color: red;
  }
  &::-moz-placeholder {
    color: red;
  }
  &::-ms-input-placeholder {
    color: red;
  }
}
```

## 背景色透明
``` css
background-color: transparent;
```

## 背景色渐变
linear-gradient() 函数用于创建一个表示两种或多种颜色线性渐变的图片
<gradient> 是一种<image>CSS数据类型的子类型，用于表现两种或多种颜色的过渡转变。
``` css
background: linear-gradient(#e66465, #9198e5);
background: linear-gradient(to right, #3494e6, #ec6ead);
```




## 移动端input 内阴影
``` css
input,
textarea {
  border: 0; /* 方法1 */
  -webkit-appearance: none; /* 方法2 */
}
```

## background-size
https://developer.mozilla.org/zh-CN/docs/Web/CSS/background-size

## 列表最后一项去除margin-right
不用给item再加类名，item-right, 再加样式
``` css
&:nth-child(4n) {
  margin-right: 0;
}
```

## css 盒子模型
border-box
width = border + padding + 内容的宽度

## 动画
transition: all .3s linear


# 适配
``` css
css: {
  loaderOptions: {
    postcss: {
      plugins: [
        require('postcss-px-to-viewport')({
          unitToConvert: 'px',
          viewportWidth: 750,
          unitPrecision: 3,
          propList: ['*'],
          viewportUnit: 'vw',
          fontViewportUnit: 'vw',
          selectorBlackList: [],
          minPixelValue: 1,
          mediaQuery: false,
          replace: true,
          exclude: /(\/|\\)(node_modules)(\/|\\)/
        })
      ]
    }
  }
}
```

## input 问题
ios 光标变大
原因：
- Chrome：该行无文字时，光标高度与line-height一致；该行有文字时，光标高度从input顶部到文字底部(这两种情况都是在有设定line-height的时候)，如果没有line-height，则是与font-size一致。
- IOS中情况和Chrome 相似。

方法：
设置字体大小和行高一致，然后通过 padding 撑开大小

ios placeholder 位置偏上
``` css
input::-webkit-input-placeholder {
  font-size: 30px;
  line-height: 50px;
}
```

# css3 动画
## transition 过渡
石器时代
在 CSS3 出现之前，网页上的动画都是靠 JavaScript 来实现的，在这个时代，你可能会经常看见这样的代码片段：
``` js
const timeout = setTimeout(test, 2000);
function test() {
  document.getElementById("test").style.opacity += 0.1
};
```

css3时代
``` css
.box {
  width: 100px;
  height: 200px;
  background: red;
  transition: all 1s ease;
}
.box:hover {
  width: 200px;
  height: 100px;
  background: yellow;
}
```
过渡是css3中颠覆性特征之一，可以不用Flash动画或JavaScript，当元素从一种样式变换为另一种样式时为元素添加效果

过渡动画：是从一个状态 渐渐的过渡到另一个状态

- 经常与`:hover`一起 搭配使用
- 如果要过渡多个属性，用逗号分割

四个属性 （后两个可以省略）
### transition-property 过渡属性
需要过度的 数字量化的 css属性

颜色系，如color，background-color，border-color，outline-color等

数字系，实在太多了，如width，height，top，right，bottom，left，zoom，opacity，line-height，background-position，word-spacing，font-weight，vertical-align，outline-outset，z-index等。

01系，如visibility（0表示隐藏，1表示显示）

如果要所有的属性都过渡，写：all

使用过渡口诀：谁做过渡给谁加

### transition-duration 延时时间，花费时间
过渡需要的时间，单位可指定s秒。默认是0, 表示立刻变化

### transition-timing-function 过渡方法，运动曲线
`{% asset_img timing-function.png %}`
看贝赛尔曲线就知道了，linear是匀速过渡，ease是先快再慢的节奏，ease-in是加速冲刺的节奏，ease-out是减速到停止的节奏，ease-in-out是先加速后减速的节奏。

### transition-delay 过渡延迟，何时开始
延迟开始过渡的时间，默认值是0，表示不延迟，立即开始过渡动作。单位是s秒或ms毫秒。

### eg
``` css
.box {
  width: 100px;
  height: 200px;
  background: blue;
  transition: all 1s ease;
}
.box:hover {
  width: 200px;
  height: 100px;
  background: yellow;
}
```

## transform 转型，变形
transform本质上是一系列变形函数，分别是translate位移，scale缩放，rotate旋转，skew扭曲，matrix矩阵。

我们应该都知道二八法则(巴莱多定律)，即任何一组东西中，最重要的只占其中一小部分，约20%，其余80%的尽管是多数，却是次要的。如果你有上述的感觉，那你就属于那80%, 一抓一大把，没有特色的页面仔。

### translate 平移
设置元素在 X轴或者 Y轴上的平移变换

### scale 缩放
/* 等同于变换: scaleX(2) scaleY(2);*/
transform: scale(2);

### rotate 旋转
transform: rotate(45deg); 顺时针旋转 45度

### skew 倾斜
 skew() 函数指定一个或两个参数，它们表示在每个方向上应用的倾斜量。
transform: skew(10deg, 10deg);

### matrix 矩阵
matrix(1, 2, 3, 4, 5, 6);

## animation 动画
| 值 | 描述  | 
| :--- | :--- | 
| name | 用来调用@keyframes定义好的动画，与@keyframes定义的动画名称一致 | 
| duration | 指定元素播放动画所持续的时间，默认 0 | 
| timing-function | 规定速度效果的速度曲线，默认 ease ；是针对每一个小动画所在时间范围的变换速率 | 
| delay | 延迟时间, 默认0；定义在浏览器开始执行动画之前等待的时间，值整个animation执行之前等待的时间 | 
| iteration-count | 定义动画的播放次数，默认 1 ; 可选具体次数或者无限(infinite) | 
| direction | 默认 normal ；设置动画播放方向：normal(按时间轴顺序),reverse(时间轴反方向运行),alternate(轮流，即来回往复进行),alternate-reverse(动画先反运行再正方向运行，并持续交替运行) | 
| play-state | 默认 running ；控制元素动画的播放状态，通过此来控制动画的暂停和继续，两个值：running(继续)，paused(暂停) | 
| fill-mode | 默认 none ；控制动画结束后，元素的样式，有四个值：none(回到动画没开始时的状态)，forwards(动画结束后动画停留在结束状态)，backwords(动画回到第一帧的状态)，both(根据animation-direction轮流应用forwards和backwards规则)，注意与iteration-count不要冲突(动画执行无限次) 

### animation-direction
normal
每个循环内动画向前循环，换言之，每个动画循环结束，动画重置到起点重新开始，这是默认属性。
alternate
动画交替反向运行，反向运行时，动画按步后退，同时，带时间功能的函数也反向，比如，ease-in 在反向时成为ease-out。计数取决于开始时是奇数迭代还是偶数迭代
reverse
反向运行动画，每周期结束动画由尾到头运行。
alternate-reverse
反向交替， 反向开始交替
动画第一次运行时是反向的，然后下一次是正向，后面依次循环。决定奇数次或偶数次的计数从1开始。

# 例子
## 进度条 transition
``` css
.line-c {
  width: 50%;
  height: 100%;
  background-color: #f00;
  border-radius: 40px;
  transition: width 1s ease;
}
.line-c:hover {
  width: 100%;
}
```




