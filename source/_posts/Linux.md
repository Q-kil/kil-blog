---
title: Linux
date: 2019-12-28 13:54:02
categories:
- Linux
tags:
- Linux
---

# base
## 不应该在 home 目录建文件
l: 太过分了，啥权限都不应该在home目录下建目录啊
``` zsh
ubuntu@gitlab-runner:/home$ ls
gitlab-runner  temp  ubuntu
```
如果是只是临时文件  建议使用/tmp/目录 这个目录应该所有用户都有写权限的
没必要另外创建文件夹
## ubuntu
查看所有用户
cat /etc/shadow

切换用户
切换用户的命令
su username
从普通用户切换到root用户，还可以使用命令
sudo su

### vim tab缩进 4个空格
变量名           缩写        含义 
(no)smartindent si          基于autoindent的一些改进 
tabstop=X       ts          编辑时一个TAB字符占多少个空格的位置。 
shiftwidth=X    sw          使用每层缩进的空格数。 
(no)expandtab   (no)et      是否将输入的TAB自动展开成空格。开启后要输入TAB，需要Ctrl-V<TAB> 
softtabstop=X   sts         方便在开启了et后使用退格（backspace）键，每次退格将删除X个空格 

set smartindent  
set tabstop=4  
set shiftwidth=4  
set expandtab  
set softtabstop=4  

放在 ~/.vimrc中仅对自己生效
放在/etc/vimrc中对所有用户生效

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

移动文件 ｜ 重命名文件：mv 文件名 修改后的文件名
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

pm2 logs | grep -i "KEYWORD"
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

当前目录下（包括子目录）的文件名中包含 luoluo 的文件过滤出来
find | grep luoluo

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

.zshrc
echo "loaded"

查看文件大小
当前目录所有文件大小
ls -lht

当前文件夹下所有文件（或某个文件）对应大小
du -sh *

反向列示文件内容
```
ubuntu@pixelpai-devel:/var/log/filebeat$ tac web_combined.log | grep 'test00'
```

