---
title: Linux
date: 2019-12-28 13:54:02
categories:
- Linux
tags:
- Linux
---

## 第一步
### update
``` BASH
$ sudo apt update
```

如果比较慢，换国内源

``` BASH
$ sudo ls /etc/apt/sources.list
  /etc/apt/sources.list

$ sudo mv /etc/apt/sources.list /etc/apt/sources.list.bak

$ sudo vim /etc/apt/sources.list
deb http://mirrors.aliyun.com/ubuntu/ bionic main restricted universe multiverse

deb-src http://mirrors.aliyun.com/ubuntu/ bionic main restricted universe multiverse

deb http://mirrors.aliyun.com/ubuntu/ bionic-security main restricted universe multiverse

deb-src http://mirrors.aliyun.com/ubuntu/ bionic-security main restricted universe multiverse

deb http://mirrors.aliyun.com/ubuntu/ bionic-updates main restricted universe multiverse

deb-src http://mirrors.aliyun.com/ubuntu/ bionic-updates main restricted universe multiverse

deb http://mirrors.aliyun.com/ubuntu/ bionic-backports main restricted universe multiverse

deb-src http://mirrors.aliyun.com/ubuntu/ bionic-backports main restricted universe multiverse

deb http://mirrors.aliyun.com/ubuntu/ bionic-proposed main restricted universe multiverse

deb-src http://mirrors.aliyun.com/ubuntu/ bionic-proposed main restricted universe multiverse

$ sudo apt update
```

### install
gcc编译c文件，g++编译cpp文件，make自动化编译工具
``` BASH
$ sudo apt install gcc g++ make -y
```

## 指令
### 基础
创建文件
``` BASH
$ touch test.text
```

创建文件夹
``` BASH
$ mkdir usr
```

移动文件
``` BASH
$ mv node-v12.16.1-linux-x64 /usr/app
```

强制保存 （write and quite）
``` BASH
$ wq!
```

查找历史指令
``` BASH
history |grep curl
```

查看文件安装路径
``` zsh
whereis oracle
```

查看运行文件所在路径
``` zsh
which oracle
```

PS E:\software\genymotion\Genymotion\tools> netstat -aon|findstr “5037”
  TCP    127.0.0.1:5037         0.0.0.0:0              LISTENING       19856
  TCP    127.0.0.1:5037         127.0.0.1:56022        ESTABLISHED     19856
  TCP    127.0.0.1:5037         127.0.0.1:56032        ESTABLISHED     19856
  TCP    127.0.0.1:56022        127.0.0.1:5037         ESTABLISHED     13504
  TCP    127.0.0.1:56032        127.0.0.1:5037         ESTABLISHED     20616
PS E:\software\genymotion\Genymotion\tools> taskkill /pid 19856 /f
成功: 已终止 PID 为 19856 的进程。


显示磁盘空间统计信息
``` bash
df -h
```

查询可用内存
``` bash
free -m
```

显示终端下所有用户的程序
``` bash
ps axu|grep nginx
```

查看包安装在那
``` bash
which nginx
```

查看文件下所有文件
``` zsh
ll -la ~/
```

查看当前shell 用的那个
``` zsh
# niekaifa @ niekaifadeMacBook-Pro in /usr/local/Homebrew/Library/Taps/homebrew/homebrew-core on git:master o [10:20:06]
$ echo $SHELL
/bin/zsh
```

色彩皮肤
``` zsh
cat ~/.zshrc
plugins=(
  git
  nali
)
.oh-my-zsh
``` 

``` zsh
$ ls source
CNAME      _data      _posts     categories img        kil        tags

$ ls -l source | grep kil
drwxr-xr-x    3 niekaifa  staff    96  3  2 12:57 kil
```


### 域名操作
#### curl
curl 是常用的命令行工具，用来请求 Web 服务器。它的名字就是客户端（client）的 URL 工具的意思。
它的功能非常强大，命令行参数多达几十种。如果熟练的话，完全可以取代 Postman 这一类的图形界面工具。

