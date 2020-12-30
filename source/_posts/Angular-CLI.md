---
title: Angular-CLI
date: 2019-10-21 21:33:49
categories:
- Angular
tags:
- Angular-CLI
---

# 把所有零散的Node工具都集成起来
## cli 背景
在很早的时候，前端是没有好的工具，开发，测试，打包，部署，压缩
2009年，出现nodejs，前端Big Bang；以前都是刀耕火种


## 集成工具
- webpack
- typeScript编译器
单元测试
- karma
- jasmine
- Protractor 自动测试所有路由
- material.angular.io ui

最后集成一个angular.json

# 指令
``` zsh
ng version
```

``` BASH
$ ng g c app
CREATE src/app/app/app.component.ts (257 bytes)
已有app文件，使用此指令依然创建app文件

正确方法：
ng g c app --flat
CREATE src/app/app.component.ts (257 bytes)
默认不创建文件夹，在已有app文件下
```

### 本地版本升级 6 -> 7
``` BASH
$ npm uninstall -g @angular/cli
$ npm install -g @angular/cli@7.x.x
$ ng -v
```

# 修改默认4200端口
It seems things have changed in recent versions of the CLI (I'm using 6.0.1). I was able to change the default port used by ng serve by adding a port option to my project's `angular.json`:
``` json
{
    "$schema": "./node_modules/@angular/cli/lib/config/schema.json",
    "projects": {
        "my-project": {
            "architect": {
                "serve": {
                    "options": {
                        "port": 4201
                    }
                }
            }
        }
    }
}
```

# angular.json
Angular CLI 6+
angular-cli.json -> angular.json
这种变化主要还是因为Angular CLI引入了 monorepo (一个空间管理多个项目) 的开发模式，即使用ng new出来的相当于一个大的工作空间，通过angular.json配置来管理各种ng generate application | library出来的项目或组件库。
但是其实大多数人还是一个工作空间维护一个项目，所以这个在这里不那么重要，只是想说json文件的改变是为了新的模式而已。

## $schema
指向一个 JSON Schema 文件，这个文件描述了angular.json所有的字段以及约束。
其实可以比作一个有“类型提示”功能文件，只要支持了这个功能的 IDE 或编辑器，在书写angular.json文件时便会给出相应的提示。

## projects
放置所有项目的配置。其中一个项目为一个子项，如xxxx为一个项目，在创建时自动生成。
``` json
{
    "projects": {
        "xxxx": {
            "root": "",
            "sourceRoot": "src",
            "projectType": "application",
            "prefix": "app",
            "schematics": {},
            "architect": {}
        }
    }
}
```

## root
代表项目的“根目录”，也就是项目所在的位置，或者说项目源码的父级目录。项目的根目录包含了一些特定的配置。

## sourceRoot
项目源码所在的目录，通常默认使用src目录。

## prefix
使用ng generate component | directive生成组件或者指令时默认的selector前缀，通常我们使用命令创建的组件或指令都是app-xxx格式，我们可以手动在这里改动，使整个项目生效。

## architect
包含几组CLI相关的项目自动化命令配置，比如本地运行、编译、测试等等。默认预设了几组命令配置如build、serve等等：
``` json
{
    "architect":{
        "build":{},
        "serve":{},
        "extract-i18n":{},
        "test":{},
        "lint":{}
    }
}
```

### 配置属性
每一个配置项都有 3 个字段属性：builder，options，configurations，例如默认的build命令配置:
``` json
{
    "architect": {
        "build": {
            "builder": "@angular-devkit/build-angular:browser",
            "options": {
                "outputPath": "dist/testApp",
                "index": "src/index.html",
                "main": "src/main.ts",
                "polyfills": "src/polyfills.ts",
                "tsConfig": "src/tsconfig.app.json",
                "assets": [
                    "src/favicon.ico",
                    "src/assets"
                ],
                "styles": [
                    "src/styles.css"
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
                     "aot": true,
                     "extractLicenses": true,
                     "vendorChunk": false,
                     "buildOptimizer": true
                  }
              }
          }
      }
}
```
这个是项目默认生成的配置。

builder代表要执行的内置程序，因为CLI内置了一些自动化工具，architect只是提供了一个facade模式（通俗地讲，就是开发者不需要知道内部的复杂实现）给开发者配置使用，本质上还是调用的内置工具。

options代表针对当前builder要配置的配置项，调用不同的内置程序，是需要传对应的配置项的，由于配置项很多，这里也不会列出。

configurations代表这个命令的多种调用模式，在此配置里，我们可以定义不同的别名，然后使用不同的配置（配置的字段还是属于options里的），最后在使用命令时便可以手动选择不同的模式。

### 如何使用
CLI其实内置了几个快捷命令来对应默认生成的配置如ng serve、ng build等等，如果是我们额外自定义的配置，则可以使用ng run <project>:<architect>[:configurations] [其他配置]
命令来实现，其中project和architect为必填，configurations为选填。

比如我们简单额外自定义一个本地运行的服务器命令：
``` json
{
    "architect":{
        "myServe":{
            "builder": "@angular-devkit/build-angular:dev-server",
            "options": {
                "browserTarget": "xxxx:build",
                "port": 8800
            },
            "configurations": {
                "port1": {
                    "port": 8801
                },
                "port2": {
                    "port": 880
                }
            }
        }
    }
}
```
配置使用了内置的运行本地服务器程序，然后使用默认的build配置，加上自定义的运行端口，另外加上两个不同模式，运行不同端口。

使用ng run xxxx:myServe可以正常运行本地服务器跑项目，端口是8800
使用ng run xxxx:myServe:port1端口是8801

当然，我们还可以直接使用额外的命令行配置直接覆盖已经定义的配置：
ng run xxxx:myServe:port1 --port=8808

这里的例子只是为了简单了解下architect的用法。

### builder
builder:angular.json:
默认的配置是@angular-devkit/build-angular:browser,这个是angular内部的配置,
换成@angular-builders/custom-webpack就可以使用自定义的配置,配置只接受browser|server|karma|dev-server这四个选项
customWebpackConfig.path:自定义的webpack的路径



## defaultProject
默认项目，当使用一些CLI命令没有指定项目名称时，默认指向的项目。