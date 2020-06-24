---
title: function
date: 2020-06-18 14:38:57
categories:
- JavaScript
tags:
- Function
---

# 构造函数
‘面向对象编程’的第一步，就是要生成对象。而js中面向对象编程是基于构造函数（constructor）和原型链（prototype）的。

前面说过，“对象”是单个实物的抽象。通常需要一个模板，表示某一类实物的共同特征，然后“对象”根据这个模板生成。

js语言中使用构造函数（constructor）作为对象的模板。所谓构造函数，就是提供一个生成对象的模板，并描述对象的基本结构的函数。一个构造函数，可以生成多个对象，每个对象都有相同的结构。

``` js
function Keith() {
  this.height = 180;
}
```

上面代码中，Keith就是构造函数，它提供模板，用来生成对象实例。为了与普通函数区别，构造函数名字的第一个字母通常大写。

构造函数的三大特点：
- 构造函数的函数名的第一个字母通常大写。
- 函数体内使用this关键字，代表所要生成的对象实例。
- 生成对象的时候，必须使用new命令来调用构造函数。

## new 命令
### 基本原理
new命令的作用，就是执行一个构造函数，并且返回一个对象实例。使用new命令时，它后面的函数调用就不是正常的调用，而是依次执行下面的步骤。
- 创建一个空对象，作为将要返回的对象实例。
- 将空对象的原型指向了构造函数的prototype属性。
- 将空对象赋值给构造函数内部的this关键字。
- 开始执行构造函数内部的代码。

也就是说，构造函数内部，this指向的是一个新生成的空对象，所有针对this的操作，都会发生在这个空对象上。构造函数之所谓构造函数，意思是这个函数的目的就是操作一个空对象（即this对象），将其构造为需要的样子

### 基本用法
new命令的作用，就是调用一个构造函数，并且返回一个对象实例。

``` js
function Keith() {
  this.height = 180;
}

var boy = new Keith();
console.log(boy.height);　　//180
```

上面代码中通过new命令，让构造函数Keith生成一个对象实例，并赋值给全局变量boy。这个新生成的对象实例，从构造函数Keith中继承了height属性。也就说明了这个对象实例是没有height属性的。在new命令执行时，就代表了新生成的对象实例boy。this.height表示对象实例有一个height属性，它的值是180。

使用new命令时，根据需要，构造函数也可以接受参数。

``` js
function Person(name, height) {
    this.name = name;
    this.height = height;
}

var boy = new Person('Keith', 180);
console.log(boy.name); //'Keith'
console.log(boy.height); //180

var girl = new Person('Samsara', 160);
console.log(girl.name); //'Samsara'
console.log(girl.height); //160
```

上面代码中，首先，我们创建了一个构造函数Person，传入了两个参数name和height。构造函数Person内部使用了this关键字来指向将要生成的对象实例。

然后，我们使用new命令来创建了两个对象实例boy和girl。

当我们使用new来调用构造函数时，new命令会创建一个空对象boy，作为将要返回的实例对象。接着，这个空对象的原型会指向构造函数Person的prototype属性。也就是boy.prototype===Person.prototype的。要注意的是空对象指向构造函数Person的prototype属性，而不是指向构造函数本身。然后，我们将这个空对象赋值给构造函数内部的this关键字。也就是说，让构造函数内部的this关键字指向一个对象实例。最后，开始执行构造函数内部代码。

因为对象实例boy和girl是没有name和height属性的，所以对象实例中的两个属性都是继承自构造函数Person中的。这也就说明了构造函数是生成对象的函数，是给对象提供模板的函数。

一个问题，如果我们忘记使用new命令来调用构造函数，直接调用构造函数了，会发生什么？

这种情况下，构造函数就变成了普通函数，并不会生成实例对象。而且由于后面会说到的原因，this这时代表全局对象，将造成一些意想不到的结果。

``` js
function Keith() {
    this.height = 180;
}

var person = Keith();
console.log(person.height); //TypeError: person is undefined
console.log(window.height); //180
```

