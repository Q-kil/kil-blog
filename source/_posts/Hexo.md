---
layout: hexo
title: Hexo
date: 2019-10-18 17:13:21
categories:
- Frame
tags:
- Hexo
---

[Hexo](https://hexo.io/zh-cn/)在去年和阿通就已经搭建好了，一直没正式用过。今天看到了iissnan博主的博客站，以及最近小莫说写些技术文章，现在觉得可以用起来，写一些高质量的技术文章和记录一下生活的点滴。

## 此博客站Hexo的主题
cd 项目目录路径

自定义主题 git clone https://github.com/iissnan/hexo-theme-next.git

打开当前目录下的“_config.yml”配置文件，找到theme的配置选项，设置为：theme: next

选择 Scheme主题改样式，themes > next > _config.yml 改为 scheme: Pisces

<!-- more -->

## 基础设置
语言：language: zh-Hans
avatar: 在主题模版的设置文件 _config.yml 找到avatar 字段
头像下面的签名：在根目录的设置文件 _config.yml 找到description 字段
阅读全文：
a. 手动截断 {% label ib_green@推荐 %}
``<!-- more -->``
b. 自动形成摘要，在{% label ib_purple@主题配置文件 %}中添加
```
auto_excerpt:
  enable: true
  length: 150
```
文字增加背景色块：
文件位置  `` ~themes/next/source/css/_custom/custom.styl``
``` 
// 添加色系 span.ib_green (ib = inline-block)
{% label ib_green@推荐1 %}
{% label ib_yellow@推荐1 %}
{% label ib_blue@推荐1 %}
{% label ib_purple@推荐1 %}
```
效果 
{% label ib_green@推荐1 %}
{% label ib_yellow@推荐1 %}
{% label ib_blue@推荐1 %}
{% label ib_purple@推荐1 %}

文字加粗 **ng-book2-angular8**
```
**ng-book2-angular8**
```

转义标记 `<app-user-list>`
```
`<app-user-list>`
```


### 分类
#### 生成“分类”页并添加tpye属性
``` 
$ hexo new page categories
成功后
INFO  Created: ~/Documents/blog/source/categories/index.md
```
找到index.md文件，默认内容是这样：
```
---
title: 文章分类
date: 2017-05-27 13:47:40
---
```
添加type: "categories"到内容中，添加后是这样的：
```
---
title: 文章分类
date: 2017-05-27 13:47:40
type: "categories"
---
```
#### 给文章添加“categories”属性
打开需要添加分类的文章，为其添加categories属性。下方的categories: web前端表示添加这篇文章到“web前端”这个分类。注意：hexo一篇文章只能属于一个分类，也就是说如果在“- web前端”下方添加“-xxx”，hexo不会产生两个分类，而是把分类嵌套（即该文章属于 “- web前端”下的 “-xxx ”分类）。
```
---
title: jQuery对表单的操作及更多应用
date: 2017-05-26 12:12:57
categories: 
- web前端
---
```
至此，成功给文章添加分类，点击首页的“分类”可以看到该分类下的所有文章。当然，只有添加了categories: xxx的文章才会被收录到首页的“分类”中。

### 标签
#### 生成“标签”页并添加tpye属性
```
$ hexo new page tags
成功后
INFO  Created: ~/Documents/blog/source/tags/index.md
```
找到index.md文件，默认内容是这样：
```
---
title: 标签
date: 2017-05-27 13:47:40
---
```
添加type: "tags"到内容中，添加后是这样的：
```
---
title: 文章分类
date: 2017-05-27 13:47:40
type: "tags"
---
```

#### 给文章添加“tags”属性
打开需要添加标签的文章，为其添加tags属性。下方的tags:下方的- jQuery - 表格 - 表单验证就是这篇文章的标签了
```
---
title: jQuery对表单的操作及更多应用
date: 2017-05-26 12:12:57
categories: 
- web前端
tags:
- jQuery
- 表格
- 表单验证
---
```
至此，成功给文章添加分类，点击首页的“标签”可以看到该标签下的所有文章。当然，只有添加了tags: xxx的文章才会被收录到首页的“标签”中。

细心的朋友可能已经发现，这两个的设置几乎一模一样！是的，没错，思路都是一样的。所以我们可以打开scaffolds/post.md文件，在tages:上面加入categories:,保存后，之后执行hexo new 文章名命令生成的文件，页面里就有categories:项了。

## 指令
### 启动
``` BASH
$ hexo s
```

### 发布
```
hexo clean
hexo g
hexo d
```

### 创建新文件
``` BASH
$ hexo new Linux
```

## 部署
### blog根目录 _config.yml 配置
```
deploy:
  type: git
  repo: 'https://github.com/KilFront/KilFront.github.io.git'
  branch: master
```  

### github  kilfront.github.io根目录添加文件 CNAME
```
www.kaifa.in
```

### 解析记录
CNAME kilfront.github.io

### ！需要注意 缓存问题；新建无痕浏览 可以


## 博客迁移
再给家里的电脑搭建环境时，主题 和 样式 未能显示。
原因：子模块不允许提交
解决：
在主项目 source 文件 新建 _data 文件
next.yml 中 粘贴主题文件_config.yml代码
custom.text 中 存放样式代码
