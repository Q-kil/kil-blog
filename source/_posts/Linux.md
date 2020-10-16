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

### vim
gg        ： 跳转到文件头

Shift+g   ： 跳转到文件末尾

o         :  新建一行


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

#### etc/hosts
hosts文件是linux系统中负责ip地址与域名快速解析的文件

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

### 快捷root登录
1、允许root登录
sudo vi /etc/ssh/sshd_config
PermitRootLogin yes #允许root登录

2、root用户添加公钥
ubuntu@VM-0-4-ubuntu:~$ sudo -i
root@VM-0-4-ubuntu:~/.ssh# vim authorized_keys

3、配置登录
Host tx1
    HostName 122.51.101.113
    User root


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

## 文件目录
/ ;linux系统的根目录，是系统的最顶层。 

/bin ;里面是系统最基本的二进制命令文件如ls cp rm ln等等。

/sbin ;s就是super的意思，里面都是超级用户用于管理系统的命令，如mkfs.ext3 等。 

/boot ;里面是开机程序，lilo或grub，还有linux 内核文件vmlinuz ,初始化系统的initrd.img文件。

 /dev ; 就是device的意思，代表计算机的所有硬件设备。如IDE盘：/dev/hdx ；串口：/dev/ttyx.；scsi盘用sdx表示。注意，一般情况下usb盘，s-ata硬盘也模拟成scsi来驱动。

/lib ; 系统核心的动态模块和连接库文件，各种可动态加载的硬件驱动程序。nvidia的驱动程序就是安装在这里面。 

/etc ;里面绝大部分都是文本文件，用于设置系统的，作用相当于windows的注册表。注意，其中有一个/etc/shadow文件里面保存着用户的登录密码。 

/root 超级用户的工作目录。 

/mnt ;外接文件系统的挂载点，u盘、cdrom、windows分区都应挂到这里面。 

/proc ;里面的文件不再硬盘上，而是在内存里，都是系统内核的运行信息。 


/var ;包含在正常操作中被改变的文件：假脱机文件、记录文件、加锁文件、临时文件和页格式化文件等。 默认情况下，http，ftp等服务的主文件夹也在这里面。 

/tmp ;各用户程序产生的临时文件的存放场所，临时文件会被自动清除掉。 

/home;一般用户的主文件夹所在的地方。

/usr;规模非常庞大的文件夹，里面是各个应用程序的文件，相当于windows的 program files 文件夹。

/usr下有几个重要的子文件夹。 

/usr/bin ;应用程序的可执行文件部分。相当于windows的*.exe文件。 

/usr/lib;应用程序的共享动态连接库部分，都是一些*.so的文件，linux下各个应用程序的库文件都是可共享的。所以都存放在一个文件夹中。 /usr/X11R6;xwindow 系统的所属文件。 

/usr/share;存放的是应用程序需要的字体、图片、文档等资源文件。 

/usr/src; linux的源代码就放在这里。 

/usr/games;游戏软件的存放区域，可惜现在linux大游戏还不太多。 

/usr/include;Linux下开发和编译应用程序需要的头文件，爱好编程的朋友可要仔细研究这里呦。 

/opt ; 非开源的商业程序一般都装到这里面。 可以谷歌到更多的！
