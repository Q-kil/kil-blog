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

## base
### hits
使用 _search，结果放在数组 hits 中。一个搜索默认返回十条结果。

### took
took 值告诉我们执行整个搜索请求耗费了多少毫秒。

### shards
_shards 部分告诉我们在查询中参与分片的总数，以及这些分片成功了多少个失败了多少个。正常情况下我们不希望分片失败，但是分片失败是可能发生的。如果我们遭遇到一种灾难级别的故障，在这个故障中丢失了相同分片的原始数据和副本，那么对这个分片将没有可用副本来对搜索请求作出响应。假若这样，Elasticsearch 将报告这个分片是失败的，但是会继续返回剩余分片的结果。

## log信息
时间戳——知道事情发生的时间
计算机/服务器名称——如果你正在运行一个分布式系统
进程ID——如果你正在使用类似pm2的东西运行多个节点进程
消息——包含一些内容的实际消息
堆栈跟踪——用于记录错误的场景
其他一些额外的变量/信息

## 基础语法
query-filter-context

### 轻量搜索
搜索phone为13215693211的数据
GET /logstash-alpha-202*/_search?q=phone:13215693211

### 查询表达式 搜索
GET /logstash-alpha-202*/_search
{
  "query" : {
    "match" : {
      "phone" : "13215693211"
    }
  }
}

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

### 复杂的表达式
使用过滤器 filter 
同样搜索姓氏为 Smith 的员工，但这次我们只需要年龄大于 30 的

range 查询找出那些落在指定区间内的数字或者时间：
gt
大于
gte
大于等于
lt
小于
lte
小于等于

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

### 相关性
Elasticsearch中的 相关性 概念非常重要，也是完全区别于传统关系型数据库的一个概念，数据库中的一条记录要么匹配要么不匹配。
搜索下所有喜欢攀岩（rock climbing）的员工：
``` json
GET /megacorp/employee/_search
{
    "query" : {
        "match" : {
            "about" : "rock climbing"
        }
    }
}
```
``` json
{
   ...
   "hits": {
      "total":      2,
      "max_score":  0.16273327,
      "hits": [
         {
            ...
            "_score":         0.16273327, 
            "_source": {
               "first_name":  "John",
               "last_name":   "Smith",
               "age":         25,
               "about":       "I love to go rock climbing",
               "interests": [ "sports", "music" ]
            }
         },
         {
            ...
            "_score":         0.016878016, 
            "_source": {
               "first_name":  "Jane",
               "last_name":   "Smith",
               "age":         32,
               "about":       "I like to collect rock albums",
               "interests": [ "music" ]
            }
         }
      ]
   }
}
```
她的 about 属性里提到了 “rock” 。因为只有 “rock” 而没有 “climbing” ，所以她的相关性得分低于 John 的。

### 精准匹配
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

``` json
{
   ...
   "hits": {
      "total":      1,
      "max_score":  0.23013961,
      "hits": [
         {
            ...
            "_score":         0.23013961,
            "_source": {
               "first_name":  "John",
               "last_name":   "Smith",
               "age":         25,
               "about":       "I love to go rock climbing",
               "interests": [ "sports", "music" ]
            }
         }
      ]
   }
}
```

### 聚合
聚合（aggregations）
GET /megacorp/employee/_search
{
  "aggs": {
    "all_interests": {
      "terms": { "field": "interests" }
    }
  }
}

## 搜索
### 空搜索
GET /_search
搜索API的最基础的形式是没有指定任何查询的空搜索，它简单地返回集群中所有索引下的所有文档：
``` json
{
  "took" : 11542,
  "timed_out" : false,
  "num_reduce_phases" : 3,
  "_shards" : {
    "total" : 1045,
    "successful" : 1045,
    "skipped" : 0,
    "failed" : 0
  },
  "hits" : {
    "total" : {
      "value" : 10000,
      "relation" : "gte"
    },
    "max_score" : 1.0,
    "hits" : [
```

hits： 采样数

### 多索引，多类型
多索引，多类型
你有没有注意到之前的 empty search 的结果，不同类型的文档— user 和 tweet 来自不同的索引— us 和 gb ？

如果不对某一特殊的索引或者类型做限制，就会搜索集群中的所有文档。Elasticsearch 转发搜索请求到每一个主分片或者副本分片，汇集查询出的前10个结果，并且返回给我们。

