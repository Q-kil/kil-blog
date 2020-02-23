---
title: Linux
date: 2019-12-28 13:54:02
categories:
- Linux
tags:
- Linux
---
## 指令
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

#### dig
dig命令是常用的域名查询工具，可以用来测试域名系统工作是否正常。
```
dig kaifa.in
返回
;; ANSWER SECTION:
kaifa.in.		16478	IN	A	209.141.38.71
```

## ssh 快捷登录
### 设置
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