```
curl
返回
* Connected to kaifa.in (209.141.38.71) port 80 (#0)
> GET / HTTP/1.1
> Host: kaifa.in
> User-Agent: curl/7.54.0
> Accept: */*
>
< HTTP/1.1 301 Moved Permanently
< Server: nginx
< Date: Mon, 30 Dec 2019 09:27:00 GMT
< Content-Type: text/html
< Content-Length: 178
< Connection: keep-alive
< Location: http://www.kaifa.in/
```

``` bash
curl http://gitlab.kaifa.in:9999 -v
```

#### dig
dig命令是常用的域名查询工具，可以用来测试域名系统工作是否正常。
```
dig kaifa.in
返回
;; ANSWER SECTION:
kaifa.in.		16478	IN	A	209.141.38.71
```

## SSH
### key
查看是否有key
``` BASH
$ cd ~/.ssh && ls
id_rsa  id_rsa.pub  known_hosts
```
生成key
``` BASH
$ ssh-keygen -t rsa -C "your_email@example.com"
```

### 快捷登录设置
客户端配置文件 ～/.ssh/config
``` BASH
  Host hk1
    HostName 47.56.157.52
    User root
```
服务端配置文件 ～/.ssh/authorized_keys
``` BASH
#k
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDTzGvV166P2ST3VEyxC/wsAViF7kg0X5Fsn6ucyeIhvEfbObp/L68LxjE+UXmQnk0tIaXsK7Cch9c4LMAppFE+6pUZykTA5lsKUWyOPR9tRiHsYwoeS2AM9+tmo3GwYjDtFKsEPRhSvVPYUfH2sC6c+w2gQ6v6LtKEw2/iKb+3upOY3bkhP3YcNXD+QwEkJFLG0KsbXqLlSfDQpdpPG8obgtoPfOWQxOWh4OmxQdJlJIAU7IDNZBLHVyZh112Z5B7LiVm26FIOb66mpVUwf2YsjS5zwoahGoaGa9H4I5vDJmNT0NpaEBFvHQMefdn2NtFo+LZgHWttj
```

## 注
~ 表示：当前登录用户的用户目录
~ 代表的就是 /home/kil/

# and Bourne compatible shells (bash(1), ksh(1), ash(1), ...).

if [ "${PS1-}" ]; then
  if [ "${BASH-}" ] && [ "$BASH" != "/bin/sh" ]; then
    # The file bash.bashrc already sets the default PS1.
    # PS1='\h:\w\$ '
    if [ -f /etc/bash.bashrc ]; then
      . /etc/bash.bashrc
    fi
  else
    if [ "`id -u`" -eq 0 ]; then
      PS1='# '
    else
      PS1='$ '
    fi
  fi
fi

if [ -d /etc/profile.d ]; then
  for i in /etc/profile.d/*.sh; do
    if [ -r $i ]; then
      . $i
    fi
  done
  unset i
fi

#export NODE_HOME=/usr/app/node-v12.16.1-linux-x64
#export PATH=$PATH:$NODE_HOME/bin

export NODE_HOME=/home/kil/.npm-global
export PATH=$NODE_HOME/bin:$PATH

# 知识
Shell是Linux/Unix的一个外壳，你理解成衣服也行。它负责外界与Linux内核的交互，接收用户或其他应用程序的命令，然后把这些命令转化成内核能理解的语言，传给内核，内核是真正干活的，干完之后再把结果返回用户或应用程序。

Linux/Unix提供了很多种Shell，为毛要这么多Shell？难道用来炒着吃么？那我问你，你同类型的衣服怎么有那么多件？花色，质地还不一样。写程序比买衣服复杂多了，而且程序员往往负责把复杂的事情搞简单，简单的事情搞复杂。牛程序员看到不爽的Shell，就会自己重新写一套，慢慢形成了一些标准，常用的Shell有这么几种，sh、bash、csh等，想知道你的系统有几种shell，可以通过以下命令查看：
``` zsh
cat /etc/shells
```

zsh: 终极Shell

$HOME是当前用户主目录，它有个别名 “~”

## 环境配置
.zshenv  不需要登录
.zshrc   需要登录