然而，经常的情况下，你想在一个或多个特殊的索引并且在一个或者多个特殊的类型中进行搜索。我们可以通过在URL中指定特殊的索引和类型达到这种效果，如下所示：

/_search
在所有的索引中搜索所有的类型
/gb/_search
在 gb 索引中搜索所有的类型
/gb,us/_search
在 gb 和 us 索引中搜索所有的文档
/g*,u*/_search
在任何以 g 或者 u 开头的索引中搜索所有的类型
/gb/user/_search
在 gb 索引中搜索 user 类型
/gb,us/user,tweet/_search
在 gb 和 us 索引中搜索 user 和 tweet 类型
/_all/user,tweet/_search
在所有的索引中搜索 user 和 tweet 类型
当在单一的索引下进行搜索的时候，Elasticsearch 转发请求到索引的每个分片中，可以是主分片也可以是副本分片，然后从每个分片中收集结果。多索引搜索恰好也是用相同的方式工作的—​只是会涉及到更多的分片。

### 分页
size
显示应该返回的结果数量，默认是 10
from
显示应该跳过的初始结果数量，默认是 0
如果每页展示 5 条结果，可以用下面方式请求得到 1 到 3 页的结果：
```
GET /_search?size=5
GET /_search?size=5&from=5
GET /_search?size=5&from=10
```

```
GET /logstash-alpha-2021.04*/_search
{
  "query": {
  },
  "size" : 0, // 0: 不显示详细信息，10: 显示每条详细信息
  "aggs" : {
  }
}
```

### 映射和分析
当摆弄索引里面的数据时，我们发现一些奇怪的事情。一些事情看起来被打乱了：在我们的索引中有12条推文，其中只有一条包含日期 2014-09-15 ，但是看一看下面查询命中的 总数 （total）：
```
GET /_search?q=2014              # 12 results
GET /_search?q=2014-09-15        # 12 results !
GET /_search?q=date:2014-09-15   # 1  result
GET /_search?q=date:2014         # 0  results !
```

### 字段折叠
GET /logstash-alpha-202*/_search
{
  "query":{
    "bool": {
      "must": {
        "match": { "event": "online_time" } 
      },
      "filter": {
        "range": {
          "timestamp": {
            "gt": "2021-05-18T16:00:00Z",
            "lt": "2021-05-19T15:59:59Z"
          }
        }
      }
    }
  },
  "size": 0,
  "aggs": {
    "lists": {
      "terms": {
        "field": "userId.keyword",
        "size": 10000
      },
      "aggs":{
	      "details_hits":{
	        "top_hits":{
            "_source": {
              "includes": [
                "userId",
                "phone",
                "nickname",
                "username"
              ]
            },
	          "size":1
	        }
	      }
	    }
    }
  }
}


### term
term 查询被用于精确值匹配，这些精确值可能是数字、时间、布尔或者那些 not_analyzed 的字符串：
```
{ "term": { "age":    26           }}
{ "term": { "date":   "2014-09-01" }}
{ "term": { "public": true         }}
{ "term": { "tag":    "full_text"  }}
```

### terms 查询
terms 查询和 term 查询一样，但它允许你指定多值进行匹配。如果这个字段包含了指定值中的任何一个值，那么这个文档满足条件：
```
{ "terms": { "tag": [ "search", "full_text", "nosql" ] }}
```

### 多级排序
```json
GET /_search
{
    "query" : {
        "bool" : {
            "must":   { "match": { "tweet": "manage text search" }},
            "filter" : { "term" : { "user_id" : 2 }}
        }
    },
    "sort": [
        { "date":   { "order": "desc" }},
        { "_score": { "order": "desc" }}
    ]
}
```

### 正则
``` json
GET /logstash-alpha-*/_search
{
  "query": {
    "bool": {
      "must": {
        "match": {
          "event": "game_sign"
        }
      },
      "filter": {
        "regexp":{
            "phone" : "[1]{1}[3-9]{1}[0-9]{9}"
        }
      }
    }
  }
}
```

### 日期，东八区
Elasticsearch默认为UTC时间，即零时区，查询时若不指定时区，则默认以0时区查询，和我们所在的东八区差8小时。yyyy-MM-dd'T'HH:mm:ss.SSSZ，这里的Z就代表UTC时区。
Es在进行日期查询/聚合时可以指定时区：
```
//日期范围查询
POST datatypetest/_search
{
  "query": {
    "range": {
      "date3": {
        "gte": "2018-07-05",
        "lte": "now",
        "time_zone": "Asia/Shanghai"//这就是东八区（北京时间/中国标准时间）
      }
    }
  }
}
```

