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

## query-filter-context
``` json
GET /_search
{
  "query": { // 查询参数表示查询上下文。
    "bool": { 
      "must": [
        { "match": { "title":   "Search"        }},
        { "match": { "content": "Elasticsearch" }}
      ],
      "filter": [ 
        { "term":  { "status": "published" }},
        { "range": { "publish_date": { "gte": "2015-01-01" }}}
      ]
    }
  }
}
```

## basic
GET /megacorp/employee/_search?q=last_name:Smith

### 或
``` json
GET /my_store/products/_search
{
   "query" :
   {
      "bool" : 
      {
              "should" : 
              [
                 { "term" : {"price" : 20}}, 
                 { "term" : {"productID" : "XHDK-A-1293-#fJ3"}} 
              ]
      }
   }
}
```

### 且
``` json
GET /my_store/products/_search
{
   "query" :
   {
      "bool" : 
      {
              "must" : 
              [
                 { "term" : {"price" : 20}}, 
                 { "term" : {"productID" : "XHDK-A-1293-#fJ3"}} 
              ]
      }
   }
}
```

### 非
``` json
GET /my_store/products/_search
{
   "query" :
   {
      "bool" : 
      {
              "must_not" : {"term" : {"price" : 30} }
      }
   }
}
```

## 查询表达式 
``` json
GET /megacorp/employee/_search
{
    "query" : {
        "match" : {
            "last_name" : "Smith"
        }
    }
}
```

找出一个属性中的独立单词是没有问题的，但有时候想要精确匹配一系列单词或者_短语_ 。 比如， 我们想执行这样一个查询，仅匹配同时包含 “rock” 和 “climbing” ，并且 二者以短语 “rock climbing” 的形式紧挨着的雇员记录。
为此对 match 查询稍作调整，使用一个叫做 match_phrase 的查询
``` json
GET /megacorp/employee/_search
{
    "query" : {
        "match_phrase" : {
            "about" : "rock climbing"
        }
    }
}
```

同样搜索姓氏为 Smith 的员工，但这次我们只需要年龄大于 30 的
``` json
GET /megacorp/employee/_search
{
    "query" : {
        "bool": {
            "must": {
                "match" : {
                    "last_name" : "smith" 
                }
            },
            "filter": {
                "range" : {
                    "age" : { "gt" : 30 } // 这部分是一个 range 过滤器 ， 它能找到年龄大于 30 的文档，其中 gt 表示_大于_(great than)。
                }
            }
        }
    }
}
```

## 分析
aggregations
``` json
GET /megacorp/employee/_search
{
  "aggs": {
    "all_interests": {
      "terms": { "field": "interests" }
    }
  }
}
```

组合查询
与过滤器一样， bool 查询也可以接受 must 、 must_not 和 should 参数下的多个查询语句。比如
``` json
GET /my_index/my_type/_search
{
  "query": {
    "bool": {
      "must":     { "match": { "title": "quick" }},
      "must_not": { "match": { "title": "lazy"  }},
      "should": [
                  { "match": { "title": "brown" }},
                  { "match": { "title": "dog"   }}
      ]
    }
  }
}
```


