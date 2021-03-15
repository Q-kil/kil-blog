---
title: docker
date: 2021-03-01 14:46:11
tags:
---

# 创建容器
$ sudo docker run --name nginxvuemd -v /Users/niekaifa/test/vuem_data.conf:/etc/nginx/conf.d/default.conf -v /Users/niekaifa/ikyu/KilFront/vue-project/dist:/data -d -p 8072:8072 nginx

# 获取容器/镜像的元数据
docker inspect nginx