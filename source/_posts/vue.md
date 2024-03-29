---
title: vue
date: 2020-04-15 15:14:21
categories:
- Frame
tags:
- vue
- vuex
---


# base
渐进式：主张最少
设计理念：自低向上逐层应用
你可以使用vue核心：声明式渲染，组件系统
你也可以使用下面这个图的全部
`{% asset_img core.png %}`

## 与jQuery对比
jQuery时代的开发逻辑，就是我们先要找到目标元素，然后再进行对应的修改。
学习 Vue.js，首先要进行思想的升级，不要再思考页面的元素怎么操作，而是要思考数据是怎么变化的。

## 与angular对比
Angular 双向绑定
Vue 在不同组件间强制使用单向数据流。这使应用中的数据流更加清晰易懂。

## vue3
### 优秀的设计
Composition 组合 API、基于 Proxy 的响应式系统、自定义渲染器


## config
### change port
vue.config.js
``` js
module.exports = {
  devServer: {
    port: 8090
  }
}
```

## font
app.vue
``` vue
<style lang="scss">
@font-face {
  font-family: "SourceHanSansCN";
  src: url(./assets/font/SourceHanSansCN-Normal.otf);
}
```

## 声明式渲染
指令
指令带有前缀 `v-`
``` html
<span v-bind:title="message">
  鼠标悬停几秒钟查看此处动态绑定的提示信息！
</span>
```

`v-on` 指令添加一个事件监听器

`v-model` 双向绑定

### v-model 指令
``` html
<input v-model="text" />
```

上例不过是一个语法糖，展开来是：

``` html
<input
  :value="text"
  @input="e => text = e.target.value"
/>
```

## 组件
小型、独立和通常可复用的组件构建大型应用
一个组件本质上是一个拥有预定义选项的一个 Vue 实例
``` js
// 定义名为 todo-item 的新组件
Vue.component('todo-item', {
  template: '<li>这是个待办项</li>'
})
```

``` html
<!-- 创建一个 todo-item 组件的实例 -->
<todo-item></todo-item>
```

### 父传子 prop
props(或properties)是我们将数据从父组件向下传递到其子组件的方式。

``` js
Vue.component('todo-item', {
  // todo-item 组件现在接受一个
  // "prop"，类似于一个自定义特性。
  // 这个 prop 名为 todo。
  props: ['todo'],
  template: '<li>{{ todo.text }}</li>'
})
```

``` html
<todo-item
  v-bind:todo="item">
</todo-item>
```

### 子组件中调用父组件方法
```js
this.$parent.parentFun();
this.$emit('getParentFun');
// 第三种：props传入
this.fun();
```

## Vue实例
没有完全遵循 MVVM 模型
`vm` (ViewModel 的缩写) 这个变量名表示 Vue 实例

Vue 实例还暴露了一些有用的实例属性与方法。它们都有前缀 `$`，以便与用户定义的属性区分开来。
``` js
var data = { a: 1 }
var vm = new Vue({
  el: '#example',
  data: data
})

vm.$data === data // => true
vm.$el === document.getElementById('example') // => true

// $watch 是一个实例方法
vm.$watch('a', function (newValue, oldValue) {
  // 这个回调将在 `vm.a` 改变后调用
})
```

不要在选项属性或回调上使用箭头函数, 因为箭头函数是和父级上下文绑定在一起的，this 不会是如你所预期的 Vue 实例.

### 生命周期 life cycle
`{% asset_img lifecycle.png %}`


## 模版语法
基于 HTML 的模板语法
在底层的实现上，Vue 将模板编译成虚拟 DOM 渲染函数。结合响应系统，Vue 能够智能地计算出最少需要重新渲染多少组件，并把 DOM 操作次数减到最少。

如果你熟悉虚拟 DOM 并且偏爱 JavaScript 的原始力量，你也可以不用模板，直接写渲染 (render) 函数，使用可选的 JSX 语法。

### 插值
#### 文本
v-once 指令，执行一次性地插值，当数据改变时，插值处的内容不会更新

