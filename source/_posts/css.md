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

<<<<<<< HEAD
## 背景色透明
``` css
background-color: transparent;
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

=======
## 列表最后一项去除margin-right
不用给item再加类名，item-right, 再加样式
``` css
&:nth-child(4n) {
  margin-right: 0;
}
```

>>>>>>> 78db2a9cab394dd35b773f3ccb06f3d141bcab03
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