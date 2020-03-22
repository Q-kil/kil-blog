---
title: Windows
date: 2020-02-23 18:56:38
categories:
- Windows
tags:
- Windows
---

## 指令
### 进入D盘
```
d:
```

### 查看文件夹里面的内容
``` 
dir
```

### 查看文件内容
```
type id_rsa.pub
```

## 快捷键
<span class="custom_red">win + I</span> windows设置主页

### 回到桌面
`win + D`

### 截图
Print Screen 屏幕截图键
PRINT SCREEN SYSRQ

### Chrome
打开新的标签页，并跳转到该标签页
`Ctrl + t`
https://support.google.com/chrome/answer/157179?hl=zh-Hans

### 打开磁盘
`win + E`

## 环境变量配置
系统属性 > 环境变量(n) > 系统变量 > 点击 `Path 一行` > 新建(N) > 粘贴软件路径 （F:\vscode\Microsoft VS Code)

## 系统重装
### U盘启动盘制作
[老毛桃](https://www.laomaotao.net/)
[老毛桃教程](https://www.laomaotao.net/doc/udiskwinpe.html)

### 系统下载
[msdn](https://msdn.itellyou.cn/)
选择：consumer editions，里面包含家庭版、教育版、专业版

下载后，进行SHA1校验（[iHasher](https://share.weiyun.com/5gtDK6E)），复制到U盘根目录


### 引导安装后，激活
1.淘宝买激活码
2.用破解工具：http://www.yishimei.cn/network/319.html



## 设置
### 默认浏览器
https://support.microsoft.com/zh-cn/help/4028606/windows-10-change-your-default-browser

### 语言设置
`{% asset_img language.png %}`

### 设置开机启动
禁用
win 搜索框搜索：msconfig，打开系统配置，切换到启动项，打开任务资源管理器，切换到启动

启用
win + R；输入指令：shell:startup, 复制图标即可
