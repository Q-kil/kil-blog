---
title: Webpack
date: 2019-11-01 12:00:14
categories:
- Webpack
tags:
- Webpack
---

# learn
webpack 能完成所有常用的功能
- 压缩
- 打包
- 多种文件的编译
- 脚手架
- 生成

## 前面
### 在线
1.引入browser
2.type=“text/babel”

### node
npm
1.安装node
2.安装babel
  npm i @babel/core @babel/cli @babel/preset-env
  npm i @babel/polyfill
3.添加脚本
  “build”：“babel src -d dest"
  -d 往哪输出
  src > demo.js
  ``` js
  let a = 1;
  ```
4.添加配置
  {
    "presets": [
      "@babel/preset-env"
    ]
  }
5.执行
  npm run build

## 基础知识
module.exports = {

}
CMD 写法

## 模块化
export 输出

webpack.config.js
``` js
const path = require('path');

module.exports = {
  // 编译的模式
  mode: 'development',
  // 入口文件，以该文件为起点文件
  entry: './js/index.js',
  // 出口文件；json格式
  output: {
    // 要放到哪去
    // './build/ 当前目录的build文件下
    // 必须使用绝对路径，相对路径容易出问题
    // resolve (解析) 可以把路径解析为绝对路径
    path: path.resolve(__dirname, 'build'),
    // 打包之后的文件叫 bundel
    filename: 'bundle.js'
  }
}
```

魔术变量
__dirname: 当前文件所在目录
__filename: 当前运行文件的文件名

### 导出（export）
变量
export let a=12;

多个变量
let a,b,c = ...;
export {a,b,c..};

函数
export function show() {
  ...
}

class
export class Person {

}

#### 默认成员
export default

引入
import mod1 from './mod1' = import default as from './mod1'

### 导入（import）
``` js
import * as mod1 from 'xxx';    引入所有成员
import mod1 from 'xxx';         引入default成员

import {a, b as name2} from './mod1';

// 只引入
import 'xxx';

// 异步引入
let p = import('./mod1');
```



# seven 搭建angular webpack配置
``` js
const path = require('path');
const CopyWebpackPlugin = require('copy-webpack-plugin');
const {AngularCompilerPlugin} = require("@ngtools/webpack");
const rxPaths = require("rxjs/_esm5/path-mapping");
const {IndexHtmlWebpackPlugin} = require("@angular-devkit/build-angular/src/angular-cli-files/plugins/index-html-webpack-plugin");

module.exports = {
  mode: 'development',

  devtool: 'source-map',

  target: "web",

  entry: {
    polyfills: './src/polyfills.ts',
    vendor: './src/vendor.ts',
    main: './src/main.ts'
  },
  output: {
    path: path.resolve("./dist"),
    filename: "[name].js"
  },

  resolve: {
    extensions: ['.ts', '.js'],
    alias: Object.assign(rxPaths(), {
      pixi: path.join(__dirname, 'node_modules/pixi.js/dist/pixi.js'),
      dragonBones: path.join(__dirname, 'src/libs/dragonBones/dragonBones.js')
    })
  },
  performance: {
    hints: false,
  },
  module: {
    rules: [
      {
        test: /\.(png|jpe?g|gif|svg|woff|woff2|ttf|eot|dbbin|ico)$/,
        loader: 'file-loader?name=assets/[name].[hash].[ext]'
      },
      {
        test: /\.ts$/,
        use: ['awesome-typescript-loader', 'angular2-template-loader'],
        exclude: '/node_modules/'
      },
      {
        test: /\.html$/,
        use: 'html-loader'
      },
      {
        test: /\.scss$/,
        exclude: [/\.global\.scss$/],
        use: ['to-string-loader', 'sass-loader']
      },
      {
        test: /\.global\.scss$/,
        use: [
          'style-loader',
          'sass-loader'
        ]
      },
      {
        type: 'javascript/auto',
        test: /\.json$/,
        loader: 'file-loader?name=assets/[name].[hash].[ext]'
      },
      // This hides some deprecation warnings that Webpack throws
      {
        test: /[\/\\]@angular[\/\\]core[\/\\].+\.js$/,
        parser: {system: true},
      },
      {test: /pixi\.js$/, loader: 'expose-loader?PIXI'},
      {test: /dragonBones\.js$/, loader: 'expose-loader?dragonBones'}
    ]
  },

  plugins: [
    new IndexHtmlWebpackPlugin({
      input: "./index.html",
      output: "index.html",
      entrypoints: [
        "vendor",
        "polyfills",
        "main"
      ]
    }),
    new AngularCompilerPlugin({
      mainPath: path.resolve("./src/main.ts"),
      sourceMap: true,
      nameLazyFiles: true,
      tsConfigPath: path.resolve("./src/tsconfig.app.json"),
      skipCodeGeneration: true,

    }),
    new CopyWebpackPlugin([
      {
        from: 'src/assets',
        to: 'assets'
      },
      {
        from: 'src/favicon.ico'
      }
    ]),
  ],
  devServer: {
    historyApiFallback: {
      disableDotRule: true,
    }
  }
}
```

## scss 问题
<font color="#FF0000">
ERROR in ./src/app/page/home/home.component.scss
You may need an additional loader to handle the result of these loaders.
> p {
|   color: #f00; }
</font>

解决：添加 css-loader
``` js
{
  test: /\.scss$/,
  exclude: [/\.global\.scss$/],
  use: ['to-string-loader', 'css-loader', 'sass-loader']
}
```

# 模块热替换(hot module replacement 或 HMR)
``` js
const webpack = require('webpack');

module.exports = {
  mode: 'development',
        from: 'src/favicon.ico'
      }
    ]),

    new webpack.HotModuleReplacementPlugin() // 新增
  ],

  devServer: {
    host: '0.0.0.0',
    port: 8080,
    hot: true, // 新增
    hotOnly: true, // 新增
    historyApiFallback: {
      disableDotRule: true,
    }
  }
```


