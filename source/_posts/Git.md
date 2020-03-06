---
title: Git
date: 2020-02-23 19:07:58
categories:
- Git
tags:
- Git
---

## 配置
### ssh 密钥
``` 
ssh-keygen
```

### 全局配置
用户名
``` BASH
$ git config --global user.name "name"
```

邮箱
``` BASH
$ git config --global user.email "email@gmail.com"
```

验证连接
``` zsh
ssh -T git@github.com
Hi KilFront! You've successfully authenticated, but GitHub does not provide shell access.
```

### 代理
``` BASH
#只对github.com
git config --global http.https://github.com.proxy socks5://127.0.0.1:1080

#取消代理
git config --global --unset http.https://github.com.proxy)
```

## 指令
git配置
git config --list


## 错误
### index.lock
error:
Another git process seems to be running in this repository, e.g.       
an editor opened by 'git commit'. Please make sure all processes       
are terminated then try again. If it still fails, a git process        
may have crashed in this repository earlier:
remove the file manually to continue.

``` zsh
cd .git
rm index.lock
```
应该是windows对进程的管理有个上锁机制，正常情况下，会上锁，进程结束，然后解锁进程。但是由于我强制关闭了运行中的git,导致git崩溃，已经上锁的index.lock没有来得及解锁而仍然存在。当我再用git add的时候，git发现已经存在了index.lock这个文件，导致报错。

### vscode 使用git
error：
git push --set-upstream origin master
执行一下就行

error：
Host key verification failed.
fatal: Could not read from remote repository.

Please make sure you have the correct access rights
and the repository exists.

wsl 和 windows 的混淆
我不是在wsl code . 启动的vscode
wsl 中的密钥 无法在windows中使用
在windows 生成密钥；命令行提交验证一次，就可以了

## vscoed 中应用
### push
#### 暂存所有更改
更改处 '+' 

#### 提交已暂存文件
更多操作... > 提交已暂存文件
输入本次提交内容 描述文字

#### 推送 push
更多操作... > 推送

### pull
更多操作... > 拉取



