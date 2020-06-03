---
title: vue
date: 2020-04-15 15:14:21
categories:
- Frame
tags:
- Vue
- Vuex
---
# learn
渐进式：主张最少
你可以使用vue核心：声明式渲染，组件系统
你也可以使用下面这个图的全部
`{% asset_img core.png %}`

# 双向绑定
## v-model 指令
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

## .sync 修饰符
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

[第三第四种双向绑定](https://juejin.im/post/5aaa9eabf265da237b21d36a)

# vuex
Vuex 是一个专为 Vue.js 应用程序开发的状态管理模式。它采用集中式存储管理应用的所有组件的状态，并以相应的规则保证状态以一种可预测的方式发生变化。

Vuex 可以帮助我们管理共享状态，并附带了更多的概念和框架。这需要对短期和长期效益进行权衡。
如果您不打算开发大型单页应用，使用 Vuex 可能是繁琐冗余的。确实是如此——如果您的应用够简单，您最好不要使用 Vuex。一个简单的 store （仓库）模式就足够您所需了。但是，如果您需要构建一个中大型单页应用，您很可能会考虑如何更好地在组件外部管理状态，Vuex 将会成为自然而然的选择。
## 第一步
在`main.js`中加入
``` js
import vuex from 'vuex'
Vue.use(vuex);
var store = new vuex.Store({//store对象
    state:{
        show:false
    }
})

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

## modules
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


## mutations
前面我们提到的对话框例子 , 我们对vuex 的依赖仅仅只有一个 $store.state.dialog.show 一个状态 , 但是如果我们要进行一个操作 , 需要依赖很多很多个状态 , 那管理起来又麻烦了 !

`mutations` 登场 , 问题迎刃而解 :

### 使用常量替代 Mutation 事件类型
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

## Action
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

Action 通过 `store.dispatch` 方法触发：
``` js
store.dispatch('increment')
```

## 项目结构示例
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


# 生命周期

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

## 指令简写
v-on: => @
v-bind: => :

## 组件通信
父传子
props: ['todo']








# 自己的理解
Vue
- 渐进式框架，像洋葱一样
- 数据响应式，dom立即改变