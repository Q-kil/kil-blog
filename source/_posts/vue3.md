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