---
title: 搭建Angular项目
date: 2019-10-19 13:27:02
categories:
- Angular
tags:
- Angular
---

### 初始化
``` bash
$ mkdir angular_website && cd angular_website
$ yarn init
```
得到package.json 文件
``` json
{
  "name": "angulectron",
  "version": "1.0.0",
  "main": "index.js",
  "license": "MIT"
}
```

### 添加基础依赖
``` BASH
$ yarn add @angular/core @angular/common @angular/platform-browser @angularplatform-browser-dynamic @angular/compiler
```
{% post_link Angular依赖包 依赖包详情 %}

``` BASH
$ yarn add --dev @angular/cli
```
使用ng 指令(快速构建项目)；首次使用需要配置 angular.json 文件

### 添加基础文件
``` BASH
$ mkdir src/app
$ ng g m app --flat && ng g c app --flat
```

- polyfills.ts文件 [浏览器支持]

### seven webpack 打包 angular 安装的依赖包
``` bash
$ yarn add webpack@^4.25.1 webpack-cli@^3.1.2 webpack-dev-server@^3.1.10 copy-webpack-plugin@^4.6.0 --dev
```

``` bash
$ yarn add @ngtools/webpack@^7.1.3 --dev
```

``` bash
$ yarn add awesome-typescript-loader@^5.2.1 angular2-template-loader@^0.6.2 --dev
```

``` bash
yarn add html-loader@^0.5.5 to-string-loader@^1.1.5 sass-loader@^7.1.0 --dev
```

### import HeaderModule not resolve
<font color="#FF0000"> Module not found: Error: Can't resolve '@common/header/header.module' in '/Users/niekaifa/workspace/htyy/htyy_website/src/app/page/home' </font>

原因：编译后 path 路径 不对，没有解析到 
解决：
tsconfig.json 添加paths 配置
``` js
"paths": {
  "@common/*": [
    "src/app/common/*"
  ]
}
```

home.component.ts 路径
``` js
import { HeaderModule } from 'src/app/common/header/header.module';
update
import { HeaderModule } from '@common/header/header.module';
```

### remove _nghost-sfi-c0
``` js
@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.scss'],
  encapsulation: ViewEncapsulation.None
})
```

### 资源的相对路径 与 绝对路径
tsconfig.js 设置
``` js 
{
  "compileOnSave": false,
  "compilerOptions": {
    "baseUrl": "src",
    "outDir": "./dist/out-tsc",
    "sourceMap": true,
    "declaration": false,
    "module": "es2015",
    "moduleResolution": "node",
    "emitDecoratorMetadata": true,
    "experimentalDecorators": true,
    "importHelpers": true,
    "target": "es5",
    "typeRoots": [
      "node_modules/@types"
    ],
    "lib": [
      "es2018",
      "dom"
    ],
    "paths": {
      "@common/*": [
        "app/common/*"
      ]
    },
  }
}
```

# 优化点
- <app-game> to <game>   angular.json: "prefix": "app",

# css to scss
### [组件]把CSS预编译改成SASS
方式一
创建项目时指定 scss

方式二
+ angular-cli.json 里面的 styleExt 改成 scss
+ angular-cli.json 里面的 styles.css 后缀改成 .scss
+ src 下面 style.css 改成 style.scss
+ app.component.scss
+ app.component.ts 里面对应修改


### 第二中方法
#### 将默认样式扩展名更改为 scss
``` BASH
$ ng config defaults.styleExt=scss
```
如果出现错误：请Value cannot be found.使用以下命令：
``` BASH
$ ng config schematics.@schematics/angular:component.styleext scss
```

或手动 添加到 angular.json
``` json
{
  "schematics": {
    "@schematics/angular:component": {
      "styleext": "scss"       
    } 
  }
}
```

#### 将 .css 文件重命名 .scss
app  && webpack

#### 创建项目时设置
``` BASH
ng new your-project-name --style=scss
```

如果要为以后创建的所有项目设置默认值，执行
``` bash
ng config --global defaults.styleExt=scss
```

# 版本升级
error @angular-devkit/architect@0.900.0: The engine "yarn" is incompatible with this module. Expected version ">= 1.13.0". Got "1.12.3"
error Found incompatible module


