---
title: Webpack
date: 2019-11-01 12:00:14
categories:
- Webpack
tags:
- Webpack
---

# base
## rule
Rule.type 
string

可设置值: 'javascript/auto' | 'javascript/dynamic' | 'javascript/esm' | 'json' | 'webassembly/sync' | 'webassembly/async' | 'asset' | 'asset/source' | 'asset/resource' | 'asset/inline'

Rule.type 设置类型用于匹配模块。它防止了 defaultRules 和它们的默认导入行为发生。例如，如果你想 通过自定义 loader 加载一个 .json 文件，你会需要将 type 设置为 javascript/auto 以绕过 webpack 内置的 json 导入。

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

### 取别名
``` js
module.exports = function (env, argv) {
  env = env||{};
  return {
    entry: './src/js/index',
    module: {
    },
    ...conf，
    resolve: {
      alias: {
        'vue': 'vue/dist/vue.esm',
        '@': path.resolve(__dirname, './src/js/')
      }
    }
  }
}
```

### 配置
webpack.config.js
1.node:
  none    不优化
  development     输出调试信息，设置process.env.NODE_ENV
  production      最高优化，启用压缩，忽略错误

2.entry: 入口
  单入口——SPA
  多入口——MPA

``` js
module.exports = {
  mode: 'production',
  entry: {
    index: './src/index.js',
    news: './src/news.js'
  },
  output: {
    path: path.resolve(__dirname, 'dest'),
    // [name]: 会被替换，替换成entry里面的key值
    filename: '[name].js'
  }
}
```

3.output：输出
  {
    path: 路径——必须是绝对路径      path.resolve
    filename: 文件名
  }

### loader
解析js以外的东西

#### css

``` js
const path = require('path');

module.exports = {
  mode: "development",
  entry: "./src/js/index.js",
  output: {
    path: path.resolve(__dirname, 'dest'),
    filename: 'bundle.js'
  },
  // 模块; webpack 工作的时候需要其他模块帮忙
  module: {
    // 规则
    rules: [
      // 规则满足该正则，用use
      // loader 可以配合使用
      // loader 是有顺序的，从后往前执行（后面产出的结果给前面的loader）
      // css-loader: 负责读取解析，压缩css，解析出来变成js字符串
      // style-loader: 可以把样式输出到标签里面
      {test: /\.css$/i, use: ['style-loader', 'css-loader']}
    ]
  }
}
```  

postcss-loader
浏览器前缀

autoprefixer 是一个 plugins
内置了浏览器的兼容表
使用人群占用 >=5% ,就会加前缀

npx autoprefixer --info 
npx 查看包信息指令

配置 autoprefixer
1.新建文件 /.browserslistrc
``` text
last 5 version
> 1%
```
2.放到 package.json
数组里面的参数是或者关系
``` json
"browserslist": [
  "last 5 version",
  "> 1%"
]

"browserslist": [
    "> 0.5%",
    "last 1 version",
    "not dead"
  ],
```

``` js
rules: [
  {test: /\.css$/i, use: [
    'style-loader',
    'css-loader',
    // 'postcss-loader'
    // postcss.config.js 内容迁移
    {
      // postcss-loader: 加前缀
      loader: 'postcss-loader',
      options: {
        plugins: [
          // autoprefixer: 提供配置信息
          require('autoprefixer')
        ]
      }
    }
  ]}
]
```

校验css文件
stylelint-webpack-plugin

``` js
plugins: [ //plugins webpack启动的时候，plugins主动找文件；loader 加载的时候
  new styleLintPlugin({
    files: ['**/*.css', '**/*.less', '**/*.html', '**/*.vue', '**/*.scss'] //** 代表任意
    // 或者
    files: ['./src/css/**/*.css]
  })
]
```

package.json
``` json
{
  "stylelint": {
    "extends": "stylelint-config-standard" // 引入外部配置
  }
}
```




#### file
``` js
{test: /\.(jpg|png|gif)$/i, use: {
  loader: 'file-loader',
  options: {
    outputPath: 'imgs', //相对路径  相对于output.path
    publicPath: 'dest/imgs/'
  }
}}
```
http连接数越多，性能越差
优化
url-loader: 对于小文件，用base64
``` js
{test: /\.(jpg|png|gif)$/i, use: {
  loader: 'url-loader',
  options: {
    outputPath: 'imgs', //相对路径  相对于output.path
    publicPath: 'dest/imgs/',
    limit: 4*1024 //大于limit 调用file-loader
  }
}}
```

#### font
``` js
// 字体文件
{test: /\.(eot|svg|ttf|woff|woff2)$/i, use: {
  loader: 'url-loader',
  options: {
    outputPath: 'fonts/',
    publicPath: 'dest/fonts',
    limit: 4*1024
  }
}}
```

#### less
``` js
{test: /\.less$/i, use: ['style-loader', 'css-loader', 'less-loader']}
```

#### ES6
babel-loader @babel/core @babel/preset-env
``` js
rules: [
  {test: /\.js$/i, use: {
    loader: 'babel-loader',
    options: {
      presets: ['@babel/preset-env']
    }
  }}
]
```

### 浏览器调试，查看编译器前代码
``` js
module.exports = {
  mode: 'development',
  entry: {
  },
  output: {
  },
  module: {
  },
  // 开发时，便于调试
  devtool: 'source-map'
}
```

