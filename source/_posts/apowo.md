---
title: apowo
date: 2020-06-22 13:46:28
tags:
---

# tooqing-webapp
## 用到的库
- vue-infinite-loading


# APP
## 解决异形屏适配问题（全屏模式下显示）

## 判断cordova or web-browser
cordova
<preference name="AppendUserAgent" value="Cordova" />

app
const isCordova = navigator.userAgent.match(/Cordova/i);