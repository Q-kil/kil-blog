---
title: eslint
date: 2020-06-16 15:58:45
categories:
- guide
tags:
- ESLint
---

# 基础
eslint: 代码检测工具
## 格式
``` js
rules: {
  "规则名": [规则值, 规则配置]
}
```

## 规则值
``` json
"off"或者0    //关闭规则关闭
"warn"或者1    //在打开的规则作为警告（不影响退出代码）
"error"或者2    //把规则作为一个错误（退出代码触发时为1）
```



# 配置参数
``` json
"no-trailing-spaces": 1, //一行结束后面不要有空格
"semi": [1, "always"], //语句分号结尾
"console":"off", //禁用 console
"quotes": [1, "single"], // 字符串单引号
"object-curly-spacing": [0, "always"], //大括号内允许不必要的空格
"eqeqeq": 1, // 使用全等
```

更多配置参数[直达](https://www.jianshu.com/p/bfc7e7329cff);

# javaScript
变量推荐驼峰式命名法

# css
推荐使用中划线进行连接，CSS 语法本身就使用连字号作为连接（比如 font-family，text-align等）。
``` html
<a class="btn btn--big btn--orange" href="https://css-tricks.com">
  <span class="btn__price">$9.99</span>
  <span class="btn__text">Subscribe</span>
</a>
```


# 目录
由于Windows, OSX下文件名不区分大小写(linux是区分的)，所以命名我们建议还是以全部小写为主。
`my-project-name`

### 子目录
项目中的子目录一般按照作用，使用常用单词表示，有复数的情况，使用复数命名法，比如: scripts, styles, images和data-modules

### 文件命名
-中划线
但是linux系统文件推荐的文件命名一般是下划线。

# 配合vs code
### 保存文件后自动删除多余空格
设置中搜索files.trimTrailingWhitespace，然后将选项勾选即可

# Prettier
[Prettier](https://prettier.io/docs/en/options.html#end-of-line);

# vue cli 默认值
``` json
"eslintConfig": {
  "root": true,////此项是用来告诉eslint找当前配置文件不能往父级查找
  "env": {
    "node": true//此项指定环境的全局变量，下面的配置指定为node环境
  },
  "extends": [// 此项是用来配置vue.js风格，就是说写代码的时候要规范的写，如果你使用vs-code我觉得应该可以避免出错
    "plugin:vue/essential",
    "@vue/standard"
  ],
  "rules": {//规则配置写在这里
    "indent": [1, 4]
  },
  "parserOptions": {
    "parser": "babel-eslint"//此项是用来指定eslint解析器的，解析器必须符合规则，babel-eslint解析器是对babel解析器的包装使其与ESLint解析
  }
}
```

### 关闭
#### vue
把 build/webpack.base.conf.js 配置文件中的eslint rules注释掉即可。
``` js
const createLintingRule = () => ({
  // test: /\.(js|vue)$/,
  // loader: 'eslint-loader',
  // enforce: 'pre',
  // include: [resolve('src'), resolve('test')],
  // options: {
  //   formatter: require('eslint-friendly-formatter'),
  //   emitWarning: !config.dev.showEslintErrorsInOverlay
  // }
})
```