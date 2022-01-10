---
title: nginx
date: 2020-07-08 10:18:01
tags:
---

# base
ng conf
``` nginx
server {
    listen  8071;
    server_name   localhost;

    location / {
        root    /home/remote/pkt-ng/dist;
        index index.html;
        try_files $uri $uri/ /m/index.html;
    }

}
``` 

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

## 版本
[版本](http://nginx.org/en/download.html)
Mainline version：正在开发阶段的版本，可能会有漏洞。
Stable version：稳定版
Legacy versions： 历史版本

## 卸载
彻底删除nginx自动生成的配置项和相关联的软件

停止nginx   ，nginx -s stop
卸载
``` zsh
sudo apt-get --purge remove nginx 
sudo apt-get autoremove
```

查询和nginx相关的自动安装的软件
``` zsh
dpkg --get- selections|grep nginx
```

查询的结果
``` zsh
nginx-common deinstall 
```

卸载该软件
``` zsh
sudo apt-get --purge remove nginx-common 
```

## linux安装最新版
安装或升级
需要添加源才能下载Nginx的稳定版本
首先输入以下两条命令
``` zsh
sudo wget http://nginx.org/keys/nginx_signing.key
sudo apt-key add nginx_signing.key
```

在 /etc/apt/sources.list 文件中加入下面两行：
deb http://nginx.org/packages/ubuntu/ codename nginx
deb-src http://nginx.org/packages/ubuntu/ codename nginx
注意 codename 要根据系统来选择[系统](http://nginx.org/en/linux_packages.html#stable)
sudo vim /etc/apt/sources.list
``` zsh
deb http://nginx.org/packages/ubuntu/ bionic nginx
deb-src http://nginx.org/packages/ubuntu/ bionic nginx
```

安装
``` zsh
sudo apt-get update
sudo apt-get install nginx
```

查看
``` zsh
root@VM-0-4-ubuntu:/home# nginx -v
nginx version: nginx/1.18.0
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

## /m/ 子目录
```
server {
  listen       8075;
  server_name  localhost;

  #charset koi8-r;
  #access_log  /var/log/nginx/host.access.log  main;

  location /m/{
    alias /data/;
    add_header Access-Control-Allow-Origin *;
    add_header Access-Control-Allow-Methods 'GET, POST, OPTIONS';
    add_header Access-Control-Allow-Headers 'DNT,X-Mx-ReqToken,Keep-Alive,User-Agent,X-Requested-With,If-Modified-Since,Cache-Control,Content-Type,Authorization';
    index  index.html index.htm;
    try_files $uri $uri/ /m/index.html;
  }
}
```

# 部署
## 本地文件复制到服务器
``` bash
$ scp -r -P 29847 dist root@96.45.180.121:/opt 
root@96.45.180.121's password: 
index.html              100%  234     1.1KB/s   00:00    
bundle.min.js           100%   99KB  16.7KB/s   00:05 
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

# 检查
``` zsh
ubuntu@web:/etc/nginx/sites-enabled$ sudo nginx -t -c /etc/nginx/nginx.conf
nginx: [emerg] invalid number of arguments in "root" directive in /etc/nginx/conf.d/tooqing-cms.conf:8
nginx: configuration file /etc/nginx/nginx.conf test failed
```

# 转发
server {
    listen  8081;
    server_name   localhost;

    location / {
        root    /home/kil/dist;
    }

    location /cdn/ {
        proxy_pass https://a.tooqing.com/game/resource/;
    }
}

# 日志
/var/log/nginx# cat access.log

# ssl
``` conf
http {
    include       /etc/nginx/mime.types;
    default_type  application/octet-stream;

    log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                      '$status $body_bytes_sent "$http_referer" '
                      '"$http_user_agent" "$http_x_forwarded_for"';

    access_log  /var/log/nginx/access.log  main;

    sendfile        on;

    keepalive_timeout  65;


    server {
        listen  80;
        server_name     localhost;

        location / {
                root    /home/remote;
                index   index.html;
        }
    }

    server {
        listen  80;
        server_name     kaifa.in www.kaifa.in;

        location / {
                proxy_pass http://127.0.0.1:3000;
        }

    listen 443 ssl; # managed by Certbot
    ssl_certificate /etc/letsencrypt/live/kaifa.in/fullchain.pem; # managed by Certbot
    ssl_certificate_key /etc/letsencrypt/live/kaifa.in/privkey.pem; # managed by Certbot
    include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot


    }
}
```

## 配置
准备：example.com 的A记录指向服务器公网IP

### 第一步 安装Certbot
``` zsh
sudo apt install certbot python3-certbot-nginx
```
选择 Y 后开始安装，安装完毕我们就可以使用 Certbot 了。
接下来我们要验证一下 Certbot 是否能为Nginx 自动配置 SSL。

### 第二步 确认 Nginx 的配置
Certbot 需要能够在 Nginx 配置中找到正确的 block 才能自动配置 SSL。 具体来说，Certbot 是通过对比 server_name 与我们请求证书的域相匹配的来实现的。

``` zsh
sudo nano /etc/nginx/
```

找到server_name这一行，大概是如下的样子：
``` 
...
server_name example.com www.example.com;
...
```

让我们来验证一下，配置文件是否正确。
``` zsh
sudo nginx -t
sudo nginx -s reload
```

接下来，让我们更新防火墙配置，让它允许HTTPS对外通信。
### 第三步 让我们的防火墙允许HTTPS
如果你的服务器启动了防火墙，那么我们需要告诉防火墙要允许HTTPS通过。首先我们来查看一下当前状态。
``` zsh
sudo ufw status
Status: active

To                         Action      From
--                         ------      ----
OpenSSH                    ALLOW       Anywhere                  
Nginx HTTP                 ALLOW       Anywhere                  
OpenSSH (v6)               ALLOW       Anywhere (v6)             
Nginx HTTP (v6)            ALLOW       Anywhere (v6)
```

说明防火墙允许HTTPS通信。但如果你的服务器不允许，那么请执行以下命令。
``` zsh
sudo ufw allow 'Nginx Full'
sudo ufw delete allow 'Nginx HTTP'
```

### 第4步：获取 SSL 证书
Certbot 提供了获得 SSL 的方法。Nginx Plugins（插件） 帮助我们在必要的时候重新加载配置文件。让我们来开启这个插件。
``` zsh
sudo certbot --nginx -d kaifa.in -d www.kaifa.in
```
certbot与--nginx 插件一起运行，-d用于指定我们希望获得证书的域名。

如果我们是第一次运行，那么 Certbot 将提示我们输入邮箱并阅读服务条款。
```
Invalid email address: .
Enter email address (used for urgent renewal and security notices)

If you really want to skip this, you can run the client with
--register-unsafely-without-email but make sure you then backup your account key
from /etc/letsencrypt/accounts

 (Enter 'c' to cancel): nginx@kalasearch.com

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Please read the Terms of Service at
https://letsencrypt.org/documents/LE-SA-v1.2-November-15-2017.pdf. You must
agree in order to register with the ACME server at
https://acme-v02.api.letsencrypt.org/directory
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
(A)gree/(C)ancel:
```

如果这是您第一次运行certbot，将提示您输入电子邮件地址并同意服务条款。

完成此操作后，certbot开始与 Let's Encrypt 服务器通信，然后开始验证我们是否是这个域名的真正拥有者。

如果成功，certbot 会继续询问我们如何配置HTTPS。

```
Please choose whether or not to redirect HTTP traffic to HTTPS, removing HTTP access.
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
1: No redirect - Make no further changes to the webserver configuration.
2: Redirect - Make all requests redirect to secure HTTPS access. Choose this for
new sites, or if you're confident your site works on HTTPS. You can undo this
change by editing your web server's configuration.
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Select the appropriate number [1-2] then [enter] (press 'c' to cancel): 2
```

根据我们的需求来进行选择，然后回车。配置文件就会更新，Nginx 也会重新加载。Certbot 会显示一条消息，告诉我们整个过程已经完成，证书存储在服务器的什么位置上：
``` zsh
IMPORTANT NOTES:
 - Congratulations! Your certificate and chain have been saved at:
   /etc/letsencrypt/live/example.com/fullchain.pem
   Your key file has been saved at:
   /etc/letsencrypt/live/example.com/privkey.pem
   Your cert will expire on 2020-11-01. To obtain a new or tweaked
   version of this certificate in the future, simply run certbot again
   with the "certonly" option. To non-interactively renew *all* of
   your certificates, run "certbot renew"
 - If you like Certbot, please consider supporting our work by:

   Donating to ISRG / Let's Encrypt:   https://letsencrypt.org/donate
   Donating to EFF:                    https://eff.org/donate-le
```

### 第5步：验证 Certbot 自动续订
我们获得的加密证书只有 90 天有效期，但不用担心，Certbot会帮我们解决续订问题，它会每天运行两次systemd监测程序来检查域名证书是否快到期。如果域名证书在近 30 天到期，它会自动续订这些域名的证书。

我们可以输入以下命令来检查systemctl的状态：
```
sudo systemctl status certbot.timer
kalasearch@chuan-server:~$ sudo systemctl status certbot.timer

● certbot.timer - Run certbot twice daily
     Loaded: loaded (/lib/systemd/system/certbot.timer; enabled; vendor preset: enabled)
     Active: active (waiting) since Sat 2020-08-01 03:37:47 UTC; 46min ago
    Trigger: Sat 2020-08-01 12:54:45 UTC; 8h left
   Triggers: ● certbot.service

Aug 01 03:37:47 chuan-server systemd[1]: Started Run certbot twice daily.
```

要测试域名证书的续订过程，我们可以输入以下命令：
``` zsh
sudo certbot renew --dry-run
```

## api.kaifaweb.com
api.conf
server {
    listen       443 ssl;
    server_name  api.kaifaweb.com;

    #charset koi8-r;
    #access_log  /var/log/nginx/host.access.log  main;

    location / {
        proxy_pass http://127.0.0.1:3000;
    }

    ssl_certificate  /etc/ssl/private/api.kaifaweb.com_bundle.crt;
    ssl_certificate_key  /etc/ssl/private/api.kaifaweb.com.key;
    ssl_session_timeout 5m;
     #请按照以下协议配置
    ssl_protocols TLSv1 TLSv1.1 TLSv1.2;
    #请按照以下套件配置，配置加密套件，写法遵循 openssl 标准。
    ssl_ciphers ECDHE-RSA-AES128-GCM-SHA256:HIGH:!aNULL:!MD5:!RC4:!DHE;
    ssl_prefer_server_ciphers on;
}

## resume.kaifaweb.com
server {
    listen       80;
    listen       443 ssl;
    server_name  resume.kaifaweb.com;

    location / {
        root /home/remote/resume-template;
        index Q-kil.html;
        try_files $uri $uri/ /Q-kil.html;
    }

    ssl_certificate  /etc/ssl/private/resume.kaifaweb.com_bundle.crt;
    ssl_certificate_key  /etc/ssl/private/resume.kaifaweb.com.key;
    ssl_session_timeout 5m;
     #请按照以下协议配置
    ssl_protocols TLSv1 TLSv1.1 TLSv1.2;
    #请按照以下套件配置，配置加密套件，写法遵循 openssl 标准。
    ssl_ciphers ECDHE-RSA-AES128-GCM-SHA256:HIGH:!aNULL:!MD5:!RC4:!DHE;
    ssl_prefer_server_ciphers on;
}
