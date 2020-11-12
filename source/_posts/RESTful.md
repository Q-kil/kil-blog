---
title: RESTful
date: 2020-06-04 16:18:31
categories:
- network
tag:
- network
---

# 路径规范
http://www.ruanyifeng.com/blog/2014/05/restful_api.html


# ELK
业务背景：
分析日志的用处可大了，你想，假如一个分布式系统有 1000 台机器，系统出现故障时，我要看下日志，还得一台一台登录上去查看，是不是非常麻烦？

反向索引又叫倒排索引，是根据文章内容中的关键字建立索引。
搜索引擎原理就是建立反向索引。
Elasticsearch 在 Lucene 的基础上进行封装，实现了分布式搜索引擎。
Elasticsearch 中的索引、类型和文档的概念比较重要，类似于 MySQL 中的数据库、表和行。
Elasticsearch 也是 Master-slave 架构，也实现了数据的分片和备份。
Elasticsearch 一个典型应用就是 ELK 日志分析系统。

## log信息
时间戳——知道事情发生的时间
计算机/服务器名称——如果你正在运行一个分布式系统
进程ID——如果你正在使用类似pm2的东西运行多个节点进程
消息——包含一些内容的实际消息
堆栈跟踪——用于记录错误的场景
其他一些额外的变量/信息
