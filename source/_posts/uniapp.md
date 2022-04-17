---
title: uniapp
date: 2022-04-09 15:39:49
categories:
- uniapp
tags:
- uniapp
---

# Base
## 判断平台
html
``` html
<!-- #ifdef APP-PLUS -->
<view></view>
<!-- #endif -->

其他：MP-WEIXIN 
```

js
```js
if (process.env.UNI_PLATFORM === "h5") {}
if (process.env.UNI_PLATFORM === "app-plus") {}
if (process.env.UNI_PLATFORM === "mp-weixin") {}
if (process.env.UNI_PLATFORM === "mp-baidu") {}
```

## http request
```js
ureq =>
uni.request({
  url: '',
  method: 'GET',
  data: {},
  success: res => {},
  fail: () => {},
  complete: () => {}
});
```