```
//日期聚合
GET my_index/_search?size=0
{
  "aggs": {
    "by_day": {
      "date_histogram": {
        "field":     "date",
        "interval":  "day",
        "time_zone": "Asia/Shanghai"
      }
    }
  }
}
```

#### 不同时间
CST：中国标准时间（China Standard Time），这个解释可能是针对RedHat Linux。

UTC：协调世界时，又称世界标准时间，简称UTC，从英文国际时间/法文协调时间”Universal Time/Temps Cordonné”而来。中国大陆、香港、澳门、台湾、蒙古国、新加坡、马来西亚、菲律宾、澳洲西部的时间与UTC的时差均为+8，也就是UTC+8。

GMT：格林尼治标准时间（旧译格林威治平均时间或格林威治标准时间；英语：Greenwich Mean Time，GMT）是指位于英国伦敦郊区的皇家格林尼治天文台的标准时间，因为本初子午线被定义在通过那里的经线。

### 处理文档数目非零的 buckets
date_histogram （和 histogram 一样）默认只会返回文档数目非零的 buckets。
```
GET /cars/transactions/_search
{
   "size" : 0,
   "aggs": {
      "sales": {
         "date_histogram": {
            "field": "sold",
            "interval": "month",
            "format": "yyyy-MM-dd",
            "min_doc_count" : 0,  // 这个参数强制返回空 buckets。
            "extended_bounds" : {  // 这个参数强制返回整年。
                "min" : "2014-01-01",
                "max" : "2014-12-31"
            }
         }
      }
   }
}
```

### 去重
```
{
  "query": {},
    "aggs" : {
    "count": {
      "date_histogram" : {
        "field": "timestamp",
        "interval": "day",
        "time_zone": "Asia/Shanghai",
        "format": "yyyy-MM-dd"
      },
      "aggs": {
          "unique_doc_count" : {
              "cardinality" : {
                "field" : "user_id"
              }
          }
        }
    }
  }
}
```

## Index Patterns
This page lists every field in the logstash-alpha-* index and the field's associated core type as recorded by Elasticsearch. To change a field type, use the Elasticsearch Mapping API 
`{% asset_img index.png %}`

## 分析
挖掘出员工中最受欢迎的兴趣爱好：
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

次日留存
``` js
async morrowLoginRate() {
    // const querySignupParam = {name: 'game_sign_day_before', regexp: true};
    // let querySignupData = this.generateQueryForLog(querySignupParam);
    // const signupBeforeDayData = await this.http.post(environment.ELK_URL + "202*/_search",
    //   querySignupData
    // ).toPromise();
    // console.log('signupBeforeDayData', signupBeforeDayData);

    console.log('this.signupDatas', this.resultDatas);

    // const queryMorrowRate = {name: 'online_time', regexp: false, createdOffsetDay: 1, aggs: {unique_online_count: {cardinality: {field: 'userId.keyword'}}}};
    const queryMorrowRate = {name: 'morrow_data', createdOffsetDay: 1, aggs: {unique_online_count: {cardinality: {field: 'userId.keyword'}}}};
    let queryMorrowData = this.generateQueryForLog(queryMorrowRate);
    const morrowData = await this.http.post(environment.ELK_URL + "202*/_search",
    queryMorrowData
    ).toPromise();
    console.log('morrowData', morrowData);

    const morrows = morrowData.aggregations.count.buckets;
    // const befores = signupBeforeDayData.aggregations.count.buckets;

    for (let i = 0; i < this.resultDatas.length; i++) {
      const r = this.resultDatas[i];
      const tomorrow = moment(r.time).add(+1, 'days');
      const tomorrowMoment = OneDay(tomorrow);
      for (let j = 0; j < morrows.length; j++) {
        const morrow = morrows[j];
        if (morrow.key_as_string === tomorrowMoment) {
          const rate = (morrow.unique_online_count.value / r.signup) * 100;
          console.log('rate', rate, isNaN(rate));
          if (!rate) {
            r.morrow_login_rate = '-';
          } else {
            r.morrow_login_rate = Math.round(rate) + '%';
          }
        }
      }
    }

    console.log('morrows +++++', this.resultDatas);

    this.loadTotalUser();
  }
```

