---
title: vue3
date: 2022-02-12 16:42:22
categories:
- Frame
tags:
- vue3
---

# Base
技术选型
vue生态 + 工程化的最佳实践

阅读源码

vue3 + TypeScript + pinia(Vuex5) + vue-router

工程化：（循序渐进）
Vite + pnpm + eslint + 各种规范（自动化测试）

复杂度够高的一个项目，不是页面多

一个项目 增删改查 实现功能
1. 数据量大（过万条数据），复杂（5层以上）的场景
2. 完成增删改查后，研发效率的提升（组件库，自动化发布部署CI/CD，写了小工具plugin，团队项目规范）
3. 性能（跑的更快，首屏渲染提高，交互更流畅）
4. 用户体验
5. 项目质量和稳定性

技术选型
1. 框架vue3
2. 语言 Typescript
3. 包管理 pnpm
4. 路由 vue-router
5. 数据管理 pinia
6. vue的工具库 vueuse
7. 组件库：（自己封装一些组件）element3 elementplus naiveui antd-vue
8. 构建工具 vite
9. css预编译器 sass
10. 网络请求：axios（使用ts的类型限制）
11. 代码规范：eslint prettier（尽可能的松散）
12. git的规范 分支管理，hook来做eslint或者单测
13. 代码的部署 github action（纯前端的部署）
14. 自动化测试 vitest // 封装组件时才用
15. 工具函数 lodash
16. 日期处理 dayjs

## 构建项目
pnpm：没有最快只有更快

npm install -g pnpm

pnpm create vite

安装依赖包
pnpm i
Progress: resolved 111, reused 111, downloaded 0, added 111, done
reused 复用的模块

### 项目初始化
删除app.vue里面的内容
安装 vue 提示插件：volar

### Options API 改为 Composition API
``` ts
import { ref } from "vue";
export default{
  setup(){
    let count = ref(2)
    function add(){
      count.value++
    }
    return {count,add}
  }
}

// 简写
<script lang="ts" setup>
import { ref } from "vue";
let val = ref('')
// ref定义的，取值都要.value
console.log(val.value)
```

### ts类型
```ts
<script lang="ts" setup>
import { ref } from "vue";
// 第一种方式:范型  推荐使用
let val = ref<string>('')

// 第二种方式
import { ref, Ref } from "vue";
let val:Ref = ref('')
```

## 入门
### todomvc
基本的增删改查，所有的框架都建议先写一个todo mvc
```ts
// computed 读和写不同的操作
let allDone = computed<boolean>({
  get(){
    return active.value === todos.value.length
  },
  set(value:boolean){
    todos.value.forEach(todo => todo.done = value)
  }
})
```