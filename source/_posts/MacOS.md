---
layout: mac
title: OS
date: 2020-03-23 09:33:26
categories:
- MacOS
tags:
- MacOS
---

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

# hosts系统文件
Hosts是一个没有扩展名的系统文件，可以用记事本等工具打开，其作用就是将一些常用的网址域名与其对应的IP地址建立一个关联“数据库”，当用户在浏览器中输入一个需要登录的网址时，系统会首先自动从Hosts文件中寻找对应的IP地址，一旦找到，系统会立即打开对应网页，如果没有找到，则系统会再将网址提交DNS域名解析服务器进行IP地址的解析。
``` zsh
sudo vi /etc/hosts

127.0.0.1	www.163.com
```

# 清理内存
sudo purge
