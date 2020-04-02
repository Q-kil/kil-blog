---
title: webpack-bundle-analyzer
date: 2020-04-02 20:42:31
categories:
- Tool
tags:
- webpack-bundle-analyzer
---

# 使用 Angular CLI 和 Webpack 分析包尺寸
确保包尺寸足够小（250k 或更小），并在适当的时间加载

## prod
| Flag | --dev | --prod |
| :--- | :--- | :--- |
| Environment | environment.ts  | environment.prod.ts |
| sourcempas | true  | false |

--prod 还设置了下列的设置:

+ 如果在 .angular-cli.json 中进行了配置，添加 service worker.
+ 在模块中，使用 production 替换 process.env.NODE_ENV 的值。
+ 对代码执行 UglifyJS .

## --stats-json
该参数用于生成可以使用  webpack-bundle-analyzer 或者 https://webpack.github.io/analyse  分析包结构的 stats.json 文件。

## 执行命令
``` zsh
ng build --prod --stats-json
```

## webpack-bundle-analyzer
States.json 是 Webpack 的一个特殊文件，webpack 是 Angular CLI 内部所使用的打包工具。使用 Webpack 帮我们生成的这个文件，我们可以使用各种不同的工具来理解我们的应用。

我们这里使用的工具是  Webpack bundle analyzer 。webpack 包分析器是一个 npm 包，可以在 webpack 的配置中或者命令行使用。对于我们来说，我们使用命令行工具。

为了使用这个工具，我们需要如下步骤：
1、
``` zsh
npm install --save-dev webpack-bundle-analyzer
```

2、为方便使用，安装之后，在 package.json 中的 scripts 部分，添加下面的行来创建自定义的 npm 命令
``` json
"bundle-report": "webpack-bundle-analyzer dist/angular-hello-world/stats-es2015.json"
```

3、执行命令
``` zsh
npm run bundle-report
```
途中的每种颜色代表一个独立的包。在这个图中，可以看到我们有三个包，vendor 中包含所有的库代码，polyfill 包和 main 应用代码包。我们可以近一半查看未压缩和压缩之后的尺寸。这使得我们快速检查最大的包，并帮助我们决定何时使用 Lazy Loading 进一步拆分应用。