上面代码中，当在调用构造函数Keith时，忘记加上new命令。结果是this指向了全局作用域，height也就变成了全局变量。而变量person变成了undefined。

因此，应该非常小心，避免出现不使用new命令、直接调用构造函数的情况。

为了保证构造函数必须与new命令一起使用，一个解决办法是，在构造函数内部使用严格模式，即第一行加上`use strict`。

``` js
function Person(name, height) {
    'use strict';
    this.name = name;
    this.height = height;
}
var boy = Person();
console.log(boy) //TypeError: name is undefined
```

上面代码的Person为构造函数，use strict命令保证了该函数在严格模式下运行。由于在严格模式中，函数内部的this不能指向全局对象。如果指向了全局，this默认等于undefined，导致不加new调用会报错（JavaScript不允许对undefined添加属性）。

另一个解决办法，是在构造函数内部判断是否使用new命令，如果发现没有使用，则直接返回一个实例对象。

``` js
function Person(name, height) {
if (!(this instanceof Person)) {
        return new Person(name, height);
    }
    this.name = name;
    this.height = height;
}
var boy = Person('Keith');
console.log(boy.name) //'Keith'
```

如果构造函数内部有return语句，而且return后面跟着一个复杂数据类型（对象，数组等），new命令会返回return语句指定的对象；如果return语句后面跟着一个简单数据类型（字符串，布尔值，数字等），则会忽略return语句，返回this对象。
``` js
function Keith() {
    this.height = 180;
    return {
        height: 200
    };
}
var boy = new Keith();
console.log(boy.height); //200

function Keith() {
    this.height = 100;
    return 200;
}
var boy = new Keith();
console.log(boy.height); //100
```

另一方面，如果对普通函数（内部没有this关键字的函数）使用new命令，则会返回一个空对象。

``` js
function Keith() {
    return 'this is a message';
}
var boy = new Keith();
console.log(boy); // Keith {}
```

上面代码中，对普通函数Keith使用new命令，会创建一个空对象。这是因为new命令总是返回一个对象，要么是实例对象，要么是return语句指定的对象或数组。本例中，return语句返回的是字符串，所以new命令就忽略了该语句。


# 钩子函数
js派函数监听事件 =>监听函数就是所谓的钩子函数=>函数钩取事件：函数主动找事件=>钩子函数
所谓钩子函数，打个形象的比喻就是：一个大房子里的监控摄像头监控着每一个进入的人的面部特征，识别出了符合条件的人就触发警告（执行函数事件）；
可以理解为：钩子函数是事件被动地被监听着，一旦满足条件就执行：这种情况下往往可以执行多次（被监听到多次）；

# 回调函数
js预留函数给dom事件，dom事件调用js预留的函数 =>事件派发给函数：事件调用函数=>回调函数
而回调函数，可以看做是在一片地区埋了许许多多的地雷，一旦踩中了某个地雷（触发事件），地雷就会爆炸（执行函数事件）。
而回调函数是主动触事件，然后执行函数体的内容，往往是局部的。

# 函数柯里化
``` js
function multiply(a, b, c) {
    return a * b * c;
  }
multiply(1,2,3); // 6
// 柯里化后：
function multiply(a) {
    return (b) => {
        return (c) => {
            return a * b * c
        }
    }
}
multiply(1)(2)(3) // 6
```

通过把一个多参函数转换成一系列嵌套的函数，每个函数依次接受一个参数，这就是函数柯里化。

# 偏函数
局部应用则是固定一个函数的一个或者多个参数，也就是将一个 n 元函数转换成一个 n - x 元函数。

# 高阶函数
JavaScript的函数其实都指向某个变量。既然变量可以指向函数，函数的参数能接收变量，那么一个函数就可以接收另一个函数作为参数，这种函数就称之为高阶函数。
``` js
function add(x, y, f) {
    return f(x) + f(y);
}
```

# 函数式编程
函数式编程就像第三次工业革命，前两次分别为命令式编程（Imperative programming）和面向对象编程（Object Oriented Programming）。
