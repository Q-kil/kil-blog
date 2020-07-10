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

# 运行
``` zsh
npm install -g typescript

tsc hello.ts

node hello.js
```


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

## 类型
### 原始数据类型
JavaScript 的类型分为两种：原始数据类型（Primitive data types）和对象类型（Object types）。
原始数据类型包括：布尔值、数值、字符串、`null`、`undefined` 以及 [ES6 中的新类型 Symbol](https://es6.ruanyifeng.com/#docs/symbol)。
对象类型包括：Object

#### 布尔值
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

#### 字符串
``` ts
let myName: string = 'Tom';
let myAge: number = 25;

// 模板字符串
let sentence: string = `Hello, my name is ${myName}.
I'll be ${myAge + 1} years old next month.`;
```
其中 &#96; 用来定义 ES6 中的模板字符串，`${expr}` 用来在模板字符串中嵌入表达式。

#### 空值
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
```

### 数组的类型
在 TypeScript 中，数组类型有多种定义方式，比较灵活。
#### 「类型 + 方括号」表示法
最简单的方法是使用「类型 + 方括号」来表示数组：
``` ts 
let fibonacci: number[] = [1, 1, 2, 3, 5];
```

#### 数组泛型
我们也可以使用数组泛型（Array Generic） `Array<elemType>` 来表示数组：
``` ts
let fibonacci: Array<number> = [1, 1, 2, 3, 5];
```

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

#### any 在数组中的应用
一个比较常见的做法是，用 any 表示数组中允许出现任意类型：
``` ts
let list: any[] = ['xcatliu', 25, { website: 'http://xcatliu.com' }];
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

## 接口
interface

### 概念
约定、限制

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






