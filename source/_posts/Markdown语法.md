---
title: Markdown语法
date: 2019-10-19 13:39:21
categories:
- Markdown
tags:
---
# basic
序言
Markdown是一种轻量级标记语言

转义
```
`` 特殊的文本 (例：<!-- more -->) ``
```

引用站内文章
```
{% post_link Angular依赖包 依赖包详情 %}
```

[马克飞象](https://maxiang.io/)
[Hexo语法](https://hyxxsfwy.github.io/2016/01/15/Hexo-Markdown-%E7%AE%80%E6%98%8E%E8%AF%AD%E6%B3%95%E6%89%8B%E5%86%8C/)

# 掘金语法
---
# 主题列表：juejin, github, smartblue, cyanosis, channing-cyan, fancy, hydrogen, condensed-night-purple, greenwillow, v-green, vue-pro, healer-readable, mk-cute, jzman, geek-black, awesome-green, qklhk-chocolate
# 贡献主题：https://github.com/xitu/juejin-markdown-themes
theme: healer-readable
highlight: vs2015
---

# 标题

# 一级标题
## 二级标题
### 三级标题

# 列表
- 支持自定义样式的 Markdown 编辑器
	+ sdfs
    	* 122
- 支持微信公众号、知乎和稀土掘金
- 欢迎扫码回复「排版」加入推文群

# 文字变形
粗体：**test**
斜体：*test*
代码块：`test`

# 链接
[百度](https://www.baidu.com);

# 图片
![](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/eca74e8d697b422fb0d8a7d2bf825698~tplv-k3u1fbpfcp-zoom-1.image)

# 复选框
- [ ] test
- [x] test

# 引言
> tets
> test

# 分割线

可以在一行中用三个以上的减号来建立一个分隔线，同时需要在分隔线的上面空一行。如下：

---

# 删除线

删除线的使用，在需要删除的文字前后各使用两个`~`，如下：

~~这是要被删除的内容。~~

# 表格

可以使用冒号来定义表格的对齐方式，如下：

| 姓名       | 年龄 |         工作 |
| :--------- | :--: | -----------: |
| 小可爱     |  18  |     吃可爱多 |
| 小小勇敢   |  20  |   爬棵勇敢树 |
| 小小小机智 |  22  | 看一本机智书 |

宽度过长的表格可以滚动，可在自定义主题中调节宽度：

| 姓名       | 年龄 |         工作 |      邮箱       |    手机     |
| :--------- | :--: | -----------: | :-------------: | :---------: |
| 小可爱     |  18  |     吃可爱多 | lovely@test.com | 18812345678 |
| 小小勇敢   |  20  |   爬棵勇敢树 | brave@test.com  | 17712345678 |
| 小小小机智 |  22  | 看一本机智书 | smart@test.com  | 16612345678 |

# 代码
```java
// FileName: HelloWorld.java
public class HelloWorld {
  // Java 入口程序，程序从此入口
  public static void main(String[] args) {
    System.out.println("Hello,World!"); // 向控制台打印一条语句
  }
}
```

```javascript
console.log('test');
```

```html
<h5>test</h5>
```

# diff
diff 不能同时和其他语言的高亮同时显示，且需要调整代码主题为微信代码主题以外的代码主题才能看到 diff 效果，使用效果如下:

```diff
+ 新增项
- 删除项
```

# 其他
@(示例笔记本) [马克飞象|帮助|Markdown]

请使用 **Chrome** 浏览器。

请阅读下方文本熟悉工具使用方法，本文可直接拷贝到微信中预览。