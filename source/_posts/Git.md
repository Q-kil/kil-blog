---
title: Git
date: 2020-02-23 19:07:58
categories:
- Git
tags:
- Git
---

# 配置
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

# 指令
git配置
git config --list

## 版本回滚
``` zsh
git reset --hard ff19b5644e7470728d5a10f57f244f9754fb4d58
git add .
git commit -m update
git push origin dev -f
```

-f : force 暴力

Pushing to git@github.com:519ebayproject/519ebayproject.git
To git@github.com:519ebayproject/519ebayproject.git
 ! [rejected]        master -> master (non-fast-forward)
error: failed to push some refs to 'git@github.com:519ebayproject/519ebayproject.git'
hint: Updates were rejected because the tip of your current branch is behind
hint: its remote counterpart. Merge the remote changes (e.g. 'git pull')
hint: before pushing again.
hint: See the 'Note about fast-forwards' in 'git push --help' for details.
我遇到造成这个问题的原因，一般是因为执行了git reset命令，版本回退后没有恢复，造成本地仓库的提交版本号落后于远端仓库的提交版本号。
可以执行 git push -f命令去强制提交

### 回滚之后的操作
git log  找到想退回的版本

### 未暂存文件
git reset 3e5236a

### 暂存文件
git reset --hard 3e5236a

## 历史提交记录
git log

## 删除远程已提交的文件
``` zsh
git rm -r --cached 文件/文件夹名称
# 修改本地 .gitignore
git commit -m ''
git push origin master
```

# 错误
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

# vscoed 中应用
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


# gitignore
忽略所有 .a 结尾的文件
*.a

但 lib.a 除外
!lib.a

仅仅忽略项目根目录下的 TODO 文件，不包括 subdir/TODO
/TODO

忽略 build/ 目录下的所有文件
build/

会忽略 doc/notes.txt 但不包括 doc/server/notes.txt
doc/notes.txt


# 依赖git上的库
``` zsh
yarn add git+ssh://git@code.apowo.com:PixelPai/game-core.git#dev
```