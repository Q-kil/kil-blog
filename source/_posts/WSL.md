---
title: WSL
date: 2020-02-23 22:26:23
categories:
- Tool
tags:
- WSL
---

## 效果
{% asset_img seven_pc.png %}

## 安装失败
设置子系统失败
{% asset_img wsl_error1.png %}
{% asset_img wsl_error2.png %}

也没有商店

{% asset_img wsl_win_old.png %}
猜测windows企业版本问题, 重装专业版

## 安装成功
### 开启子系统
Windows设置主页 搜索：启用或关闭Windows功能
勾选
- [x] 适用于 Linux 的 Windows 子系统

### 设置开发者权限
Windows设置主页 搜索：开发者选项
勾选
- [x] 开发人员模式

### 商店下载
商店搜索：ubuntu
安装第一个

### vscode
安装插件：Remote - WSL


## 环境
### node环境变量配置 （安装的包 无法使用）
``` zsh
$ tsc
zsh: command not found: tsc
```

``` zsh
$ sudo vi ~/.zshrc
// 添加
export NODE_HOME=/home/kil/.npm-global
export PATH=$NODE_HOME/bin:$PATH
$ source ~/.zshrc
$ tsc -v
Version 3.8.2
```

seven:
那你要把home目录的 node_module 加到path里
node_module 里应该有个bin目录
把那个目录加到你path里
你看看global的模块目录在哪
You can run npm list -g to see which global libraries are installed and where they're located. 
那你应该在 .zshrc里export
[When I use ZSH, how do I set PATH in /etc/profile.d?](https://askubuntu.com/questions/476246/when-i-use-zsh-how-do-i-set-path-in-etc-profile-d)

