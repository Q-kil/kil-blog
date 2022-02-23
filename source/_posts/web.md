---
title: web
date: 2020-05-27 10:41:51
tags:
---

# 一个普通网站访问的过程简单概括一下，对于我们普通的网站访问，涉及到的技术就是：
- 用户操作浏览器访问，浏览器向服务器发出一个 HTTP 请求；
- 服务器接收到 HTTP 请求，Web Server 进行相应的初步处理，使用服务器脚本生成页面；
- 服务器脚本（利用Web Framework）调用本地和客户端传来的数据，生成页面；
- Web Server 将生成的页面作为 HTTP 响应的 body，根据不同的处理结果生成 HTTP header，发回给客户端；
- 客户端（浏览器）接收到 HTTP 响应，通常第一个请求得到的 HTTP 响应的 body 里是 HTML 代码，于是对 HTML 代码开始解析；
- 解析过程中遇到引用的服务器上的资源（额外的 CSS、JS代码，图片、音视频，附件等），再向 Web Server 发送请求，Web Server 找到对应的文件，发送回来；
- 浏览器解析 HTML 包含的内容，用得到的 CSS 代码进行外观上的进一步渲染，JS 代码也可能会对外观进行一定的处理；
- 用户与页面交互（点击，悬停等等）时，JS 代码对此作出一定的反应，添加特效与动画；交互的过程中可能需要向服务器索取或提交额外的数据（局部的刷新，类似微博的新消息通知），一般不是跳转就是通过 JS 代码（响应某个动作或者定时）向 Web Server 发送请求，Web Server 再用服务器脚本进行处理（生成资源or写入数据之类的），把资源返回给客户端，客户端用得到的资源来实现动态效果或其他改变。

链接：https://www.zhihu.com/question/22689579/answer/22318058

# MEAN架构
神奇的MEAN架构，MongoDB做数据库，Express做 Web Framework，Angular 做前端的 JavaScript 框架，Node.js 用于编写 Web Server。神奇之处在于这几个东西的语言都是 JavaScript （MongoDB的实现不是，但与外界沟通用的语言是）。因为是比较新的架构，还有待时间的考验，不过被很多人（尤其是靠 JavaScript 吃饭的前端程序猿们）热切关注。

# Cache-Control
## 可缓存性
no-cache
在发布缓存副本之前，强制要求缓存把请求提交给原始服务器进行验证(协商缓存验证)。
no-store
缓存不应存储有关客户端请求或服务器响应的任何内容，即不使用任何缓存。

# DNS 解析
https://dash.cloudflare.com/


# 3.0
1、统一身份认证系统
2、数据确权与授权
3、隐私保护与抗审查
4、去中心化运行

## IPFS
Inter Planetary File System 星际文件系统

# HTTP
## 测试接口/请求接口
### get
https://httpbin.org/get

### post
https://httpbin.org/post


# 框架
每一个框架都是解决历史问题。

vue和react的瓶颈：项目庞大之后的卡顿问题
vue响应式数据过多。解决：组件控制响应式
两个树数据过大。解决：react16: Fiber tree

框架的迭代最后都是算法


npm -> yarn -> pnpm