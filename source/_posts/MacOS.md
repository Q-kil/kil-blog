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

版本
``` zsh
brew --version
```

更新
``` zsh
brew update
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