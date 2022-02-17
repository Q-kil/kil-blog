---
title: TypeScript
date: 2020-02-27 12:19:48
categories:
- TypeScript
tags:
- TypeScript
---

# 基础
## 概念
- 编译型
- 强类型（直接帮你做类型检测）
- 真正面向对象：有接口、有范型、有枚举、有访问修饰符 

## CLI
### 初始化
生成tsconfig.json 文件
tsc --init
### 工程引用构建模式
可以单独的构建一个工程，相关的依赖也会自动构建
```
tsc -build src/server --verbose

--verbose 打印出详细的信息
```

### 清空构建的文件
```
tsc -b test --clean
```

## 页面使用ts，时刻记住四个点
1. 你自己定义的变量的类型
2. 宿主环境（浏览器、node）环境下的变量类型，比如 window
3. 第三方框架的类型，可能是1和2的组合
4. 范型等类型的推导，熟练使用工具函数 Omit、Pick、Parial

# 运行
``` zsh
npm install -g typescript

tsc hello.ts

node hello.js
```

## 参数
-p FILE OR DIRECTORY, --project FILE OR DIRECTORY  Compile the project given the path to its configuration file, or to a folder with a 'tsconfig.json'.


# learn
[教程](https://ts.xcatliu.com/)
## 简介
TypeScript 只会进行静态检查，如果发现有错误，编译的时候就会报错。
``` zsh
$ tsc hello.ts
hello.ts:6:22 - error TS2345: Argument of type 'number[]' is not assignable to parameter of type 'string'.
可转让的
“number[]”类型的参数不能分配给“string”类型的参数。
```
TypeScript 编译的时候即使报错了，还是会生成编译结果，我们仍然可以使用这个编译之后的文件。

如果要在报错的时候终止 js 文件的生成，可以在 `tsconfig.json` 中配置 noEmitOnError 即可。关于 `tsconfig.json`，请参阅[官方手册](http://www.typescriptlang.org/docs/handbook/tsconfig-json.html)

ts 编译器 tsc
## 类型
ts 类型系统
### 基本类型
``` ts
let courseName: string = 'a';
let age: number = 18;
let isOnline: boolean = true;
let nobody: null = null;
let course: number|string = 'kil';
```

### 引用类型
``` ts
// array
let me: [string, number] = ['kil', 18]

// object 定义类型
interface Person {
  name: string,
  age: number,
  jobs: string[],
  // readonly 不可修改
  readonly cardId: string,
  hourse?: string,
  sex: '男' | '女'
}
// 使用object类型
const kil:Person = {
  name: 'kil',
  age: 18,
  jobs: ['1', '2'],
  cardId: '341281',
  sex: '男'
}


// 函数 定义类型
// 参数和返回值定义类型
function add(num1: number, num2: number): number {
  return num1+num2
}
// 类型定义
type addType = (a: number, b: number)=>number
// 接口定义
interface addType1 {
  (a: number, b: number):number
}
// 使用
let add:addType = function add(num1: number, num2: number): number {
  return num1+num2
} 
```

### 实战演练: 网络请求进阶
规范接口传参

``` ts
import axios from 'axios'

// function request(url: string, obj: any) {
//   return axios.post(url, obj)
// }

// <预先定义一些类型变量，给后面函数用>
function request<T extends keyof API>(url: T, data: API[T]) {
  return axios.post(url, obj)
}

interface API {
  '/course/buy': {
    id: number
  },
  '/course/comment': {
    id: number,
    message: string
  }
}
request('https://httpbin.org/post', {msg: '1'})

```


### 布尔值
注意，使用构造函数 Boolean 创造的对象不是布尔值：
``` ts
let createdByNewBoolean: boolean = new Boolean(1);

// Type 'Boolean' is not assignable to type 'boolean'.
//   'boolean' is a primitive, but 'Boolean' is a wrapper object. Prefer using 'boolean' when possible.
```
事实上 `new Boolean()` 返回的是一个 Boolean 对象：
``` ts
let createdByNewBoolean: Boolean = new Boolean(1);
```

直接调用 Boolean 也可以返回一个 boolean 类型：
``` ts
let createdByBoolean: boolean = Boolean(1);
```
在 TypeScript 中，`boolean` 是 JavaScript 中的基本类型，而 `Boolean` 是 JavaScript 中的构造函数。其他基本类型（除了 `null` 和 `undefined`）一样，不再赘述。


### 空值
JavaScript 没有空值（Void）的概念，在 TypeScript 中，可以用 `void` 表示没有任何返回值的函数：
``` ts
function alertName(): void {
    alert('My name is Tom');
}
```
声明一个 `void` 类型的变量没有什么用，因为你只能将它赋值为 `undefined` 和 `null`：
``` ts
let unusable: void = undefined;
```

### 类型推理/类型推测（隐式类型声明）
如果没有明确的指定类型，那么 TypeScript 会依照类型推论（Type Inference）的规则推断出一个类型。
``` ts
let myFavoriteNumber = 'seven'; // 等价于 let myFavoriteNumber: string = 'seven';
myFavoriteNumber = 7;

// index.ts(2,1): error TS2322: Type 'number' is not assignable to type 'string'.
```
如果定义的时候没有赋值，不管之后有没有赋值，都会被推断成 any 类型而完全不被类型检查：
``` ts
let myFavoriteNumber;
myFavoriteNumber = 'seven';
myFavoriteNumber = 7;
```

### 联合类型
联合类型（Union Types）表示取值可以为多种类型中的一种。
``` ts
let myFavoriteNumber: string | number;
myFavoriteNumber = 'seven';
myFavoriteNumber = 7;
```

### 对象的类型--接口
在 TypeScript 中，我们使用接口（Interfaces）来定义对象的类型。

在面向对象语言中，接口（Interfaces）是一个很重要的概念，它是对行为的抽象，而具体如何行动需要由类（classes）去实现（implement）。
TypeScript 中的接口是一个非常灵活的概念，除了可用于对类的一部分行为进行抽象以外，也常用于对「对象的形状（Shape）」进行描述。

纯数据可以用interface，如果是面向对象的数据，比如有自己的成员方法，可以定义为类。

``` ts
interface Person {
    name: string;
    age: number;
}

let tom: Person = {

    name: 'Tom',
    age: 25
};
```
上面的例子中，我们定义了一个接口 `Person`，接着定义了一个变量 `tom`，它的类型是 `Person`。这样，我们就约束了 `tom` 的形状必须和接口 `Person` 一致。
接口一般首字母大写。[有的编程语言中会建议接口的名称加上 I 前缀](https://docs.microsoft.com/en-us/previous-versions/dotnet/netframework-1.1/8bc1fexb(v=vs.71)?redirectedfrom=MSDN)。

Q：typescript中，类作为类型是怎么回事呢，一般下不是使用接口来定义对象的类型嘛
A：类作为类型挺常见的，let a:Box意味着a变量只能存储Box（及其子类）的实例，interface反而比class类型出现的更晚一些


#### 可选属性
有时我们希望不要完全匹配一个形状，那么可以用可选属性：
``` ts
interface Person {
    name: string;
    age?: number;
}

let tom: Person = {
    name: 'Tom'
};
```

#### 任意属性
有时候我们希望一个接口允许有任意的属性，可以使用如下方式：
``` ts
interface Person {
    name: string;
    age?: number;
    [propName: string]: any;
}

let tom: Person = {
    name: 'Tom',
    gender: 'male'
};
```
使用 [propName: string] 定义了任意属性取 string 类型的值。
需要注意的是，一旦定义了任意属性，那么确定属性和可选属性的类型都必须是它的类型的子集：
``` ts
interface Person {
    name: string;
    age?: number;
    [propName: string]: string;
}

let tom: Person = {
    name: 'Tom',
    age: 25,
    gender: 'male'
};

// index.ts(3,5): error TS2411: Property 'age' of type 'number' is not assignable to string index type 'string'.
// index.ts(7,5): error TS2322: Type '{ [x: string]: string | number; name: string; age: number; gender: string; }' is not assignable to type 'Person'.
//   Index signatures are incompatible.
//     Type 'string | number' is not assignable to type 'string'.
//       Type 'number' is not assignable to type 'string'.
```

#### 只读属性
有时候我们希望对象中的一些字段只能在创建的时候被赋值，那么可以用 `readonly` 定义只读属性：
``` ts
interface Person {
    readonly id: number;
    name: string;
    age?: number;
    [propName: string]: any;
}

let tom: Person = {
    id: 89757,
    name: 'Tom',
    gender: 'male'
};

tom.id = 9527;

// 上例中，使用 readonly 定义的属性 id 初始化后，又被赋值了，所以报错了。
// index.ts(14,5): error TS2540: Cannot assign to 'id' because it is a constant or a read-only property.

// game-editor
readonly userKey = "currentUser";
```


#### Partial
``` ts
export class Game {
  /**
   * 游戏ID
   */
  _id: string;

  name: string = "空白世界";

  description: string = "什么都没有的世界，需要玩家自己创造";

  owner: Partial<User>;
```
{% label ib_yellow@2020.11.4 %}

Partial 作用是将传入的属性变为可选项.
首先我们需要理解两个关键字 keyof 和 in, keyof 可以用来取得一个对象接口的所有 key 值.
比如
``` ts
interface Foo {
  name: string;
  age: number
}
type T = keyof Foo // -> "name" | "age"
```

而 in 则可以遍历枚举类型, 例如
``` ts
type Keys = "a" | "b"
type Obj =  {
  [p in Keys]: any
} // -> { a: any, b: any }
```
keyof 产生枚举类型, in 使用枚举类型遍历, 所以他们经常一起使用, 看下 Partial 源码
``` ts
type Partial<T> = { [P in keyof T]?: T[P] };
```

上面语句的意思是 keyof T 拿到 T 所有属性名, 然后 in 进行遍历, 将值赋给 P, 最后 T[P] 取得相应属性的值.
结合中间的 ? 我们就明白了 Partial 的含义了.

### 数组的类型
在 TypeScript 中，数组类型有多种定义方式，比较灵活。
#### 「类型 + 方括号」表示法
最简单的方法是使用「类型 + 方括号」来表示数组：
``` ts 
let fibonacci: number[] = [1, 1, 2, 3, 5];
```

#### 数组泛型
Array关键字，Array范型接口
我们也可以使用数组泛型（Array Generic） `Array<elemType>` 来表示数组：
``` ts
let fibonacci: Array<number> = [1, 1, 2, 3, 5];
```
Array 是ts预定义的范型接口 

#### 用接口表示数组
接口也可以用来描述数组：
``` ts
interface NumberArray {
    [index: number]: number;
}
let fibonacci: NumberArray = [1, 1, 2, 3, 5];
```

#### 类数组
类数组（Array-like Object）不是数组类型，比如 arguments：
``` ts
function sum() {
    let args: number[] = arguments;
}

// Type 'IArguments' is missing the following properties from type 'number[]': pop, push, concat, join, and 24 more.
```
上例中，arguments 实际上是一个类数组，不能用普通的数组的方式来描述，而应该用接口：
``` ts
function sum() {
    let args: {
        [index: number]: number;
        length: number;
        callee: Function;
    } = arguments;
}
```

#### 数组的联合类型
语法：两种类型之间加一个 竖线
``` ts
let arr2: Array<number | string> = [1, 2, 3, '4']
```

#### any 在数组中的应用
一个比较常见的做法是，用 any 表示数组中允许出现任意类型：
``` ts
let list: any[] = ['xcatliu', 25, { website: 'http://xcatliu.com' }];
```

### 元组类型
限定数组长度和类型
``` ts
let tuple: [number, string] = [1, '2']
```

### 函数的类型
[函数是 JavaScript 中的一等公民](https://llh911001.gitbooks.io/mostly-adequate-guide-chinese/content/ch2.html)

#### 函数声明
在 JavaScript 中，有两种常见的定义函数的方式——函数声明（Function Declaration）和函数表达式（Function Expression）：
``` ts
// 函数声明（Function Declaration）
function sum(x, y) {
    return x + y;
}

// 函数表达式（Function Expression）
let mySum = function (x, y) {
    return x + y;
};
```
一个函数有输入和输出，要在 TypeScript 中对其进行约束，需要把输入和输出都考虑到，其中函数声明的类型定义较简单：
``` ts
function sum(x: number, y: number): number {
    return x + y;
}
```
函数返回类型可以省略，因为ts有类型推断功能

#### 函数表达式
如果要我们现在写一个对函数表达式（Function Expression）的定义，可能会写成这样：
``` ts
let mySum = function (x: number, y: number): number {
    return x + y;
};
```
这是可以通过编译的，不过事实上，上面的代码只对等号右侧的匿名函数进行了类型定义，而等号左边的 mySum，是通过赋值操作进行类型推论而推断出来的。如果需要我们手动给 mySum 添加类型，则应该是这样：
``` ts
let mySum: (x: number, y: number) => number = function (x: number, y: number): number {
    return x + y;
};
```
注意不要混淆了 TypeScript 中的 => 和 ES6 中的 =>。
在 TypeScript 的类型定义中，=> 用来表示函数的定义，左边是输入类型，需要用括号括起来，右边是输出类型。
在 ES6 中，=> 叫做箭头函数，应用十分广泛，可以参考 [ES6 中的箭头函数](http://es6.ruanyifeng.com/#docs/function#%E7%AE%AD%E5%A4%B4%E5%87%BD%E6%95%B0)。

#### 用接口定义函数的形状
``` ts
interface SearchFunc {
    (source: string, subString: string): boolean;
}

let mySearch: SearchFunc;
mySearch = function(source: string, subString: string) {
    return source.search(subString) !== -1;
}
```

#### 参数默认值
在 ES6 中，我们允许给函数的参数添加默认值，TypeScript 会将添加了默认值的参数识别为可选参数：
``` ts
function buildName(firstName: string, lastName: string = 'Cat') {
    return firstName + ' ' + lastName;
}
let tomcat = buildName('Tom', 'Cat');
let tom = buildName('Tom');
```
此时就不受「可选参数必须接在必需参数后面」的限制了：
``` ts
function buildName(firstName: string = 'Tom', lastName: string) {
    return firstName + ' ' + lastName;
}
let tomcat = buildName('Tom', 'Cat');
let cat = buildName(undefined, 'Cat');
```

#### 剩余参数
``` ts
function push(array, ...items) {
    items.forEach(function(item) {
        array.push(item);
    });
}

let a = [];
push(a, 1, 2, 3);
```

#### 重载
重载允许一个函数接受不同数量或类型的参数时，作出不同的处理。
比如，我们需要实现一个函数 reverse，输入数字 123 的时候，输出反转的数字 321，输入字符串 'hello' 的时候，输出反转的字符串 'olleh'。
利用联合类型，我们可以这么实现：
``` ts
function reverse(x: number | string): number | string {
    if (typeof x === 'number') {
        return Number(x.toString().split('').reverse().join(''));
    } else if (typeof x === 'string') {
        return x.split('').reverse().join('');
    }
}
```

然而这样有一个缺点，就是不能够精确的表达，输入为数字的时候，输出也应该为数字，输入为字符串的时候，输出也应该为字符串。
这时，我们可以使用重载定义多个 reverse 的函数类型：
``` ts
function reverse(x: number): number;
function reverse(x: string): string;
function reverse(x: number | string): number | string {
    if (typeof x === 'number') {
        return Number(x.toString().split('').reverse().join(''));
    } else if (typeof x === 'string') {
        return x.split('').reverse().join('');
    }
}
```

上例中，我们重复定义了多次函数 reverse，前几次都是函数定义，最后一次是函数实现。在编辑器的代码提示中，可以正确的看到前两个提示。
注意，TypeScript 会优先从最前面的函数定义开始匹配，所以多个函数定义如果有包含关系，需要优先把精确的定义写在前面。

#### 函数签名
success: (a, b) => void

### 类型断言
#### 语法
``` ts
<类型>值
// 或
值 as 类型
```

#### 编辑器例子
``` ts
destory() {
  this._cap = {} as Capsule;
}
```

#### 例子：将一个联合类型的变量指定为一个更加具体的类型
有时候，我们确实需要在还不确定类型的时候就访问其中一个类型的属性或方法，比如
``` ts
function getLength(something: string | number): number {
    if (something.length) {
        return something.length;
    } else {
        return something.toString().length;
    }
}

// index.ts(2,19): error TS2339: Property 'length' does not exist on type 'string | number'.
//   Property 'length' does not exist on type 'number'.
// index.ts(3,26): error TS2339: Property 'length' does not exist on type 'string | number'.
//   Property 'length' does not exist on type 'number'.
```

上例中，获取 something.length 的时候会报错。
此时可以使用类型断言，将 something 断言成 string：

``` ts
function getLength(something: string | number): number {
    if ((<string>something).length) {
        return (<string>something).length;
    } else {
        return something.toString().length;
    }
}
```

类型断言不是类型转换，断言成一个联合类型中不存在的类型是不允许的.


### 外部变量声明
declare var 名字

声明文件
global.d.ts

## 接口
interface

### 概念
约定、限制

{% label ib_blue@2020/7/21 添加 %}
如果实现 `implements` 了接口interface，则 在类中必须有接口的所有成员（属性），否则ts报错
Angular例子：
``` ts
export class GameComponent implements OnInit, OnDestroy {
  ngOnInit() {
  }

  ngOnDestroy() {
  }
}  
```

### 例子
``` ts
interface Point {
  x: number,
  y: number,
  z?: number
}

let p: Point;
p = {x:12, y:5}
```

## 面向对象
### 访问修饰符
public     公有          任何人可以访问
private    私有          只有类内部可以访问
protected  受保护的-友元   只有子类能用

## 泛型
别根‘any’搞混了
泛：宽泛

## 例子
``` ts
class Calc<T> {
  a: T;
  b: T;
}

let obj = new Calc<number>();
obj.a = 12;
```

# 封装
## Class
``` ts
export class EditGameParameters {
  id: string; // sn
  name: string;
  version: string;
  username: string;

  constructor(init?: Partial<EditGameParameters>) {
    Object.assign(this, init);
  }
}
```

购物车功能
**Model**：购物车内商品item（商品，数量），购物车（商品item集合）
**View**：购物车模板
**Controller**: 购物车组件

### Model
#### cartItem.model.ts
``` ts
import { ICommodity } from '../mall/mall.model';
import { User } from "../user/user.model";

export class CartItem {
  private quantity: number;

  constructor(
    private _id: string,
    private checked: boolean,
    private commodity: ICommodity,
    private owner: User
  ) {
    this.quantity = 1;
  }

  get __id(): string { return this._id; }
  get _checked(): boolean { return this.checked; }
  get _commodity(): ICommodity { return this.commodity; }
  get _owner(): User { return this.owner; }

  // 数量的增减
  decreaseQuantity(): number {
    // service update
    this.cartService.update({
        commodity: this.commdity._id,
        checked: this.checked,
        quantity: --this.quantity
    }).subscribe(() => {
        return this.quantity; 
    })
  }
  increaseQuantity(): number { return this.quantity++; }

  // item 总价格
  get commodityTotal(): number { return this.quantity * this.commodity.price; }
}
```

#### cart.model.ts
``` ts
import { CartItem } from "./cartItem.model";

export class Cart {
  private content: Array<CartItem>;

  constructor() {
    this.content = new Array<CartItem>(); 
  }

  // 购物车中所有的商品
  getContent(): Array<CartItem> {
    return this.content;
  }

  // 选中的商品总价格
  get selectedTotal(): number {
    let total = 0;
    this.content.forEach((item) => {
      if (item._checked) {
        total += item.commodityTotal;
      }
    });
    return total;
  }

  addItem(item:CartItem) {
        let cartItem = new CartItem(item._id, item.checked, item.commodity, item.owner);
        let found:boolean = false;
        
        this._content.forEach(function(item) {
            // 判断购物车中是否有该商品，有商品就数量加一
            if (item._id == cartItem._id) {
                item.increaseAmount();
                found = true;
            }
        });
        
        // 没有找到商品，添加
        if(!found) {
            this.cartService.add(cartItem).subscribe(
                () => {
                    // 添加成功后？ push or get
                    this._content.push(cartItem);

                    this.getitems();
                }
            ) 
        }
    }

    getItems(): void {
      this.cartService.get().subscribe(
          data => {
            this.content = res;
          }
      );
    }

  toggleChecked(parame) {
    this.httpCommonService.postCommon("cart/toggle_checked_all", parame).subscribe(
      res => {
        console.log("toggle", res);
        this.getCartItems();
      }
    );
  }

  removeItem(parame) {
    this.httpCommonService.postCommon("cart/delete", { commodityIds: parame }).subscribe(
      res => {
        console.log("delete", res);
        this.alertService.alertSuccess("删除成功");
        this.getCartItems();
      }
    );
  }
}
```


#### cart.component.ts
``` ts
export class CartComponent implements OnInit {

  constructor(
    public cartService: CartService,
    private router: Router,
    private alertService: AlertService,
    private personalService: PersonalService,
    private cartsSubjectService: CartSubjectService,
    private cartSubjectService: CartSubjectService,
  ) {
    this.cartSubjectService.cartsInit(true);
  }

  ngOnInit() {
    this.cartSubjectService.carts.subscribe(
      (carts: any[]) => {
        this.commodityIds = carts.map(doc => doc.commodity._id);
        this.checkedIds = _.filter(carts, {'checked': true});
        this.carts = _.groupBy(carts, "commodity.owner.nickname");
        this.itemChecked();
      }
    );
  }
}
```

## namespace 命名空间
如果你发现自己写的功能(函数/类/接口等...)越来越多, 你想对他们进行分组管理就可以用命名空间


## 存取器
set、get
``` ts
public get currentUser(): User {
  return localStore.get(this.userKey);
}
```

# TS 开发实战
深入理解 TypeScript 核心概念；
熟练进行 TypeScript 工程配置；
玩转四种典型前端应用的开发；
重塑“类型思维”，提升编程素养。

## Atwood 定律
任何能用 JavaScript 实现的应用，最终都会用 JavaScript 实现

无处不在：
移动终端（手机、笔记本、平板电脑） ——> 后端服务
IoT（物联网 Internet of things） ——> 神经网络（人工智能的底层模型是"神经网络"（neural network））

语言的应用之广应该具有的特点：
安全性、健壮性和可维护性有更高的要求。

## 为什么会有 ts
JavaScript 是门动态类型语言
一：搞清楚参数类型，你只能硬着头皮去看里面的逻辑
二：为了保证代码的健壮性，对一个函数的输入参数进行各种假设
三：优化了一个参数类型，但不知道有多少处引用，在提交代码前
四：联调就报错了：“TypeError: Cannot read property ‘length’ of undefined“ 给对接人说这是数组

### 解决动态类型语言的其他库
2014   Fackbook   Flow
2014   Microsoft  TypeScript

都为JavaScript提供静态类型检查

## what is ts
拥有类型系统的JavaScript的超集，可以编译纯JavaScript

- 类型检查
- 语言扩展
  接口，抽象类
- 工具属性

束缚js这匹野马的缰绳，即可闲庭信步，亦可策马扬鞭；前端开发之路走得更稳，走得更远
## 课程介绍
基础篇
工程篇（理论和实践之间，存在不小的鸿沟）
实战篇（四个案例）

目标：类型思维；思维方式决定编程习惯，编程习惯奠定工程质量，工程质量划定了能力边界。不仅讲知识点和应用，更是训练思维。

## 基础篇
### 强类型与弱类型
强类型语言：不允许改变变量的数据类型，除非进行强制类型转换
弱类型语言：变量可以被赋予不同的数据类型

### 动态类型与静态类型
静态类型语言：在编译阶段确定所有变量的类型
动态类型语言：在执行阶段确定所有变量的类型


### 基本类型
#### 类型注解
语法 ：(变量/函数): type
作用 ：相当于强类型语言中的类型声明
好处 ：

静态编译时检查类型。类型操作不合理时，编译器会警告，如： Type 'string' is not assignable to type 'boolean'。
作为文档。在 VSCode 中将光标移到 bar 上时，会提示 let bar: boolean。

#### 对象
let obj: object = {x: 1, y: 2}
正确的定义：
let obj: {x: number, y: number} = {x: 1, y: 2}
obj.x = 3

#### undefined
let un: undefined = undefined (只能赋值他本身)

#### void
let onReture = () => {}

#### any
不是特殊情况不建议使用any，要不然就不要使用ts了

#### never
let error = () => {
  throw new Error('error')
}

### 枚举类型
{% asset_img role.png %}
{% asset_img phone.png %}
``` ts
enum Role {
  Reporter,
  Developer
}
```

### 接口
#### 对象接口类型
数据请求
``` ts
interface List {
  // 只读属性
  readonly id: number;
  name: string;
  // 判断有没有某个属性
  age?: number
}

interface Result {
  data: List[]
}

function render(result: Result) {
  result.data.forEach((value) => {
    console.log(value.id, value.name)
    if(value.age) {
      console.log(value.age)
    }
  })
}

let result = {
  data: [
    {id: 1, name: 'A', sex: 'male'},
    {id: 2, name: 'B'}
  ]
}
render(result)
```

### 函数类型接口
混合类型接口
``` ts
interface Lib {
  (): void;
  version: string;
  doSomething(): void;
}

实现
let lib: Lib = (() => {}) as Lib; // 类型断言，明确知道lib类型是Lib
lib.version = '1.0';
lib.doSomething = () => {};
```
上例缺点是 向全局暴露了一个变量lib，它是一个单例；如果想创建多个lib，需要用函数封装一下

``` ts
function getLib() {
  let lib: Lib = (() => {}) as Lib;
  lib.version = '1.0';
  lib.doSomething = () => {};
  return lib;
}
// 创建多个实例
let lib1 = getLib();
lib1();
lib1.doSomething();
let lib2 = getLib();
```

### 函数
- 定义
- 传参
- 可选参数
- 默认参数
- 剩余参数
- 函数重载（函数名相同）

函数定义
``` ts
// 1.function
function add1(x: number, y: number) {
  return x + y; // 函数返回值，ts类型推断省去
}

let add2: (x: number, y: number) => number; // 通过变量，定义函数类型

type add3 = (x: number, y: number) => number; // 类型别名，定义函数类型

interface add4 { // 接口定义函数类型
  (x: number, y: number): number
}
// 2-4 都是函数类型的定义，没有实现

// 调用：行参和实参一一对应
add1(1, 2);

function add6(x: number, y = 0, z: number, q = 1) {
  return x + y + z + q;
}
add6(1, undefined, 3);

function add7(x: number, ...rest: number[]) {
  return x + rest.reduce((pre, cur) => pre + cur)
}
console.log(add7(1, 2, 3, 4, 5));
```

### 类
#### 类基本实现
``` ts
class Dog {
  constructor(name: string) {
    this.name = name
  }
  name: string = 'dog'
  run() {}
}
console.log(Dog.prototype)
let dog = new Dog('wangwang')
console.log(dog)
```

#### 类的继承
``` ts
class Husky extends Dog {
  constructor(name: string, color: string) {
    super(name)
    this.color = color
  }
  color: string
}
```

#### 成员修饰符
public
private
protected 受保护的，不能实例调用，子类可以继承
readonly 只读
static 静态的，能通过类访问，不能通过实例访问，子类继承可以访问

#### 抽象类
``` ts
abstract class Animal {
  eat() {
    console.log('eat')
  }
}
```

#### 多态
``` ts
let animals: Animal[] = [dog, cat]
animals.forEach(i => {
  i.sleep()
})
```

#### 特殊的类型，this类型，链式调用
``` ts
class WorkFlow {
  step1() {
    return this;
  }
  step2() {
    return this;
  }
}
new WorkFlow().step1().step2()
```

##### this类型 多态
``` ts
class Myflow extends WorkFlow {
  next() {
    return this;
  }
}
new Myflow().next().step1().next().step2()
```

#### 类的静态方法
使用static修饰符修饰的是静态方法
静态方法不需要实例化，直接就可以通过类调用
```ts
class Person{
  static eat(){
    console.log('eat...')
  }
}
Person.eat();
```



### 接口
``` ts
interface {

}
```
{% asset_img interface.png %}

### 范型
好处：
- 函数和类可以轻松的支持多种类型，增强程序的扩展性
- 不必写多条函数重载，冗长的联合类型声明，增强代码可读性
- 灵活控制类型之间的约束
``` ts
// any类型，调用者无法获知 约束关系
function log(value: any) {
  return value;
}
```

定义：不预先确定的数据类型，具体的类型在使用的时候才能确定

范型函数
``` ts
function log<T>(value: T):T {
  return value;
}
```
调用
``` ts
log<string[]>(['a', 'b']) //指名类型
log(['a', 'b'])// 类型推断，推荐使用
```

类型别名 定义范型函数及实现
``` ts
type Log = <T>(value: T) => T
let myLog: Log = log
```

接口 定义范型
``` ts
interface Log<T> {
  (value: T): T
}
let myLog: Log<number> = log
myLog(1)
```

#### 范型类
``` ts
class Log<T> {
  run(value: T) {
    return value
  }
}
let log1 = new Log<number>()
log1.run(1)
let log2 = new Log() // 不指定类型，就可以传入任意类型
log2.run('1')
```

#### 范型约束
``` ts
function log<T>(value: T): T {
  console.log(value, value.length) // length 报错：范型T没有这个属性
  return value
}

//通过类型检查
interface Length {
  length: number
}
function log<T extends Length>(value: T): T {
  console.log(value, value.length)
  return value
}
```

### 类型检查机制
#### 类型断言
```ts
interface Foo {
  bar: number
}
let foo = {} as Foo
foo.bar = 1
```

### 高级类型
#### 交叉类型与联合类型
``` ts
interface DogInterface {
  run(): void
}
interface CatInterface {
  jump(): void
}

// 交叉类型：使用 & and符连接
let pet: DogInterface & CatInterface = {
  run() {},
  jump() {}
}

// 联合类型：｜
let a: number | string = 'a'

// 限制变量取值在一定范围内
let a: 'a' | 'b' | 'c'

// 索引类型
let obj = {
  a: 1,
  b: 2,
  c: 3
}
function getValues<T, K extends keyof T>(obj: T, keys: K[]): T[k][] {
  return keys.map(key => obj[key])
}

// 索引类型查询操作符
// keyof T
interface Obj {
  a: number,
  b: string
}
let key: keyof Obj
// key 的类型就变成，'a', 'b' 字面量的联合类型

// 索引访问操作符 T[k]
let value: Obj['a']
// value的类型 就是number类型

// 范型约束
// T extends U ,范型变量T 可以继承某些属性或变量

// 映射类型
interface Obj {
  a: string
  b: number
}

type ReadonlyObj = Readonly<Obj>

// 条件类型
// T extends U ? X : Y
type TypeName<T> =
  T extends string ? "string" :
  T extends number ? "number" :
  T extends boolean ? "boolean" :
  T extends undefined ? "undefined" :
  T extends Function ? "function" :
  "object"

type T1 = TypeName<string>
type T2 = TypeName<string[]>
```

## 工程篇
### 模块系统
前端应用越来越复杂，多人协作是一种常态，模块化被广泛接受。
经过时间的沉淀现在用
- ES6
- CommonJS
#### ES6模块系统
##### es6 模块导出
通过export实现
``` ts
// 单独导出
export let a = 1

// 批量导出
let b = 2
let c = 3
export { b, c }

// 导出接口
export interface P {
  x: number
}

// 导出函数
export function f() {}

// 导出时起别名
function g() {}
export {g as G}

// 默认导出，无需函数名
// es6 允许一个顶级导出，多个次级导出
export default function() {
  console.log("I'am default")
}
// ts编译后, 程序无感知
// .js
function default_1() {
  console.log("I'am default")
}
exports["default"] = default_1;
a_2["default"]();


// 引入外部模块，重新导出
export { str as hello } from './b'

// 顶级导出; 
// export let a = 1; 使用顶级导出就不能导出其他了
export = function() {

}
```
##### es6 导入
``` ts
import { a, b, c } from './a'; // 批量导入
import { P } from './a';       // 导入接口
import { f as F } from './a';  // 导入时起别名
import * as All from './a';    // 导入模块中的所有成员，绑定在 All 上
import myFunction from './a';  // 不加{}, 导入默认
```

#### CommonJS模块系统
nodejs是commonjs的一种实现
##### commonjs模块导出
``` ts
let a = {
  x: 1
}

// 整体导出
// 只允许一个顶级导出，会覆盖次级导出
module.exports = a

// 导出多个变量
// 次级导出
exports.c = 3
exports.d = 4
// exports == module.exports;  exports是module.exports的引用
```

##### commonjs模块导入
``` ts
let c1 = require('./a.node')
let c2 = require('./b.node')
```

#### 生成环境中两个模块系统会被构建成什么样子
tsconfig.json
``` json
{
  "compilerOptions": {
    "target": "es5", //ts默认生成的tsconfig.json 用 es5；tsc指令 用 es3；ES2015是 ES6
    // 要编译成的目标语言是什么版本

    "module": "commonjs", // tsconfig.json和tsc都是commonjs
    // 要把我们的代码编译成什么样的模块系统

    "esModuleInterop": true,
    // export =  的，两种导入方式
    // false的话，只能这样导入：import c4 = require('../es6/d')

    "outDir": "./dist",

    "composite": true, // 工程可以被引用, 并且可以增量编译

    "declaration": true, // 声明文件
  },
  "include": ["src"], // 输出的目录不包含 src
  "references": [ // 依赖的工程
    { "path": "../common" }
  ]
}
```

#### 注意
如果使用了ES6的导出，CommonJS的导入就会出现问题
``` ts
// commonjs调用es6的默认导出
let c3 = require('../es6/a');
c3() // 报错 not function
c3.default() // 正常
```
#### 如何出来两个模块不兼容问题
方案：
1、两个模块系统不要混用
2、如果es6有一个顶级导出，可能会被nodejs模块引用的话，ts提供了一个兼容的语法：export
``` ts
// 会被编译为：module.exports; 意味着不能有其他的导出了
export = function() {
  console.log("I'am default")
}

// 两种导入方式
import c4 = require('../es6/d')
import c4 from '../es6/d'
c4()
```

#### 模块和命名空间不要混用，namespace

### 声明合并
接口之间函数是可以重复定义的，命名空间不行

### 编写声明文件
类库分为三类
- 全局类库
- 模块类库
- UMD类库

jquery是UMD类库，既可以全局也可以模块化引用
在使用非ts编写的类库时，必须为这个类库编写声明文件，对外暴露API
社区会编写大部分类库的声明文件，安装：yarn add @types/jquery
[查询声明类库](https://www.typescriptlang.org/dt/search?search=)

### 配置tsconfig.json
#### 文件
- files
- include
- exclude


#### 工程引用
在全栈项目中，单独构建客户端的应用 或者 server端的应用。这些问题无法通过单个 配置文件 实现。

参考 [ts项目](https://github.com/microsoft/TypeScript/tree/main/src)
##### 优点
- 解决了输出目录结构的问题
- 解决了单个工程构建的问题
- 通过增量编译，提升了构建速度


# 区别
## interface和type
### 相同点
1.都可以描述一个对象或者函数
``` ts
interface User {
  name: string
  age: number
}

interface SetUser {
  (name: string, age: number): void;
}

type User = {
  name: string
  age: number
};

type SetUser = (name: string, age: number)=> void;
```

2.都允许拓展（extends）
interface 和 type 都可以拓展，并且两者并不是相互独立的，也就是说 interface 可以 extends type, type 也可以 extends interface 。 虽然效果差不多，但是两者语法不同。
``` ts
// interface extends interface
interface Name { 
  name: string; 
}
interface User extends Name { 
  age: number; 
}

// type extends type
type Name = { 
  name: string; 
}
type User = Name & { age: number  };

// interface extends type
type Name = { 
  name: string; 
}
interface User extends Name { 
  age: number; 
}

// type extends interface
interface Name { 
  name: string; 
}
type User = Name & { 
  age: number; 
}
```

### 不同点
type 可以而 interface 不行
1.type 可以声明基本类型别名，联合类型，元组等类型
``` ts
// 基本类型别名
type Name = string

// 联合类型
interface Dog {
    wong();
}
interface Cat {
    miao();
}

type Pet = Dog | Cat

// 具体定义数组每个位置的类型
type PetList = [Dog, Pet]
```
2.type 语句中还可以使用 typeof 获取实例的 类型进行赋值
``` ts
// 当你想获取一个变量的类型时，使用 typeof
let div = document.createElement('div');
type B = typeof div
```
3.其他骚操作
``` ts
type StringOrNumber = string | number;  
type Text = string | { text: string };  
type NameLookup = Dictionary<string, Person>;  
type Callback<T> = (data: T) => void;  
type Pair<T> = [T, T];  
type Coordinates = Pair<number>;  
type Tree<T> = T | { left: Tree<T>, right: Tree<T> };
```

interface 可以而 type 不行
interface 能够声明合并
``` ts
interface User {
  name: string
  age: number
}

interface User {
  sex: string
}

/*
User 接口为 {
  name: string
  age: number
  sex: string 
}
*/
```

总结：一般来说，如果不清楚什么时候用interface/type，能用 interface 实现，就用 interface , 如果不能就用 type 。

# 问题
## path can't resolve

ERROR in ./src/app/pages/home/home.component.ts
Module not found: Error: Can't resolve '@service/api/user.service' in '/Users/niekaifa/workspace/apowo/platform-client/src/app/pages/home'
 @ ./src/app/pages/home/home.component.ts 17:23-59
 @ ./src/app/pages/home/home.module.ts
 @ ./src/app/app.routes.ts
 @ ./src/app/app.module.ts
 @ ./src/main.ts

背景：改了webpack，以前可以使用，现在出错
原因：
tsconfig path 代码显示不出错
webpack 才是真的按路径引入，所以问题出在 webapck
解决
    new AngularCompilerPlugin({
      mainPath: path.resolve("./src/main.ts"),
      sourceMap: true,
      nameLazyFiles: true,
      tsConfigPath: path.resolve("./src/tsconfig.app.json"),
      skipCodeGeneration: true,
    }),

## import * 与 import
为什么有的系统语言使用import * as React from 'react';有的系统语言使用import React from 'react';
作者回复: 第一种写法是将所有用export导出的成员绑定在React上，导入后用React.xxx访问；第二种仅是导出默认的（export default）