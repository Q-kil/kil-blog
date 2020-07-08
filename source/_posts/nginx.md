---
title: nginx
date: 2020-07-08 10:18:01
tags:
---

# 查看服务器是否安装nginx
which nginx
没有安装会返回空
安装了会返回路径
``` bash
root@quick-hat-1:~# which nginx
/usr/sbin/nginx

root@quick-hat-1:~# nginx -v
nginx version: nginx/1.10.3 (Ubuntu)

root@quick-hat-1:~# whereis nginx
nginx: /usr/sbin/nginx /etc/nginx /usr/share/nginx
```

# 命令
启动
systemctl start nginx
nginx -s start;

启动成功后浏览器输入ip，显示相应信息
`{% asset_img nginx1.png %}`

重启
systemctl restart nginx
``` bash
root@quick-hat-1:/etc/nginx/sites-enabled# nginx -s reload
```

停止
systemctl stop nginx
nginx -s stop;

开机自启（保证可持续提供服务）
systemctl enable nginx

卸载
apt-get --purge remove nginx

检测语法
修改配置后，可以通过下面的命令测试是否有语法错误
nginx -t;

# 配置
/ect是linux下专门用来放配置文件的一个目录

## nginx 默认页面
/etc/nginx/sites-enabled/default

root /var/www/html;
``` bash
root@quick-hat-1:/var/www/html# ls
index.nginx-debian.html
```

## 文件
opt，optional，可选择目录
etc，et cetera，存放配bai置文件

# 部署
## 本地文件复制到服务器
``` bash
$ scp -r -P 29847 dist root@96.45.180.121:/opt 
root@96.45.180.121's password: 
index.html                                                                                                100%  234     1.1KB/s   00:00    
bundle.min.js                                                                                             100%   99KB  16.7KB/s   00:05 
```

Linux scp 命令用于 Linux 之间复制文件和目录。
scp 是 secure copy 的缩写, scp 是 linux 系统下基于 ssh 登陆进行安全的远程文件拷贝命令。
scp 是加密的，rcp 是不加密的，scp 是 rcp 的加强版。

## 修改服务器nginx配置文件
``` bash
root@quick-hat-1:/etc/nginx/sites-enabled# vim default

#root /var/www/html;
root /opt/dist;
```

浏览器输入地址：http://96.45.180.121/
`{% asset_img nginx2.png %}`