#### 原始 HTML
``` html
<div v-html="html1"></div>

<div><i>1111</i></div>
```

#### 特性
``` html
<button v-bind:disabled="isButtonDisabled">Button</button>
```
如果 isButtonDisabled 的值是 `null`、`undefined` 或 `false`，则 disabled 特性甚至不会被包含在渲染出来的 `<button>` 元素中。

#### 使用 JavaScript 表达式
只能包含**单个表达式**

``` html
<!-- 这是语句，不是表达式 -->
{{ var a = 1 }}

<!-- 流控制也不会生效，请使用三元表达式 -->
{{ if (ok) { return message } }}
```

### 指令
#### 修饰符
修饰符 (Modifiers) 是以半角句号 . 指明的特殊后缀，用于指出一个指令应该以特殊方式绑定。

[修饰符大全](https://segmentfault.com/a/1190000016786254).

### 缩写
#### v-bind 缩写
``` html
<!-- 完整语法 -->
<a v-bind:href="url">...</a>

<!-- 缩写 -->
<a :href="url">...</a>
```

#### v-on 缩写
``` html
<!-- 完整语法 -->
<a v-on:click="doSomething">...</a>

<!-- 缩写 -->
<a @click="doSomething">...</a>
```

## 计算属性和侦听器
### 计算属性
``` js
computed: {
  // 计算属性的 getter
  reversedMessage: function () {
    // `this` 指向 vm 实例
    return this.message.split('').reverse().join('')
  }
}
```

#### 计算属性缓存 vs 方法
#### 计算属性 vs 侦听属性
#### 计算属性的 setter


## Class与Style绑定
### 对象语法
给 v-bind:class 一个对象，以动态地切换 class：
``` html
<div v-bind:class="{ active: isActive }"></div>
```

### 数组语法
把一个数组传给 v-bind:class，以应用一个 class 列表：
``` html
<div v-bind:class="[activeClass, errorClass]"></div>
```

``` js
data: {
  activeClass: 'active',
  errorClass: 'text-danger'
}
```

## 条件渲染
### 用 key 管理可复用的元素
切换登录方式时，是否保留用户输入的文本

### v-show
v-show 的元素始终会被渲染并保留在 DOM 中。v-show 只是简单地切换元素的 CSS property display

## 列表渲染
v-for 还支持一个可选的第二个参数，即当前项的索引
``` html
  <li v-for="(item, index) in items">
```

也可以用 of 替代 in 作为分隔符，因为它更接近 JavaScript 迭代器的语法：
``` html
<div v-for="item of items"></div>
```

### 在 v-for 里使用对象
``` html
<li v-for="value in object">
  {{ value }}
</li>

<div v-for="(value, name) in object">
  {{ name }}: {{ value }}
</div>
```

### 显示过滤/排序后的结果
在计算属性不适用的情况下 (例如，在嵌套 v-for 循环中) 可以使用一个方法：
```html
<ul v-for="set in sets">
  <li v-for="n in even(set)">{{ n }}</li>
</ul>
```

```js
data: {
  sets: [[ 1, 2, 3, 4, 5 ], [6, 7, 8, 9, 10]]
},
methods: {
  even: function (numbers) {
    return numbers.filter(function (number) {
      return number % 2 === 0
    })
  }
}
```

### 在 v-for 里使用值范围
```html
<div>
  <span v-for="n in 10">{{ n }} </span>
</div>
```

2.2.0+ 的版本里，当在组件上使用 v-for 时，key 现在是必须的。

## 事件处理
### 事件修饰符
#### .sync 修饰符
``` html
<my-dialog :visible.sync="dialogVisible" />
```

这也是一个语法糖，剥开来是：

``` html
<my-dialog
  :visible="dialogVisible"
  @update:visible="newVisible => dialogVisible = newVisible"
/>
```

## 表单输入绑定
### 多个复选框
``` html
<input type="checkbox" id="lily" value="lily" v-model="checknames">
<label for="lily">lily</label>
<input type="checkbox" id="seri" value="seri" v-model="checknames">
<label for="seri">seri</label>
<div>{{ checknames }}</div>
```

### 修饰符
如果要自动过滤用户输入的首尾空白字符，可以给 v-model 添加 trim 修饰符：
``` html
<input v-model.trim="msg">
```

## 组件
### 父子组件传值
父级组件可以像处理 native DOM 事件一样通过 v-on 监听子组件实例的任意事件：
``` html
<blog-post
  v-on:enlarge-text="postFontSize += 0.1"
></blog-post>
```
子组件可以通过调用内建的 $emit 方法并传入事件名称来触发一个事件：
``` html
<button v-on:click="$emit('enlarge-text')">
  Enlarge text
</button>
```

#### 使用事件抛出一个值
使用 $emit 的第二个参数来提供这个值：
``` html
<button v-on:click="$emit('enlarge-text', 0.1)">
  Enlarge text
</button>
```
父级组件监听这个事件的时候，我们可以通过 $event 访问到被抛出的这个值：
``` html
<blog-post
  v-on:enlarge-text="postFontSize += $event"
></blog-post>
```
这个事件处理函数是一个方法：
``` html
<blog-post
  v-on:enlarge-text="onEnlargeText"
></blog-post>
```

### 在组件上使用 v-model
``` html
<input v-model="searchText">
==
<input
  v-bind:value="searchText"
  v-on:input="searchText = $event.target.value"
>
```

### prop
Prop 的大小写 (camelCase vs kebab-case)
HTML 中的 attribute 名是大小写不敏感的，所以浏览器会把所有大写字符解释为小写字符。这意味着当你使用 DOM 中的模板时，camelCase (驼峰命名法) 的 prop 名需要使用其等价的 kebab-case (短横线分隔命名) 命名：
``` html
props: ['postTitle'],
<blog-post post-title="hello!"></blog-post>
```
















[第三第四种双向绑定](https://juejin.im/post/5aaa9eabf265da237b21d36a)

# vuex
Vuex 是一个专为 Vue.js 应用程序开发的状态管理模式。它采用集中式存储管理应用的所有组件的状态，并以相应的规则保证状态以一种可预测的方式发生变化。

Vuex 可以帮助我们管理共享状态，并附带了更多的概念和框架。这需要对短期和长期效益进行权衡。
如果您不打算开发大型单页应用，使用 Vuex 可能是繁琐冗余的。确实是如此——如果您的应用够简单，您最好不要使用 Vuex。一个简单的 store （仓库）模式就足够您所需了。但是，如果您需要构建一个中大型单页应用，您很可能会考虑如何更好地在组件外部管理状态，Vuex 将会成为自然而然的选择。

## 介绍
### 什么是"状态管理模式"
一个简单的vue计数应用
``` js
new Vue({
  // state
  data(){
    return{
      count: 0
    }
  },
  //view
  template:`
    <div>{{count}}</div>
  `,
  methods: {
    increment(){
      this.count++
    }
  }
})
```
这个状态自管理应用包含以下几个部分：
- state，驱动应用的数据源；
- view，以声明方式将 state 映射到视图；
- actions，响应在 view 上的用户输入导致的状态变化。

"单向数据流"理念图
`{% asset_img flow.png %}`

多个组件共享状态时，单向数据流容易破坏
- 多个视图依赖同一状态（兄弟组件间的状态传递无能为力）
- 来自不同视图的行为需要变更同一状态（父子props $emit传值模式不利于维护）

vuex 设计理念：把组件的共享状态抽取出来，以一个全局单例模式管理。
`{% asset_img vuex.png %}`

### 什么情况下我应该使用 Vuex？
大型单页应用

如果项目简单就用：store模式
``` js
var store = {
  debug: true,
  state: {
    message: 'Hello!'
  },
  setMessageAction (newValue) {
    if (this.debug) console.log('setMessageAction triggered with', newValue)
    this.state.message = newValue
  },
  clearMessageAction () {
    if (this.debug) console.log('clearMessageAction triggered')
    this.state.message = ''
  }
}

var vmA = new Vue({
  data: {
    privateState: {},
    sharedState: store.state
  }
})

var vmB = new Vue({
  data: {
    privateState: {},
    sharedState: store.state
  }
})
```

### 开始
每一个 Vuex 应用的核心就是 store（仓库）。“store”基本上就是一个容器，它包含着你的应用中大部分的状态 (state)。Vuex 和单纯的全局对象有以下两点不同：

- Vuex 的状态存储是响应式的。当 Vue 组件从 store 中读取状态的时候，若 store 中的状态发生变化，那么相应的组件也会相应地得到高效更新。

- 你不能直接改变 store 中的状态。改变 store 中的状态的唯一途径就是显式地提交 (commit) mutation。这样使得我们可以方便地跟踪每一个状态的变化，从而让我们能够实现一些工具帮助我们更好地了解我们的应用。

#### 最简单的Store
在`main.js`中加入
``` js
import vuex from 'vuex'
Vue.use(vuex);
var store = new vuex.Store({//store对象
    state:{
        show:false
    }
})
// 为了在 Vue 组件中访问 this.$store property，你需要为 Vue 实例提供创建好的 store。Vuex 提供了一个从根组件向所有子组件，以 store 选项的方式“注入”该 store 的机制
new Vue({
  el: '#app',
  router,
  store, //添加 使用store
  template: '<App/>',
})
```

使用
``` html
<h1>{{ $store.state.show }}</h1>
```

从任意组件的方法提交一个变更：
``` js
methods: {
  increment() {
    this.$store.commit('increment')
    console.log(this.$store.state.count)
  }
}
```
我们通过提交 mutation 的方式，而非直接改变 store.state.count，是因为我们想要更明确地追踪到状态的变化。这个简单的约定能够让你的意图更加明显，这样你在阅读代码的时候能更容易地解读应用内部的状态改变。此外，这样也让我们有机会去实现一些能记录每次状态改变，保存状态快照的调试工具。有了它，我们甚至可以实现如时间穿梭般的调试体验。

由于 store 中的状态是响应式的，在组件中调用 store 中的状态简单到仅需要在计算属性中返回即可。触发变化也仅仅是在组件的 methods 中提交 mutation。

### modules
前面为了方便 , 我们把 store 对象写在了 main.js 里面 , 但实际上为了便于日后的维护 , 我们分开写更好 , 我们在 src 目录下 , 新建一个 store 文件夹 , 然后在里面新建一个 index.js :
``` js
import Vue from 'vue'
import vuex from 'vuex'
Vue.use(vuex);

export default new vuex.Store({
    state:{
        show:false
    }
})
```

那么相应的 , 在 main.js 里的代码应该改成 :
``` js
//vuex
import store from './store'

new Vue({
  el: '#app',
  router,
  store,//使用store
  template: '<App/>'
})
```

使用vuex 的`modules`, 把store文件夹下的index.js改成
``` js
import Vue from 'vue'
import vuex from 'vuex'
Vue.use(vuex);

import dialog_store from './dialog_store.js';//引入某个store对象

export default new vuex.Store({
    modules: {
        dialog: dialog_store
    }
})
```

dialog_store.js
``` js
export default {
    state:{
        show:false
    }
}
```
做出这样的修改之后 , 我们将之前我们使用的 $store.state.show 统统改为 `$store.state.dialog.show` 即可。

## 核心概念
### State
单一状态树。
Vuex的状态存储是响应式的。

#### 在vue组件中获取vuex状态
从store实例中读取状态最简单的方法：在 计算属性 中返回某个状态
``` js
// 创建一个 Counter 组件
const Counter = {
  template: `<div>{{ count }}</div>`,
  computed: {
    count () {
      return this.$store.state.count
    }
  }
}
```

#### mapState辅助函数
当一个组件需要获取多个状态的时候，将这些状态都声明为计算属性会有些重复和冗余
``` js
// 在单独构建的版本中辅助函数为 Vuex.mapState
import { mapState } from 'vuex'

export default {
  // ...
  computed: mapState({
    // 箭头函数可使代码更简练
    count: state => state.count,

    // 传字符串参数 'count' 等同于 `state => state.count`
    countAlias: 'count',

    // 为了能够使用 `this` 获取局部状态，必须使用常规函数
    countPlusLocalState (state) {
      return state.count + this.localCount
    }
  })
}
```
当映射的计算属性的名称与 state 的子节点名称相同时，可以给 mapState 传一个字符串数组。
``` js
computed: mapState([
  // 映射 this.count 为 store.state.count
  'count'
])
```

#### 对象展开运算符
``` js
computed: {
  localComputed () { /* ... */ },
  // 使用对象展开运算符将此对象混入到外部对象中
  ...mapState({
    // ...
  })
}
```

babel不识别对象展开运算符时报错
yarn add babel-plugin-transform-object-rest-spread -D
babel配置文件
"plugins":["transform-object-rest-spread"]

### Getters
Vuex 允许我们在 store 中定义“getter”（可以认为是 store 的计算属性）。就像计算属性一样，getter 的返回值会根据它的依赖被缓存起来，且只有当它的依赖值发生了改变才会被重新计算。
``` js
const store = new Vuex.Store({
  state: {
    todos: [
      { id: 1, text: '...', done: true },
      { id: 2, text: '...', done: false }
    ]
  },
  getters: {
    doneTodos: state => {
      return state.todos.filter(todo => todo.done)
    }
  }
})
```

#### 通过属性访问
```js
store.getters.doneTodos // -> [{ id: 1, text: '...', done: true }]

computed: {
  ...mapGetters([
    'doneTodosCount'
  ])
}
```


### Mutations
更改 Vuex 的 store 中的状态的唯一方法是提交 mutation
mutation 都有一个字符串的 事件类型 (type) 和 一个 回调函数 (handler)。这个回调函数就是我们实际进行状态更改的地方，并且它会接受 state 作为第一个参数：
```js
const store = new Vuex.Store({
  state: {
    count: 1
  },
  mutations: {
    increment (state) {
      // 变更状态
      state.count++
    }
  }
})
```
你不能直接调用一个 mutation handler。这个选项更像是事件注册：“当触发一个类型为 increment 的 mutation 时，调用此函数。”要唤醒一个 mutation handler，你需要以相应的 type 调用 store.commit 方法：
```js
store.commit('increment')
```

#### 提交载荷（Payload）
向 store.commit 传入额外的参数，即 mutation 的 载荷（payload）：
```js
mutations: {
  increment (state, n) {
    state.count += n
  }
}
store.commit('increment', 10)
```

#### 使用常量替代 Mutation 事件类型
在需要多人协作的大型项目中，这会很有帮助。
``` js
// mutation-types.js
export const SOME_MUTATION = 'SOME_MUTATION'
```

``` js
// store.js
import Vuex from 'vuex'
import { SOME_MUTATION } from './mutation-types'

const store = new Vuex.Store({
  state: { ... },
  mutations: {
    // 我们可以使用 ES2015 风格的计算属性命名功能来使用一个常量作为函数名
    [SOME_MUTATION] (state) {
      // mutate state
    }
  }
})
```

#### Mutation 必须是同步函数
``` js
mutations: {
  someMutation (state) {
    api.callAsyncMethod(() => {
      state.count++
    })
  }
}
```
现在想象，我们正在 debug 一个 app 并且观察 devtool 中的 mutation 日志。每一条 mutation 被记录，devtools 都需要捕捉到前一状态和后一状态的快照。然而，在上面的例子中 mutation 中的异步函数中的回调让这不可能完成：因为当 mutation 触发的时候，回调函数还没有被调用，devtools 不知道什么时候回调函数实际上被调用——实质上任何在回调函数中进行的状态的改变都是不可追踪的。

#### 在组件中提交 Mutation
你可以在组件中使用 this.$store.commit('xxx') 提交 mutation，或者使用 mapMutations 辅助函数将组件中的 methods 映射为 store.commit 调用（需要在根节点注入 store）。
``` js
import { mapMutations } from 'vuex'

export default {
  // ...
  methods: {
    ...mapMutations([
      'increment', // 将 `this.increment()` 映射为 `this.$store.commit('increment')`

      // `mapMutations` 也支持载荷：
      'incrementBy' // 将 `this.incrementBy(amount)` 映射为 `this.$store.commit('incrementBy', amount)`
    ]),
    ...mapMutations({
      add: 'increment' // 将 `this.add()` 映射为 `this.$store.commit('increment')`
    })
  }
}
```

### Actions
Action 类似于 mutation，不同在于：
- Action 提交的是 mutation，而不是直接变更状态。
- Action 可以包含任意异步操作。

Action 函数接受一个与 store 实例具有相同方法和属性的 context 对象，因此你可以调用 context.commit 提交一个 mutation，或者通过 context.state 和 context.getters 来获取 state 和 getters。
``` js
const store = new Vuex.Store({
  state: {
    count: 0
  },
  mutations: {
    increment (state) {
      state.count++
    }
  },
  actions: {
    increment (context) {
      context.commit('increment')
    }
  }
})
```

#### 分发Action
Action 通过 `store.dispatch` 方法触发：
``` js
store.dispatch('increment')
```
乍一眼看上去感觉多此一举，我们直接分发 mutation 岂不更方便？实际上并非如此，还记得 mutation 必须同步执行这个限制么？Action 就不受约束！我们可以在 action 内部执行异步操作：
``` js
actions: {
  incrementAsync ({ commit }) {
    setTimeout(() => {
      commit('increment')
    }, 1000)
  }
}
```

Actions 支持同样的载荷方式和对象方式进行分发：
```js
// 以载荷形式分发
store.dispatch('incrementAsync', {
  amount: 10
})

// 以对象形式分发
store.dispatch({
  type: 'incrementAsync',
  amount: 10
})
```

购物车示例，涉及到调用异步 API 和分发多重 mutation：

#### 在组件中分发 Action
你在组件中使用 this.$store.dispatch('xxx') 分发 action，或者使用 mapActions 辅助函数将组件的 methods 映射为 store.dispatch 调用（需要先在根节点注入 store）：
``` js
import { mapActions } from 'vuex'

export default {
  // ...
  methods: {
    ...mapActions([
      'increment', // 将 `this.increment()` 映射为 `this.$store.dispatch('increment')`

      // `mapActions` 也支持载荷：
      'incrementBy' // 将 `this.incrementBy(amount)` 映射为 `this.$store.dispatch('incrementBy', amount)`
    ]),
    ...mapActions({
      add: 'increment' // 将 `this.add()` 映射为 `this.$store.dispatch('increment')`
    })
  }
}
```

#### 组合Action
Action 通常是异步的，那么如何知道 action 什么时候结束呢？更重要的是，我们如何才能组合多个 action，以处理更加复杂的异步流程？

首先，你需要明白 store.dispatch 可以处理被触发的 action 的处理函数返回的 Promise，并且 store.dispatch 仍旧返回 Promise：
``` js
actions: {
  actionA ({ commit }) {
    return new Promise((resolve, reject) => {
      setTimeout(() => {
        commit('someMutation')
        resolve()
      }, 1000)
    })
  }
}
```

现在可以
``` js
store.dispatch('actionA').then(() => {
  // ...
})
```

另外一个 action 中也可以
``` js
actions: {
  // ...
  actionB ({ dispatch, commit }) {
    return dispatch('actionA').then(() => {
      commit('someOtherMutation')
    })
  }
}
```

利用 async / await (opens new window)，组合 action：
``` js
// 假设 getData() 和 getOtherData() 返回的是 Promise

actions: {
  async actionA ({ commit }) {
    commit('gotData', await getData())
  },
  async actionB ({ dispatch, commit }) {
    await dispatch('actionA') // 等待 actionA 完成
    commit('gotOtherData', await getOtherData())
  }
}
```

### Modules
由于使用单一状态树，应用的所有状态会集中到一个比较大的对象。当应用变得非常复杂时，store 对象就有可能变得相当臃肿。

为了解决以上问题，Vuex 允许我们将 store 分割成模块（module）。每个模块拥有自己的 state、mutation、action、getter、甚至是嵌套子模块——从上至下进行同样方式的分割：
``` js
const moduleA = {
  state: () => ({ ... }),
  mutations: { ... },
  actions: { ... },
  getters: { ... }
}

const moduleB = {
  state: () => ({ ... }),
  mutations: { ... },
  actions: { ... }
}

const store = new Vuex.Store({
  modules: {
    a: moduleA,
    b: moduleB
  }
})

store.state.a // -> moduleA 的状态
store.state.b // -> moduleB 的状态
```

组件中使用
``` js
...mapState({
  a: state => state.a
}),
```

#### 模块动态注册
``` js
import Vuex from 'vuex'

const store = new Vuex.Store({ /* 选项 */ })

// 注册模块 `myModule`
store.registerModule('myModule', {
  // ...
})
```


### 项目结构示例
``` sh
├── index.html
├── main.js
├── api
│   └── ... # 抽取出API请求
├── components
│   ├── App.vue
│   └── ...
└── store
    ├── index.js          # 我们组装模块并导出 store 的地方
    ├── actions.js        # 根级别的 action
    ├── mutations.js      # 根级别的 mutation
    └── modules
        ├── cart.js       # 购物车模块
        └── products.js   # 产品模块
```        

# Vue实例
## 数据
只有当实例被创建时就已经存在于 data 中的 property 才是响应式的。

Vue 实例还暴露了一些有用的实例 property 与方法，它们都有前缀 $，以便与用户定义的 property 区分开来。
```js
var data = { a: 1 }
var vm = new Vue({
  el: '#example',
  data: data
})

vm.$data === data // => true
vm.$el === document.getElementById('example') // => true

// $watch 是一个实例方法
vm.$watch('a', function (newValue, oldValue) {
  // 这个回调将在 `vm.a` 改变后调用
})
```

## 生命周期
每个 Vue 实例在被创建时都要经过一系列的初始化过程——例如，需要设置数据监听、编译模板、将实例挂载到 DOM 并在数据变化时更新 DOM 等。同时在这个过程中也会运行一些叫做生命周期钩子的函数，这给了用户在不同阶段添加自己的代码的机会。

不要在选项 property 或回调上使用箭头函数，比如 
created: () => console.log(this.a) 或 vm.$watch('a', newValue => this.myMethod())。
因为箭头函数并没有 this，this 会作为变量一直向上级词法作用域查找，直至找到为止


`{% asset_img life_cycle.png %}`
created:在模板渲染成html前调用，即通常初始化某些属性值，然后再渲染成视图。
mounted:在模板渲染成html后调用，通常是初始化页面完成后，再对html的dom节点进行一些需要的操作。

# 系统的看 vue 官网 
evan you：我想你会乐在其中
## fetch
Fetch是基于promise设计的，它不是ajax的进一步封装，而是原生js API，没有使用XMLHttpRequest对象

## pop
Vue
变异方法
push() 方法可向数组的末尾添加一个或多个元素，并返回新的长度。
pop() 方法用于删除并返回数组的最后一个元素。
shift() 方法用于把数组的第一个元素从其中删除，并返回第一个元素的值。
unshift() 方法可向数组的开头添加一个或更多元素，并返回新的长度。
splice() 方法向/从数组中添加/删除项目，然后返回被删除的项目。
sort() 方法用于对数组的元素进行排序。
reverse() 方法用于颠倒数组中元素的顺序。
替换数组
filter() 方法创建一个新的数组，新数组中的元素是通过检查指定数组中符合条件的所有元素。
concat() 方法用于连接两个或多个数组。
slice() 方法可从已有的数组中返回选定的元素。
其他
split() 方法用于把一个字符串分割成字符串数组。


## 初始值
``` js
data: {
  newTodoText: '',
  visitCount: 0,
  hideCompletedTodos: false,
  todos: [],
  error: null
}
```


# router
两个模式：
- hash
- history

## history
利用 history.pushState API 来完成 URL 跳转而无须重新加载页面。

w
- 去除路由中难看的 /#/
- 微信公众号微信支付微信分享和自动登录，处理起来比较坑

h
首先要在项目中使用相对路径，这是开发常识

### vue
vue.config.js
```js
module.exports = {
  publicPath: './'
} 
```

vue router js
```js
import Vue from 'vue';
import VueRouter from 'vue-router';

Vue.use(VueRouter);
const routes = [
  {
    path: '',
    component: require('../components/HelloWorld.vue').default
  },
  {
    path: '/home',
    component: require('../components/Home.vue').default
  }
]

/**
base 基础路径解释：
假如我的打开地址是：xxxxxx.com/m/，配置了模块，或者放置在了子文件夹下面，那么就会出问题。其实，这是因为router无法找到路径中的组件，所以也就无法渲染了。只需要修改router中的index.js，加一个基础路径就可以了。
*/

const router = new VueRouter({
  mode: 'history',
  base: '/m/',
  routes
});

export default router;
```

### 刷新404问题
[官方history文档](https://router.vuejs.org/zh/guide/essentials/history-mode.html#%E5%90%8E%E7%AB%AF%E9%85%8D%E7%BD%AE%E4%BE%8B%E5%AD%90)
问题描述：
当你使用 history 模式时，URL 就像正常的 url，例如 http://yoursite.com/user/id，也好看！
不过这种模式要玩好，还需要后台配置支持。因为我们的应用是个单页客户端应用，如果后台没有正确的配置，当用户在浏览器直接访问 http://oursite.com/user/id 就会返回 404，这就不好看了。

VUE的router[mode: history]模式在开发的时候，一般都不出问题。是因为开发时用的服务器为node，Dev环境中自然已配置好了。

原因：
那是因为在history模式下，只是动态的通过js操作window.history来改变浏览器地址栏里的路径，并没有发起http请求，但是当我直接在浏览器里输入这个地址的时候，就一定要对服务器发起http请求，但是这个目标在服务器上又不存在，所以会返回404

解决方案：后端nginx配置
方案一：官方推荐
default.conf
```
server {
  listen       8074;
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

方案二：匹配errpr_page
```
location /{
　　root   /data/nginx/html;
　　index  index.html index.htm;
　　error_page 404 /index.html;
}
```

### 成功解决
刷新home页面，正常访问资源
`{% asset_img history.png %}`

# 自己的理解
Vue
- 渐进式框架，像洋葱一样
- 数据响应式，dom立即改变

# 其他

## 去除ESLint
第一种
In the vue.config.js :
``` js
module.exports = {
  ...
  lintOnSave: false
  ...
}
```
第二种
卸载webpack.json中所有eslint相关插件

第三种
.eslintrc.js
{
  extends: ["plugin:vue/essential"],
  // extends: [
  //   'plugin:vue/essential',
  //   '@vue/standard'
  // ],
  parserOptions: {
    // parser: 'babel-eslint'
  },
}

# 问题
## Uncaught SyntaxError: Unexpected token <
[stackoverflow](https://stackoverflow.com/questions/51210795/vue-cli-uncaught-syntaxerror-unexpected-token)
Try by adding <base href="/" /> into the <head> of your index.html. Hope it will work.

## Error: Cannot find module '@babel/compat-data/corejs3-shipped-proposals'
https://github.com/JeffreyWay/laravel-mix/issues/2383
yarn add @babel/compat-data@^7.9.0
npm update --depth 5 @babel/compat-data