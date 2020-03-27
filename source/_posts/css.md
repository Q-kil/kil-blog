---
title: css
date: 2020-03-06 19:53:06
categories:
- CSS
tags:
- CSS
---

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