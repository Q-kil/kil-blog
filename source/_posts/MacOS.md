---
layout: mac
title: OS
date: 2020-03-23 09:33:26
categories:
- MacOS
tags:
- MacOS
---

# basic
## 指令
在xcode中打开
open platforms/ios/UpdateDemo.xcodeproj

# 系统更新
`{% asset_img mac_os.jpeg %}`

# brew
[Homebrew](https://github.com/Homebrew/brew)是一款自由及开放源代码的软件包管理系统，用以简化macOS系统上的软件安装过程

brew 是从下载源码解压然后 ./configure && make install ，同时会包含相关依存库。并自动配置好各种环境变量，而且易于卸载。
这个对程序员来说简直是福音，简单的指令，就能快速安装和升级本地的各种开发环境。

而 brew cask 是 已经编译好了的应用包 （.dmg/.pkg），仅仅是下载解压，放在统一的目录中（/opt/homebrew-cask/Caskroom），省掉了自己去下载、解压、拖拽（安装）等蛋疼步骤，同样，卸载相当容易与干净。这个对一般用户来说会比较方便，包含很多在 AppStore 里没有的常用软件。

版本
``` zsh
brew --version
```

更新
``` zsh
brew update
```

更新某个包时，查看更新信息
``` zsh
brew upgrade -d yarn
```

两种方式安装包
``` zsh
brew install yarn 
curl -o- -L https://yarnpkg.com/install.sh | bash -s -- --version 1.13.0
```

apps path
``` zsh
cd /Applications
```

安装java
``` zsh
brew cask install --verbose --debug java
```

## 问题
### Updating Homebrew...
解决办法
#### 关闭自动更新
在.zshrc文件中加入下方命令：
``` zsh
export HOMEBREW_NO_AUTO_UPDATE=true
```

#### 替换镜像源加速
我们平时执行brew命令安装软件的时候，跟这三个仓库有关：
```
1.brew.git
2.homebrew-core.git
3.homebrew-bottles
```

使用阿里的Homebrew镜像源代替可以进行加速

##### 替换brew.git
``` zsh
cd "$(brew --repo)"
git remote set-url origin https://mirrors.aliyun.com/homebrew/brew.git
```

还原：
``` zsh
cd "$(brew --repo)"
git remote set-url origin https://github.com/Homebrew/brew.git
```

##### 替换homebrew-core.git
``` zsh
cd "$(brew --repo)/Library/Taps/homebrew/homebrew-core"
git remote set-url origin https://mirrors.aliyun.com/homebrew/homebrew-core.git
```

还原：
``` zsh
cd "$(brew --repo)/Library/Taps/homebrew/homebrew-core"
git remote set-url origin https://github.com/Homebrew/homebrew-core.git
```

##### 替换homebrew-bottles访问地址
``` zsh
echo 'export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.aliyun.com/homebrew/homebrew-bottles' >> ~/.zshrc
source ~/.zshrc
```

还原的话就是删除HOMEBREW_BOTTLE_DOMAIN，上面的是zsh的命令，如果是bash的话请写在.bash_profile文件中。

更新后成功：
``` zsh
$ brew upgrade yarn
Updating Homebrew...
==> Auto-updated Homebrew!
Updated 1 tap (homebrew/cask).
==> Updated Casks
karabiner-elements ✔               hex-fiend                          qownnotes
115browser 
```

### instail慢
#### 替换代理
``` zsh
# niekaifa @ niekaifadeMacBook-Pro in ~ [14:40:01] C:130
$ brew cask install adoptopenjdk8 --debug
==> Downloading https://github.com/AdoptOpenJDK/openjdk8-binaries/releases/download/jdk8u265-b01/OpenJDK8U-jdk_x64_mac_hotspot_8u265b01.pkg
==> Downloading from https://github-production-release-asset-2e65be.s3.amazonaws.com/140418865/6444de00-d246-11ea-8be7-50169d929f88?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAIWNJYAX4CSVEH53A%2F2
##################                                                        25.7%^C

# niekaifa @ niekaifadeMacBook-Pro in ~ [14:54:50] C:130
$ export ALL_PROXY=127.0.0.1:1087 【注意：该设置仅在当前zsh有效】

# niekaifa @ niekaifadeMacBook-Pro in ~ [14:55:55]
$ brew cask install adoptopenjdk8 --debug
==> Downloading https://github.com/AdoptOpenJDK/openjdk8-binaries/releases/download/jdk8u265-b01/OpenJDK8U-jdk_x64_mac_hotspot_8u265b01.pkg
==> Downloading from https://github-production-release-asset-2e65be.s3.amazonaws.com/140418865/6444de00-d246-11ea-8be7-50169d929f88?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAIWNJYAX4CSVEH53A%2F20200810%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20200810T065610Z&X-Amz-Expires=300&X-
######################################################################## 100.0%
==> Verifying SHA-256 checksum for Cask 'adoptopenjdk8'.
==> Installing Cask adoptopenjdk8
==> Running installer for adoptopenjdk8; your password may be necessary.
==> Package installers may write to any location; options such as --appdir are ignored.
Password:
installer: Package name is AdoptOpenJDK
installer: Installing at base path /
installer: The install was successful.
package-id: net.adoptopenjdk.8.jdk
version: 1.8.0_265-b01
volume: /
location: Library/Java/JavaVirtualMachines/adoptopenjdk-8.jdk
install-time: 1597042784
🍺  adoptopenjdk8 was successfully installed!
```

## 安装gradle
brew install gradle     一直失败

该用二进制文件安装
``` zsh
❯ mkdir /opt/gradle
❯ unzip -d /opt/gradle gradle-6.6-bin.zip
❯ ls /opt/gradle/gradle-6.6
LICENSE  NOTICE  bin  README  init.d  lib  media
```


# hosts系统文件
Hosts是一个没有扩展名的系统文件，可以用记事本等工具打开，其作用就是将一些常用的网址域名与其对应的IP地址建立一个关联“数据库”，当用户在浏览器中输入一个需要登录的网址时，系统会首先自动从Hosts文件中寻找对应的IP地址，一旦找到，系统会立即打开对应网页，如果没有找到，则系统会再将网址提交DNS域名解析服务器进行IP地址的解析。
``` zsh
sudo vi /etc/hosts

127.0.0.1	www.163.com
```

# 清理内存
sudo purge

# 快捷键
## 显示隐藏文件
shift + command + .

# 清理mac
Finder>前往>资源库（按alt显示）