### dev-server
用于开启开发服务器
- 提供网络环境  （cookie等）
- 热更新

编译的文件在内存中

``` json
"scripts": {
    "start": "webpack-dev-server" // 靠webpack-cli 找 webpack-dev-server
  },
```

### 代码质量管理eslint

### 代码测试jest
jest-webpack的作者不再维护这个库
.babelrc
``` json
{
  "presets": [
    [
      "@babel/preset-env",
      {
        "targets": {
          "esmodules": true
        }
      }
    ]  
  ]
}
```

package.json 
``` json
{
  "scripts": {
    "test": "jest"
  },
  "dependencies": {
    "@babel/preset-env": "^7.10.4",
    "autoprefixer": "^9.8.4",
    "axios": "^0.19.2",
    "css-loader": "^3.6.0",
    "eslint": "^7.3.1",
    "eslint-loader": "^4.0.2",
    "jest": "^26.1.0",
    "jest-webpack": "^0.5.1",
    "jquery": "^3.5.1",
    "koa": "^2.13.0",
  },
  "devDependencies": {
    "babel-preset-env": "^1.7.0"
  },
  // 告诉jest 就去tests 文件找
  "jest": {
    "roots": [
      "./tests/"
    ]
  }
}
```

async.test.js
``` js
const mod = require('../src/js/async');

test('test ajax', async () => {
  expect(await mod.sum(12,5)).toBe(17);
})
```

## 完整配置
### webpack
yarn add webpack webpack-cli webpack-dev-server
css-loader style-loader
postcss-loader autoprefixer
less-loader less
file-loader url-loader
babel-loader @babel/core @babel/preset-env
html-webpack-plugin
eslint eslint-loader
stylelint stylelint-webpack-plugin stylelint-config-standard
jest jest-webpack
--dev

### package.json
``` json
"scripts": {
  "start": "webpack-dev-server --env.development",
  "build": "webpack --env.production",
  "test": "jest" // 不能jest --env.test ; 因为jest 有自己的环境变量
},
```

## Vue2.x template
yarn add vue vue-loader vue-style-loader vue-html-loader vue-template-compiler --dev

``` js
import Vue from 'vue';
import App from './App.vue';

let vm = new Vue({
  el: '#root',
  data: {},
  template: '<App/>',
  components: { // 局部注册
    App
  }
});
```


``` js
// style-loader => vue-style-loader
// 两个样式融在一起
{test: /\.css$/i, use:['vue-style-loader', 'css-loader', {
  loader: 'postcss-loader',
  options: {
    plugins: [
      require('autoprefixer')
    ]
  }
}]},
```

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

// nodejs 导入方法
const mod = require('../src/js/index');
```

## 动态配置
指定环境变量
``` zsh
$ webpack --env.producation
```

### 操作HTML
plugin

html-webpack-plugin

``` js
plugins: [
  // 能自动插入 bundel.js
  new htmlWebpackPlugin({
    // template: './index.html'
    // 因为相对路径比较麻烦，现改为绝对路径
    template: path.resolve(__dirname, '../index.html')
  })
]
```

### 搭建完整的webpack体系
package.json
``` json
"scripts": {
  "start": "webpack-dev-server --env.development",
  "build": "webpack --env.production"
},
```

webpack.config.js
``` js
const path = require('path');

module.exports = function (env, argv) {
  env = env || {development: true};

  return {
    entry: './src/js/index',
    module: {
      rules: [
        {test: /\.css$/i, use: ['style-loader', 'css-loader']},
        {test: /\.(png|jpg|gif)$/i, use: {
          loader: 'url-loader',
          options: {
            outputPath: 'imgs/',
            limit: 4*1024
          }
        }}
      ]
    },
    // 两套配置，多套用if
    ...env.production?require('./config/webpack.prod'): require('./config/webpack.dev')
  }
}
```

/config/webpack.dev.js
``` js
const path = require('path');
const htmlWebpackPlugin = require('html-webpack-plugin');

module.exports = {
  mode: 'development',
  output: {
    filename: 'bundle.js'
  },
  plugins: [
    new htmlWebpackPlugin({
      // template: './index.html'
      // 因为相对路径比较麻烦，现改为绝对路径
      template: path.resolve(__dirname, '../index.html')
    })
  ]
}
```

/config/webpack.prod.js
``` js
const path = require('path');
const htmlWebpackPlugin = require('html-webpack-plugin');

module.exports = {
  mode: 'production',
  output: {
    path: path.resolve(__dirname, '../build'),
    filename: 'bundle.min.js'
  },
  plugins: [
    new htmlWebpackPlugin({
      template: path.resolve(__dirname, '../index.html')
    })
  ]
}
```

### 文件操作
copy文件或文件目录
``` js
plugins: [
  new CopyPlugin({
    patterns: [
      { from: 'test_copy_plugin.js', to: path.resolve(__dirname, 'dest') }
    ]
  })
]
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

# plugin
## webpack-bundle-analyzer
new BundleAnalyzerPlugin()


# Error
## devtool
Q：在使用 devtool: 'source-map' 时，我编译后没有看到自己写的文件，是编译后的文件这是怎么回事呢
A：index.js.map和index.js必须在同一个目录上，以及，浏览器的sourcemap开关不能关掉（默认是开的）
