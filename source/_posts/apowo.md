---
title: apowo
date: 2020-06-22 13:46:28
tags:
---

# tooqing-webapp


# APP
## 解决异形屏适配问题（全屏模式下显示）

## 判断cordova or web-browser
cordova
<preference name="AppendUserAgent" value="Cordova" />

app
const isCordova = navigator.userAgent.match(/Cordova/i);

# 用到的库
## vue-infinite-loading

## qiniu-js
### upload
返回
total: 包含loaded、total、percent三个属性:
total.loaded: number，已上传大小，单位为字节。
total.total: number，本次上传的总量控制信息，单位为字节，注意这里的 total 跟文件大小并不一致。
total.percent: number，当前上传进度，范围：0～100。