删除文件下所有
rm ./*

打开当前文件
open .

显示所有文件（包含隐藏文件）
ls -all

查看端口
lsof -i:1080

tar命令之--exclude参数 排除指定的文件或目录

按文件大小排序
``` zsh
$ ll -Sh
total 2240
-rw-rw-r--@ 1 niekaifa  staff   564K  4 22 18:18 bg_intro.jpeg
-rw-rw-r--@ 1 niekaifa  staff   285K  4 22 19:07 img_intro.png
-rw-rw-r--@ 1 niekaifa  staff   152K  4 22 18:18 img_tales.png
-rw-rw-r--@ 1 niekaifa  staff    86K  4 21 09:51 bg_character.png
-rw-rw-r--@ 1 niekaifa  staff    14K  4 19 19:35 ico_guardian.png
-rw-rw-r--@ 1 niekaifa  staff   7.9K  4 19 19:40 bg_dim2.png
-rw-rw-r--@ 1 niekaifa  staff   1.4K  4 22 18:19 logo_guardian.png
```

生成一个指定大小的文件
root@VM-0-4-ubuntu:/home/remote# dd if=/dev/zero of=tmp.5M bs=1M count=5
5+0 records in
5+0 records out
5242880 bytes (5.2 MB, 5.0 MiB) copied, 0.00419139 s, 1.3 GB/s

if=FILE      : 指定输入文件，若不指定则从标注输入读取。这里指定为/dev/zero是Linux的一个伪文件，它可以产生连续不断的null流（二进制的0）
of=FILE      : 指定输出文件，若不指定则输出到标准输出
bs=BYTES     : 每次读写的字节数，可以使用单位K、M、G等等。另外输入输出可以分别用ibs、obs指定，若使用bs，则表示是ibs和obs都是用该参数
count=BLOCKS : 读取的block数，block的大小由ibs指定（只针对输入参数）

mac os

copy 文件
cp -r vue-project/dist/ www

制文件夹内所有文件到另一个文件夹
cp -Rf /home/user1/* /root/temp/
将 /home/user1目录下的所有东西拷到/root/temp/下而不拷贝user1目录本身。

# niekaifa @ niekaifadeMacBook-Pro in ~/workspace/apowo/tooqing-cordova/tooqing-webapp/src/assets/imgs on git:c91647c o [14:40:47] 
$ dd if=/dev/zero of=tmp.png bs=1M count=50
dd: bs: illegal numeric value

# niekaifa @ niekaifadeMacBook-Pro in ~/workspace/apowo/tooqing-cordova/tooqing-webapp/src/assets/imgs on git:c91647c o [14:40:50] C:1
$ dd if=/dev/zero of=tmp.png bs=1m count=20
20+0 records in
20+0 records out
20971520 bytes transferred in 0.044836 secs (467737962 bytes/sec)

vim 光标跳转
1.跳到文本的最后一行：按“G”,即“shift+g”
2.跳到最后一行的最后一个字符 ： 先重复1的操作即按“G”，之后按“$”键，即“shift+4”。

### 文件同步
rsync 是一个常用的 Linux 应用程序，用于文件同步。
它可以在本地计算机与远程计算机之间，或者两个本地目录之间同步文件（但不支持两台远程计算机之间的同步）。它也可以当作文件复制工具，替代cp和mv命令。
-e参数指定使用 SSH 协议传输数据。
-P参数是--progress和--partial这两个参数的结合。

--partial参数允许恢复中断的传输。不使用该参数时，rsync会删除传输到一半被打断的文件；使用该参数后，传输到一半的文件也会同步到目标目录，下次同步时再恢复中断的传输。一般需要与--append或--append-verify配合使用。

--partial-dir参数指定将传输到一半的文件保存到一个临时目录，比如--partial-dir=.rsync-partial。一般需要与--append或--append-verify配合使用。

--progress参数表示显示进展。

### chmod
Linux chmod（英文全拼：change mode）命令是控制用户对文件的权限的命令
chmod a+r file	给file的所有用户增加读权限
chmod a-x file	删除file的所有用户的执行权限
chmod a+rw file	给file的所有用户增加读写权限
chmod +rwx file	给file的所有用户增加读写执行权限

### 下载
curl -O https://osd.tooqing.com/sickytree/game/5e217ab725d9451113986374/assets/1579402117.png

重命名
curl -o test.png https://osd.tooqing.com/sickytree/game/5e217ab725d9451113986374/assets/1579402117.png

#### 下载走代理
sudo curl -x 127.0.0.1:1080 --output /usr/local/bin/gitlab-runner "https://gitlab-runner-downloads.s3.amazonaws.com/latest/binaries/gitlab-runner-darwin-amd64"

### iterm2
iterm2以及mac自带的terminal都是终端模拟器

### 设置代理
``` zsh
# 打开配置文件
vim ~/.bash_profile
# 如果用了`oh-my-zsh` 那么修改`~/.zshrc`
# 在后面新增配置
export http_proxy=http://127.0.0.1:1087
export https_proxy=$http_proxy
# 同理，可能执行` source ~/.zshrc`
source ~/.bash_profile
```

#### 测试代理
``` zsh
# 方式2：通过google测试，有结果，说明Ok
curl -i https://google.com

失败：
$ curl -i https://google.com
curl: (7) Failed to connect to google.com port 443: Operation timed out

成功：
$ curl -i https://google.com
HTTP/1.1 200 Connection established

HTTP/2 301
location: https://www.google.com/
content-type: text/html; charset=UTF-8
date: Fri, 22 Jan 2021 07:25:03 GMT
expires: Sun, 21 Feb 2021 07:25:03 GMT
cache-control: public, max-age=2592000
server: gws
content-length: 220
x-xss-protection: 0
x-frame-options: SAMEORIGIN
alt-svc: h3-29=":443"; ma=2592000,h3-T051=":443"; ma=2592000,h3-Q050=":443"; ma=2592000,h3-Q046=":443"; ma=2592000,h3-Q043=":443"; ma=2592000,quic=":443"; ma=2592000; v="46,43"

<HTML><HEAD><meta http-equiv="content-type" content="text/html;charset=utf-8">
<TITLE>301 Moved</TITLE></HEAD><BODY>
<H1>301 Moved</H1>
The document has moved
<A HREF="https://www.google.com/">here</A>.
</BODY></HTML>
```

### 色彩皮肤
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
dd        :  删除一行


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
### key 密钥
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

### 登录设置
用OpenSSH的人都知ssh会把你每个你访问过计算机的公钥(public key)都记录在~/.ssh/known_hosts。当下次访问相同计算机时，OpenSSH会核对公钥。如果公钥不同，OpenSSH会发出警告， 避免你受到DNS Hijack之类的攻击。
SSH对主机的public_key的检查等级是根据StrictHostKeyChecking变量来配置的。默认情况下，StrictHostKeyChecking=ask。简单所下它的三种配置值：
1.StrictHostKeyChecking=no  
#最不安全的级别，当然也没有那么多烦人的提示了，相对安全的内网测试时建议使用。如果连接server的key在本地不存在，那么就自动添加到文件中（默认是known_hosts），并且给出一个警告。
2.StrictHostKeyChecking=ask  #默认的级别，就是出现刚才的提示了。如果连接和key不匹配，给出提示，并拒绝登录。
3.StrictHostKeyChecking=yes  #最安全的级别，如果连接与key不匹配，就拒绝连接，不会提示详细信息。


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

### 环境变量设置
$ vi .bash_profile     //使用vi编辑器编辑 .bash_profile

粘贴这行代码     export ANDROID_HOME=~/Library/Android/sdk

$ source ~/.bash_profile    //使其立即生效

$ echo $ANDROID_HOME检查此变量是否已正确设置。

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

## 修改时间
``` zsh
root@ci-runner:~# tzselect
Please identify a location so that time zone rules can be set correctly.
Please select a continent, ocean, "coord", or "TZ".
 1) Africa
 2) Americas
 3) Antarctica
 4) Asia
 5) Atlantic Ocean
 6) Australia
 7) Europe
 8) Indian Ocean
 9) Pacific Ocean
10) coord - I want to use geographical coordinates.
11) TZ - I want to specify the time zone using the Posix TZ format.
#? 4
Please select a country whose clocks agree with yours.
 1) Afghanistan		  18) Israel		    35) Palestine
 2) Armenia		  19) Japan		    36) Philippines
 3) Azerbaijan		  20) Jordan		    37) Qatar
 4) Bahrain		  21) Kazakhstan	    38) Russia
 5) Bangladesh		  22) Korea (North)	    39) Saudi Arabia
 6) Bhutan		  23) Korea (South)	    40) Singapore
 7) Brunei		  24) Kuwait		    41) Sri Lanka
 8) Cambodia		  25) Kyrgyzstan	    42) Syria
 9) China		  26) Laos		    43) Taiwan
10) Cyprus		  27) Lebanon		    44) Tajikistan
11) East Timor		  28) Macau		    45) Thailand
12) Georgia		  29) Malaysia		    46) Turkmenistan
13) Hong Kong		  30) Mongolia		    47) United Arab Emirates
14) India		  31) Myanmar (Burma)	    48) Uzbekistan
15) Indonesia		  32) Nepal		    49) Vietnam
16) Iran		  33) Oman		    50) Yemen
17) Iraq		  34) Pakistan
#? 9
Please select one of the following time zone regions.
1) Beijing Time
2) Xinjiang Time
#? 1

The following information has been given:

	China
	Beijing Time

Therefore TZ='Asia/Shanghai' will be used.
Selected time is now:	Sat May  8 18:27:19 CST 2021.
Universal Time is now:	Sat May  8 10:27:19 UTC 2021.
Is the above information OK?
1) Yes
2) No
#? 1

You can make this change permanent for yourself by appending the line
	TZ='Asia/Shanghai'; export TZ
to the file '.profile' in your home directory; then log out and log in again.

Here is that TZ value again, this time on standard output so that you
can use the /usr/bin/tzselect command in shell scripts:
Asia/Shanghai
root@ci-runner:~# cp /usr/share/zoneinfo/Asia/Shanghai  /etc/localtime
root@ci-runner:~# date -R
Sat, 08 May 2021 18:27:43 +0800
```

获取东八区时间
``` js
var timezone = 8; //目标时区时间，东八区
var offset_GMT = new Date().getTimezoneOffset(); // 本地时间和格林威治的时间差，单位为分钟
var nowDate = new Date().getTime(); // 本地时间距 1970 年 1 月 1 日午夜（GMT 时间）之间的毫秒数
var targetDate = new Date(nowDate + offset_GMT * 60 * 1000 + timezone * 60 * 60 * 1000);
console.log("东8区现在是：" + targetDate);
```