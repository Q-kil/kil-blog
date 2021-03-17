---
title: ansible
date: 2021-03-17 09:44:22
categories:
- Tool
tags:
- Ansible
---

# base
Playbooks record and execute Ansible’s configuration, deployment, and orchestration functions. They can describe a policy you want your remote systems to enforce, or a set of steps in a general IT process.

# YAML语法
[配置文件详解](https://segmentfault.com/a/1190000010442764)
## stages
stages用来定义可以被job调用的stages。stages的规范允许有灵活的多级pipelines。

stages中的元素顺序决定了对应job的执行顺序：

1. 相同stage的job可以平行执行。
2. 下一个stage的job会在前一个stage的job成功后开始执行。
接下仔细看看这个例子，它包含了3个stage：

``` yaml
stages:
 - build
 - test
 - deploy
```

1、首先，所有build的jobs都是并行执行的。
2、所有build的jobs执行成功后，test的jobs才会开始并行执行。
3、所有test的jobs执行成功，deploy的jobs才会开始并行执行。
4、所有的deploy的jobs执行成功，commit才会标记为success
5、任何一个前置的jobs失败了，commit会标记为failed并且下一个stages的jobs都不会执行。

这有两个特殊的例子值得一提：
如果.gitlab-ci.yml中没有定义stages，那么job's stages 会默认定义为 build，test 和 deploy。
如果一个job没有指定stage，那么这个任务会分配到test stage。


## variables
GitLab Runner V0.5.0. 开始引入
GItLab CI 允许在.gitlab-ci.yml文件中添加变量，并在job环境中起作用。因为这些配置是存储在git仓库中，所以最好是存储项目的非敏感配置，例如：

variables:
  DATABASE_URL:"postgres://postgres@postgres/my_database"
这些变量可以被后续的命令和脚本使用。服务容器也可以使用YAML中定义的变量，因此我们可以很好的调控服务容器。变量也可以定义成job level。

除了用户自定义的变量外，Runner也可以定义它自己的变量。CI_COMMIT_REG_NAME就是一个很好的例子，它的值表示用于构建项目的分支或tag名称。除了在.gitlab-ci.yml中设置变量外，还有可以通过GitLab的界面上设置私有变量。

## tags
tags可以从允许运行此项目的所有Runners中选择特定的Runners来执行jobs。

在注册Runner的过程中，我们可以设置Runner的标签，比如ruby，postgres，development。

tags可通过tags来指定特殊的Runners来运行jobs：

``` yaml
job:
  tags:
    - ruby
    - postgres
```
上面这个示例中，需要确保构建此job的Runner必须定义了ruby和postgres这两个tags。

## script
script
script是Runner执行的yaml脚本。举个例子：

``` yaml
job:
  script: "bundle exec rspec"
```
该参数也可以用数组包含多个命令：

``` yaml
job:
  script:
    - uname -a
    - bundle exec rspec
```
有时候，script命令需要被单引号或者是双引号包裹起来。举个例子，当命令中包含冒号(:)时，script需要被包在双引号中，这样YAML解析器才可以正确解析为一个字符串而不是一个键值对(key:value)。使用这些特殊字符的时候一定要注意：:,{,},[,],,,&,*,#,?,|,-,<,>,=,!。

## stage
stage允许一组jobs进入不同的stages。jobs在相同的stage时会parallel同时进行。查阅stages更多的用法请查看stages。

## only and except
only和except是两个参数用分支策略来限制jobs构建：

only定义哪些分支和标签的git项目将会被job执行。
except定义哪些分支和标签的git项目将不会被job执行。
下面是refs策略的使用规则：

only和except可同时使用。如果only和except在一个job配置中同时存在，则以only为准，跳过except(从下面示例中得出)。
only和except可以使用正则表达式。
only和except允许使用特殊的关键字：branches，tags和triggers。
only和except允许使用指定仓库地址但不是forks的仓库(查看示例3)。
在下面这个例子中，job将只会运行以issue-开始的refs(分支)，然而except中设置将被跳过。

``` yaml
job:
  # use regexp
  only:
    - /^issue-.*$/
  # use special keyword
  except:
    - branches
```

在下面这个例子中，job将只会执行有tags的refs，或者通过API触发器明确地请求构建。

``` yaml
job:
  # use special keywords
  only:
    - tags
    - triggers
```
仓库路径只能用于父级仓库执行jobs，而不是forks：

``` yaml
job:
  only:
    - branches@gitlab-org/gitlab-ce
  except:
    - master@gitlab-org/gitlab-ce
```
上面这个例子将会为所有的分支执行job，但master分支除外。

## Job variables
在job中是可以使用关键字variables来定义job变量。它的运行原理跟global-level是一样的，但是它允许设置特殊的job变量。

当设置了job级别的关键字variables，它会覆盖全局YAML和预定义中的job变量。想要关闭全局变量可以在job中设置一个空数组：

``` yaml
job_name:
  variables: []
```


# issuse
## 跑了两个merge_build_test
`{% asset_img merge_request.png %}`

原因：
merge 请求没有关掉，触发了 merge_requests 条件
`{% asset_img merge.png %}`