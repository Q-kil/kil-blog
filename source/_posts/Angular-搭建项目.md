---
title: 搭建Angular项目
date: 2019-10-19 13:27:02
categories:
- Angular
tags:
- Angular
---

[不使用angular-cli搭建项目](https://www.jianshu.com/p/8c09f26251a9)

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
$ yarn add @angular/core @angular/common @angular/platform-browser @angular/platform-browser-dynamic @angular/compiler
```
{% post_link Angular依赖包 依赖包详情 %}

``` BASH
$ yarn add --dev @angular/cli
```
使用ng 指令(快速构建项目)；首次使用需要配置 angular.json 文件

#### 手动添加 angular.json 配置
``` json
{
  "$schema": "./node_modules/@angular/cli/lib/config/schema.json",
  "version": 1,
  "newProjectRoot": "projects",
  "projects": {
    "pkt-homepage": {
      "projectType": "application",
      "schematics": {
        "@schematics/angular:component": {
          "style": "scss"  // ng g c  自动生成.scss 文件，不需要修改css文件名了
        }
      },
      "root": "",
      "sourceRoot": "src",
      "prefix": "app",
      "architect": {
        "build": {
          "builder": "@angular-devkit/build-angular:browser",
          "options": {
            "outputPath": "dist/pkt-homepage",
            "index": "src/index.html",
            "main": "src/main.ts",
            "polyfills": "src/polyfills.ts",
            "tsConfig": "tsconfig.app.json",
            "aot": true,
            "assets": [
              "src/favicon.ico",
              "src/assets"
            ],
            "styles": [
              "src/styles.scss"
            ],
            "scripts": []
          },
          "configurations": {
            "production": {
              "fileReplacements": [
                {
                  "replace": "src/environments/environment.ts",
                  "with": "src/environments/environment.prod.ts"
                }
              ],
              "optimization": true,
              "outputHashing": "all",
              "sourceMap": false,
              "extractCss": true,
              "namedChunks": false,
              "extractLicenses": true,
              "vendorChunk": false,
              "buildOptimizer": true,
              "budgets": [
                {
                  "type": "initial",
                  "maximumWarning": "2mb",
                  "maximumError": "5mb"
                },
                {
                  "type": "anyComponentStyle",
                  "maximumWarning": "6kb",
                  "maximumError": "10kb"
                }
              ]
            }
          }
        },
        "serve": {
          "builder": "@angular-devkit/build-angular:dev-server",
          "options": {
            "browserTarget": "pkt-homepage:build"
          },
          "configurations": {
            "production": {
              "browserTarget": "pkt-homepage:build:production"
            }
          }
        },
        "extract-i18n": {
          "builder": "@angular-devkit/build-angular:extract-i18n",
          "options": {
            "browserTarget": "pkt-homepage:build"
          }
        },
        "test": {
          "builder": "@angular-devkit/build-angular:karma",
          "options": {
            "main": "src/test.ts",
            "polyfills": "src/polyfills.ts",
            "tsConfig": "tsconfig.spec.json",
            "karmaConfig": "karma.conf.js",
            "assets": [
              "src/favicon.ico",
              "src/assets"
            ],
            "styles": [
              "src/styles.scss"
            ],
            "scripts": []
          }
        },
        "lint": {
          "builder": "@angular-devkit/build-angular:tslint",
          "options": {
            "tsConfig": [
              "tsconfig.app.json",
              "tsconfig.spec.json",
              "e2e/tsconfig.json"
            ],
            "exclude": [
              "**/node_modules/**"
            ]
          }
        },
        "e2e": {
          "builder": "@angular-devkit/build-angular:protractor",
          "options": {
            "protractorConfig": "e2e/protractor.conf.js",
            "devServerTarget": "pkt-homepage:serve"
          },
          "configurations": {
            "production": {
              "devServerTarget": "pkt-homepage:serve:production"
            }
          }
        }
      }
    }},
  "defaultProject": "pkt-homepage"
}

```

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

brew upgrade yarn

## ng
ng update @angular/cli@8 @angular/core@8

ng update @angular/core --next --force (更新了angular相关依赖 到8.0)

cms 更新
ng update @angular/core@^9.1.0 --force

## 修改
ViewChild => @ViewChild('foo', {static: false}) foo !: ElementRef;

## 重新安装
node-sass

## 卸载
@angular/cdk@8.0.0

## 升级到10
yarn remove @angular/cli
yarn add @angular/cli@10.0.2 --dev

https://update.angular.io/#8.0:10.0

## 2020.10.21 升级方法
### 7.0 -> 9.1
yarn remove @angular/animations @angular/common @angular/compiler @angular/core @angular/forms @angular/platform-browser @angular/platform-browser-dynamic @angular/router

yarn add @angular/animations@9.1 @angular/common@9.1 @angular/compiler@9.1 @angular/core@9.1 @angular/forms@9.1 @angular/platform-browser@9.1 @angular/platform-browser-dynamic@9.1 @angular/router@9.1

yarn remove @angular/compiler-cli @angular/language-service

yarn add  @angular/compiler-cli@9.1 @angular/language-service@9.1 --dev

yarn remove typescript

yarn add typescript@3.8.0 --save

# 游戏编辑器
## layout
### router
``` ts
{
  path: "",
  redirectTo: "/home",
  pathMatch: "full"
},
{
  path: "",
  component: LoginLayoutComponent,
  children: [
    {
      path: "login",
      loadChildren: "./pages/login/login.module#LoginModule"
    }
  ]
},
{
  path: "",
  component: AppLayoutComponent,
  children: [
    {
      path: "home",
      canActivate: [AuthGuardService],
      loadChildren: "./pages/home/home.module#HomeModule"
    }
  ]
}
```
### bare
``` html
<router-outlet></router-outlet>
```

### full
``` html
<app-header></app-header>
<router-outlet></router-outlet>
<app-footer></app-footer>
```

## primeNG
``` zsh
npm install primeng --save
npm install primeicons --save
```

angular.json
```
"node_modules/primeng/resources/themes/saga-blue/theme.css",
"node_modules/primeng/resources/primeng.min.css",
"node_modules/primeicons/primeicons.css"
```
### button
``` html
<p-button label="Submit"></p-button>
```

app.module.ts
``` ts
imports: [
  BrowserModule,
  AppRoutingModule,
  ButtonModule
]
```

### overlay
#### overlayPanel
``` html
<p-overlayPanel #op>
  sdsds
</p-overlayPanel>
```

### form
#### listbox
``` html
<p-listbox [options]="cities" optionLabel="name"></p-listbox>
```

### icon
``` html
<i class="pi pi-check" style="font-size: 2rem"></i>
```

## scss
``` scss
#home {
  height: calc(100% - #{$TQ-app-header-height} - #{$TQ-app-footer-height});
}
```

## html
### ng-container
ng-container 最后不现实，省了一层div
``` html
<main id="main">
    <ng-container *ngIf="selectedMenuId !== 'Suit'; else elementSuit">
      <p-tabView styleClass="TQ-tabview">
```

## router
### params


# CMS
## dialog
``` html
<nz-modal [(nzVisible)]="banIsVisible" nzTitle="The first Modal" (nzOnCancel)="handleCancel()"
  (nzOnOk)="handleOk()">
  <p>Content one</p>
  <p>Content two</p>
  <p>Content three</p>
  <p>Content three</p>
</nz-modal>
```