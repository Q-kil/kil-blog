---
title: clean-code-typescript
date: 2020-02-25 15:03:20
categories:
- TypeScript
tags:
- TypeScript
---


## Table of Contents 目录
- Introduction 介绍
- Variables 变量
- Functions 方法
- Objects and Data Structures 对象和数据结构
- Classes 类
- SOLID 固体
- Testing 测试中
- Concurrency 并发
- Error Handling 错误处理
- Formatting 格式化
- Comments 注释


### Introduction
{% asset_img clean-code.png %}

### Variables
#### 使用有意义的变量名
以使读者知道差异,提供什么方式来区分名称。
``` ts
// Bad
function between<T>(a1: T, a2: T, a3: T): boolean {
  return a2 <= a1 && a1 <= a3;
}

// Good
function between<T>(value: T, left: T, right: T): boolean {
  return left <= value && value <= right;
}
```

#### 使用明显的变量名
如果您无法说出来，就不会听起来像个白痴，就无法讨论它。
``` ts
// Bad
type DtaRcrd102 = {
  genymdhms: Date;
  modymdhms: Date;
  pszqint: number;
}

// Good
type Customer = {
  generationTimestamp: Date;
  modificationTimestamp: Date;
  recordId: number;
}
```

#### 对相同类型的变量使用相同的词汇表
``` ts
// Bad
function getUserInfo(): User;
function getUserDetails(): User;
function getUserData(): User;

// Good
function getUser(): User;
```

#### 使用可搜索的名称
我们将阅读比编写更多的代码。 我们编写的代码具有可读性和可搜索性，这一点很重要。 通过不命名最终对理解我们的程序有意义的变量，我们伤害了我们的读者。 使您的名字可搜索。 TSLint之类的工具可以帮助识别未命名的常量。
``` ts
// Bad
// What the heck is 86400000 for?
setTimeout(restart, 86400000);

// Good
// Declare them as capitalized named constants.
const MILLISECONDS_IN_A_DAY = 24 * 60 * 60 * 1000; // 一天中的毫秒数

setTimeout(restart, MILLISECONDS_IN_A_DAY);
```

#### 使用解释变量
``` ts
// Bad
declare const users: Map<string, User>;

for (const keyValue of users) {
  // iterate through users map
}

// Good
declare const users: Map<string, User>;

for (const [id, user] of users) {
  // iterate through users map
}
```

#### 避免思维导图
显式胜于隐式。
清晰为王。`Clarity is king`
``` ts
// Bad
const u = getUser();
const s = getSubscription();
const t = charge(u, s);

// Good
const user = getUser();
const subscription = getSubscription();
const transaction = charge(user, subscription);
```

#### 不要添加不需要的上下文
如果您的类/类型/对象名称告诉您某些内容，请不要在变量名称中重复。
``` ts
// Bad
type Car = {
  carMake: string;
  carModel: string;
  carColor: string;
}

function print(car: Car): void {
  console.log(`${car.carMake} ${car.carModel} (${car.carColor})`);
}

// Good
type Car = {
  make: string;
  model: string;
  color: string;
}

function print(car: Car): void {
  console.log(`${car.make} ${car.model} (${car.color})`);
}
```

#### 使用默认参数代替短路或条件
默认参数通常比短路更干净。
``` ts
// Bad
function loadPages(count?: number) {
  const loadCount = count !== undefined ? count : 10;
  // ...
}

// Good
function loadPages(count: number = 10) {
  // ...
}
```

#### 使用枚举来记录意图
枚举可以帮助您记录代码的意图。 例如，当我们关注的是不同的值而不是确切的值时。
``` ts
// Bad
const GENRE = {
  ROMANTIC: 'romantic',
  DRAMA: 'drama',
  COMEDY: 'comedy',
  DOCUMENTARY: 'documentary',
}

projector.configureFilm(GENRE.COMEDY);

class Projector {
  // delactation of Projector
  configureFilm(genre) {
    switch (genre) {
      case GENRE.ROMANTIC:
        // some logic to be executed 
    }
  }
}

// Good
enum GENRE {
  ROMANTIC,
  DRAMA,
  COMEDY,
  DOCUMENTARY,
}

projector.configureFilm(GENRE.COMEDY);

class Projector {
  // delactation of Projector
  configureFilm(genre) {
    switch (genre) {
      case GENRE.ROMANTIC:
        // some logic to be executed 
    }
  }
}
```

### 方法
#### 函数参数（理想情况下为2个或更少）
限制功能参数的数量非常重要，因为这使测试功能更加容易。超过三个会导致组合爆炸，您必须使用每个单独的参数测试大量不同的案例。

一个或两个参数是理想的情况，如果可能，应避免三个参数。除此之外，还应该合并。通常，如果您有两个以上的参数，则您的函数将尝试执行过多操作。在没有这种情况的情况下，大多数情况下，更高级别的对象作为参数就足够了。

如果发现自己需要大量参数，请考虑使用对象文字。

为了使函数具有明显的属性，您可以使用解构语法。这有一些优点：

- 当有人查看函数签名时，会立即清楚正在使用哪些属性。
- 它可以用来模拟命名参数。
- 解构还会克隆传递到函数中的参数对象的指定原始值。这可以帮助防止副作用。注意：不会复制从参数对象解构的对象和数组。
- TypeScript会警告您有关未使用的属性的信息，如果不进行结构化，这是不可能的。

``` ts
// Bad
function createMenu(title: string, body: string, buttonText: string, cancellable: boolean) {
  // ...
}

createMenu('Foo', 'Bar', 'Baz', true);

// Good
function createMenu(options: { title: string, body: string, buttonText: string, cancellable: boolean }) {
  // ...
}

createMenu({
  title: 'Foo',
  body: 'Bar',
  buttonText: 'Baz',
  cancellable: true
});

// Good Advanced 进阶
// 您可以使用类型别名进一步提高可读性：
type MenuOptions = { title: string, body: string, buttonText: string, cancellable: boolean };

function createMenu(options: MenuOptions) {
  // ...
}

createMenu({
  title: 'Foo',
  body: 'Bar',
  buttonText: 'Baz',
  cancellable: true
});
```

#### 函数应该做一件事
到目前为止，这是软件工程中最重要的规则。 当函数做的事情不止一件事时，它们就很难进行编写，测试和推理。 当您可以将一个函数隔离为一个动作时，可以轻松地对其进行重构，并且代码将变得更加清晰。 如果您除了本指南之外没有其他事，您将领先于许多开发人员。
``` ts
// Bad
function emailClients(clients: Client[]) {
  clients.forEach((client) => {
    const clientRecord = database.lookup(client);
    if (clientRecord.isActive()) {
      email(client);
    }
  });
}

// Good
function emailClients(clients: Client[]) {
  clients.filter(isActiveClient).forEach(email);
}

function isActiveClient(client: Client) {
  const clientRecord = database.lookup(client);
  return clientRecord.isActive();
}
```

#### 函数名称应说明其作用
``` ts
// Bad
function addToDate(date: Date, month: number): Date {
  // ...
}

const date = new Date();

// It's hard to tell from the function name what is added
addToDate(date, 1);

// Good
function addMonthToDate(date: Date, month: number): Date {
  // ...
}

const date = new Date();
addMonthToDate(date, 1);
```

#### 函数只能是一个抽象级别
当您具有多个抽象级别时，您的函数通常会执行过多操作。 拆分功能可提高可重用性并简化测试。
``` ts
// Bad
function parseCode(code: string) {
  const REGEXES = [ /* ... */ ];
  const statements = code.split(' ');
  const tokens = [];

  REGEXES.forEach((regex) => {
    statements.forEach((statement) => {
      // ...
    });
  });

  const ast = [];
  tokens.forEach((token) => {
    // lex...
  });

  ast.forEach((node) => {
    // parse...
  });
}

// Good
const REGEXES = [ /* ... */ ];

function parseCode(code: string) {
  const tokens = tokenize(code);
  const syntaxTree = parse(tokens);

  syntaxTree.forEach((node) => {
    // parse...
  });
}

function tokenize(code: string): Token[] {
  const statements = code.split(' ');
  const tokens: Token[] = [];

  REGEXES.forEach((regex) => {
    statements.forEach((statement) => {
      tokens.push( /* ... */ );
    });
  });

  return tokens;
}

function parse(tokens: Token[]): SyntaxTree {
  const syntaxTree: SyntaxTree[] = [];
  tokens.forEach((token) => {
    syntaxTree.push( /* ... */ );
  });

  return syntaxTree;
}
```

#### 删除重复的代码
尽最大努力避免重复代码。复制代码是不好的，因为这意味着如果您需要更改某些逻辑，则可以在多个地方进行更改。

想象一下，如果您经营一家餐馆，并且跟踪库存：所有的西红柿，洋葱，大蒜，香料等。如果您保留了多个列表，那么当您配以西红柿的菜时都必须进行更新在他们之中。如果只有一个列表，那么只有一个地方可以更新！

通常，您有重复的代码，因为您有两个或多个稍有不同的事物，它们有很多共同点，但是它们之间的差异迫使您拥有两个或多个独立的函数来完成许多相同的事情。删除重复的代码意味着创建一个仅用一个函数/模块/类就可以处理这组不同事物的抽象。

确保正确的抽象是至关重要的，这就是为什么您应该遵循SOLID原则。错误的抽象可能比重复的代码更糟糕，因此请小心！话虽如此，如果您可以做一个好的抽象，那就去做吧！不要重复自己，否则，只要想更改一件事，就会发现自己更新了多个位置。

``` ts
// Bad
function showDeveloperList(developers: Developer[]) {
  developers.forEach((developer) => {
    const expectedSalary = developer.calculateExpectedSalary();
    const experience = developer.getExperience();
    const githubLink = developer.getGithubLink();

    const data = {
      expectedSalary,
      experience,
      githubLink
    };

    render(data);
  });
}

function showManagerList(managers: Manager[]) {
  managers.forEach((manager) => {
    const expectedSalary = manager.calculateExpectedSalary();
    const experience = manager.getExperience();
    const portfolio = manager.getMBAProjects();

    const data = {
      expectedSalary,
      experience,
      portfolio
    };

    render(data);
  });
}

// Good
class Developer {
  // ...
  getExtraDetails() {
    return {
      githubLink: this.githubLink,
    }
  }
}

class Manager {
  // ...
  getExtraDetails() {
    return {
      portfolio: this.portfolio,
    }
  }
}

function showEmployeeList(employee: Developer | Manager) {
  employee.forEach((employee) => {
    const expectedSalary = employee.calculateExpectedSalary();
    const experience = employee.getExperience();
    const extra = employee.getExtraDetails();

    const data = {
      expectedSalary,
      experience,
      extra,
    };

    render(data);
  });
}
```

您应该对代码复制很挑剔。 有时，通过引入不必要的抽象，在重复的代码和增加的复杂性之间进行权衡。 当来自两个不同模块的两个实现看起来相似但都位于不同的域中时，与提取公共代码相比，复制可能是可接受的并且是首选的方法。 在这种情况下，提取的通用代码在两个模块之间引入了间接依赖性。


#### 使用Object.assign或Destructuring设置默认对象
``` ts
// Bad
type MenuConfig = { title?: string, body?: string, buttonText?: string, cancellable?: boolean };

function createMenu(config: MenuConfig) {
  config.title = config.title || 'Foo';
  config.body = config.body || 'Bar';
  config.buttonText = config.buttonText || 'Baz';
  config.cancellable = config.cancellable !== undefined ? config.cancellable : true;

  // ...
}

createMenu({ body: 'Bar' });

// Good
type MenuConfig = { title?: string, body?: string, buttonText?: string, cancellable?: boolean };

function createMenu(config: MenuConfig) {
  const menuConfig = Object.assign({
    title: 'Foo',
    body: 'Bar',
    buttonText: 'Baz',
    cancellable: true
  }, config);

  // ...
}

createMenu({ body: 'Bar' });

// Good 另外，您可以使用默认值进行解构：
type MenuConfig = { title?: string, body?: string, buttonText?: string, cancellable?: boolean };

function createMenu({ title = 'Foo', body = 'Bar', buttonText = 'Baz', cancellable = true }: MenuConfig) {
  // ...
}

createMenu({ body: 'Bar' });
```
为了通过显式传入undefined或null值来避免任何副作用和意外行为，可以告诉TypeScript编译器不允许这样做。 请参见TypeScript中的--strictNullChecks选项。

#### 不要将标志用作函数参数
标志告诉您的用户，此功能可以完成多项任务。 函数应该做一件事。 如果函数遵循基于布尔的不同代码路径，请拆分它们。
``` ts
// Bad
function createFile(name: string, temp: boolean) {
  if (temp) {
    fs.create(`./temp/${name}`);
  } else {
    fs.create(name);
  }
}

// Good
function createTempFile(name: string) {
  createFile(`./temp/${name}`);
}

function createFile(name: string) {
  fs.create(name);
}
```

#### 避免副作用（第1部分）
如果函数除了接受一个值并返回另一个值或多个值以外，不执行任何其他操作，都会产生副作用。 副作用可能是写入文件，修改某些全局变量，或者不小心将您的所有资金都汇给了陌生人。

现在，您确实需要偶尔在程序中产生副作用。 与前面的示例一样，您可能需要写入文件。 您想要做的就是集中执行此操作的位置。 没有几个写入特定文件的函数和类。 有一项服务可以做到这一点。 一个，只有一个。

要点是要避免常见的陷阱，例如在没有任何结构的对象之间共享状态，使用可以被任何东西写入的可变数据类型，而不是集中发生副作用的地方。 如果您能做到这一点，您将比绝大多数其他程序员更快乐。

``` ts
// Bad
// Global variable referenced by following function.
let name = 'Robert C. Martin';

function toBase64() {
  name = btoa(name);
}

toBase64();
// If we had another function that used this name, now it'd be a Base64 value

console.log(name); // expected to print 'Robert C. Martin' but instead 'Um9iZXJ0IEMuIE1hcnRpbg=='

// Good
const name = 'Robert C. Martin';

function toBase64(text: string): string {
  return btoa(text);
}

const encodedName = toBase64(name);
console.log(name);
```

#### 避免副作用（第2部分）
在JavaScript中，基元按值传递，而对象/数组按引用传递。对于对象和数组，如果您的函数在购物车数组中进行了更改（例如，通过添加要购买的商品），则使用该购物车数组的任何其他函数都将受到此添加的影响。那可能很棒，但是也可能不好。让我们想象一个糟糕的情况：

用户单击“购买”按钮，该按钮将调用产生网络请求的购物功能，并将购物车阵列发送到服务器。由于网络连接不良，购买功能必须继续重试请求。现在，如果与此同时，用户在网络请求开始之前意外地在他们实际上不想要的商品上单击“添加到购物车”按钮，该怎么办？如果发生这种情况并且网络请求开始，那么该购买功能将发送意外添加的项目，因为它具有对购物车数组的引用，该数组由addItemToCart函数通过添加不需要的项目进行了修改。

一个很好的解决方案是让addItemToCart始终克隆购物车，对其进行编辑并返回克隆。这样可以确保任何保存在购物车参考上的功能都不会受到任何更改的影响。

关于此方法有两个警告：

在某些情况下，您实际上可能想修改输入对象，但是当您采用这种编程习惯时，您会发现这些情况很少见。大多数事情都可以重构为没有副作用！ （请参见纯函数）

就性能而言，克隆大对象可能会非常昂贵。幸运的是，在实践中这并不是一个大问题，因为有很多很棒的库使这种编程方法能够快速进行，并且不像手动克隆对象和数组那样占用大量内存。
``` ts
interface CartItem {
  item: Item;
  date: number;
}
interface Item {
  tag: string;
}
// Bad
function addItemToCart(cart: CartItem[], item: Item): void {
  cart.push({ item, date: Date.now() });
};

// Good
function addItemToCart(cart: CartItem[], item: Item): CartItem[] {
  return [...cart, { item, date: Date.now() }];
};
```

#### 不写入全局函数
在JavaScript中污染globals是一种不好的做法，因为您可能会与另一个库发生冲突，并且API的用户在生产中遇到异常之前不会更聪明。让我们考虑一个例子：如果您想扩展JavaScript的本机数组方法，使之具有一个diff方法来显示两个数组之间的差异，该怎么办？您可以将新函数写入Array.prototype，但它可能与另一个试图执行相同操作的库冲突。如果另一个库只是使用diff来查找数组的第一个元素和最后一个元素之间的差异呢？这就是为什么只使用类并简单地扩展数组全局会更好的原因。
``` ts
// Bad
declare global {
  interface Array<T> {
    diff(other: T[]): Array<T>;
  }
}

if (!Array.prototype.diff) {
  Array.prototype.diff = function <T>(other: T[]): T[] {
    const hash = new Set(other);
    return this.filter(elem => !hash.has(elem));
  };
}

// Good
class MyArray<T> extends Array<T> {
  diff(other: T[]): T[] {
    const hash = new Set(other);
    return this.filter(elem => !hash.has(elem));
  };
}
```

#### 偏好函数式编程胜过命令式编程
尽可能的喜欢这种编程风格。
`reduce`
``` ts
// Bad
const contributions = [
  {
    name: 'Uncle Bobby',
    linesOfCode: 500
  }, {
    name: 'Suzie Q',
    linesOfCode: 1500
  }, {
    name: 'Jimmy Gosling',
    linesOfCode: 150
  }, {
    name: 'Gracie Hopper',
    linesOfCode: 1000
  }
];

let totalOutput = 0;

for (let i = 0; i < contributions.length; i++) {
  totalOutput += contributions[i].linesOfCode;
}

// Good
const contributions = [
  {
    name: 'Uncle Bobby',
    linesOfCode: 500
  }, {
    name: 'Suzie Q',
    linesOfCode: 1500
  }, {
    name: 'Jimmy Gosling',
    linesOfCode: 150
  }, {
    name: 'Gracie Hopper',
    linesOfCode: 1000
  }
];

const totalOutput = contributions
  .reduce((totalLines, output) => totalLines + output.linesOfCode, 0);
```

#### 封装条件语句
``` ts
// Bad
if (subscription.isTrial || account.balance > 0) {
  // ...
}

// Good
function canActivateService(subscription: Subscription, account: Account) {
  return subscription.isTrial || account.balance > 0
}

if (canActivateService(subscription, account)) {
  // ...
}
```

#### 避免否定条件句
``` ts
// Bad
function isEmailNotUsed(email: string): boolean {
  // ...
}

if (isEmailNotUsed(email)) {
  // ...
}

// Good
function isEmailUsed(email): boolean {
  // ...
}

if (!isEmailUsed(node)) {
  // ...
}
```

#### 避免条件句
这似乎是一项不可能完成的任务。一听到这个，大多数人都会说：“如果没有if语句，我怎么能做任何事情呢？”答案是，在许多情况下，可以使用多态性来实现相同的任务。第二个问题通常是，“很好，但我为什么要这么做呢？”答案是我们以前学到的一个干净的代码概念：函数应该只做一件事。当您有具有if语句的类和函数时，您是在告诉用户您的函数做了不止一件事。记住，只要做一件事。
`abstract `




``` ts
// Bad
class Airplane {
  private type: string;
  // ...

  getCruisingAltitude() {
    switch (this.type) {
      case '777':
        return this.getMaxAltitude() - this.getPassengerCount();
      case 'Air Force One':
        return this.getMaxAltitude();
      case 'Cessna':
        return this.getMaxAltitude() - this.getFuelExpenditure();
      default:
        throw new Error('Unknown airplane type.');
    }
  }

  private getMaxAltitude(): number {
    // ...
  }
}

// Good
abstract class Airplane {
  protected getMaxAltitude(): number {
    // shared logic with subclasses ...
  }

  // ...
}

class Boeing777 extends Airplane {
  // ...
  getCruisingAltitude() {
    return this.getMaxAltitude() - this.getPassengerCount();
  }
}

class AirForceOne extends Airplane {
  // ...
  getCruisingAltitude() {
    return this.getMaxAltitude();
  }
}

class Cessna extends Airplane {
  // ...
  getCruisingAltitude() {
    return this.getMaxAltitude() - this.getFuelExpenditure();
  }
}
```

#### 避免类型检查
TypeScript是JavaScript的一个严格的语法超集，它为语言添加了可选的静态类型检查。总是倾向于指定变量、参数和返回值的类型，以充分利用TypeScript特性的强大功能。它使重构更加容易。
TODO
``` ts
// Bad
function travelToTexas(vehicle: Bicycle | Car) {
  if (vehicle instanceof Bicycle) {
    vehicle.pedal(currentLocation, new Location('texas'));
  } else if (vehicle instanceof Car) {
    vehicle.drive(currentLocation, new Location('texas'));
  }
}

// Good
type Vehicle = Bicycle | Car;

function travelToTexas(vehicle: Vehicle) {
  vehicle.move(currentLocation, new Location('texas'));
}
```

#### 不要过度优化
现代浏览器在运行时做了很多优化工作。很多时候，如果你在优化，那么你只是在浪费时间。有很好的资源可以看出哪里缺乏优化。同时瞄准那些目标，直到它们被修复。
``` ts
// Bad
// On old browsers, each iteration with uncached `list.length` would be costly
// because of `list.length` recomputation. In modern browsers, this is optimized.
for (let i = 0, len = list.length; i < len; i++) {
  // ...
}

// Good
for (let i = 0; i < list.length; i++) {
  // ...
}
```

#### 删除死代码
死代码和重复代码一样糟糕。没有理由把它保存在你的代码库中。如果没有人叫它，就把它扔掉！如果您仍然需要它，它在您的版本历史中仍然是安全的。

``` ts
// Bad
function oldRequestModule(url: string) {
  // ...
}

function requestModule(url: string) {
  // ...
}

const req = requestModule;
inventoryTracker('apples', req, 'www.inventory-awesome.io');

// Good
function requestModule(url: string) {
  // ...
}

const req = requestModule;
inventoryTracker('apples', req, 'www.inventory-awesome.io');
```

#### 使用迭代器和生成器
当处理像流一样使用的数据集合时，请使用生成器和iterable。
有一些很好的理由：
- 在被调用方决定访问多少项的意义上，将被调用方与生成器实现分离
- 延迟执行，项目按需流动
- 内置对使用for of语法迭代项的支持
- iterables允许实现优化的迭代器模式
// TODO
``` ts
// Bad
function fibonacci(n: number): number[] {
  if (n === 1) return [0];
  if (n === 2) return [0, 1];

  const items: number[] = [0, 1];
  while (items.length < n) {
    items.push(items[items.length - 2] + items[items.length - 1]);
  }

  return items;
}

function print(n: number) {
  fibonacci(n).forEach(fib => console.log(fib));
}

// Print first 10 Fibonacci numbers.
print(10);

// Good
// Generates an infinite stream of Fibonacci numbers.
// The generator doesn't keep the array of all numbers.
function* fibonacci(): IterableIterator<number> {
  let [a, b] = [0, 1];

  while (true) {
    yield a;
    [a, b] = [b, a + b];
  }
}

function print(n: number) {
  let i = 0;
  for (const fib of fibonacci()) {
    if (i++ === n) break;  
    console.log(fib);
  }  
}

// Print first 10 Fibonacci numbers.
print(10);
```
有些库允许以与本机数组类似的方式使用iterables，方法是链接map、slice、forEach等方法。请参阅itiriri以获取iterables的高级操作示例（或itiriri async以获取异步iterables的操作示例）。
``` ts
import itiriri from 'itiriri';

function* fibonacci(): IterableIterator<number> {
  let [a, b] = [0, 1];
 
  while (true) {
    yield a;
    [a, b] = [b, a + b];
  }
}

itiriri(fibonacci())
  .take(10)
  .forEach(fib => console.log(fib));
```

### 对象和数据结构
#### 使用getter和setter
TypeScript支持getter/setter语法。使用getter和setter从封装行为的对象访问数据可能比简单地在对象上查找属性要好。”为什么？”你可能会问。好吧，这里有一个原因列表：
- 当你想做的不仅仅是获取一个对象属性，你不需要查找和更改代码库中的每个访问器。
- 使在执行集合时添加验证变得简单。
- 封装内部表示。
- 在获取和设置时易于添加日志记录和错误处理。
- 可以延迟加载对象的属性，例如从服务器获取。

``` ts
// Bad
type BankAccount = {
  balance: number;
  // ...
}

const value = 100;
const account: BankAccount = {
  balance: 0,
  // ...
};

if (value < 0) {
  throw new Error('Cannot set negative balance.');
}

account.balance = value;

// Good
class BankAccount {
  private accountBalance: number = 0;

  get balance(): number {
    return this.accountBalance;
  }

  set balance(value: number) {
    if (value < 0) {
      throw new Error('Cannot set negative balance.');
    }

    this.accountBalance = value;
  }

  // ...
}

// Now `BankAccount` encapsulates the validation logic.
// If one day the specifications change, and we need extra validation rule,
// we would have to alter only the `setter` implementation,
// leaving all dependent code unchanged.
const account = new BankAccount();
account.balance = 100;
```

#### 使对象具有私有/受保护的成员
TypeScript支持类成员上的public（默认）、protected和private访问器。
// TODO
``` ts
// Bad
class Circle {
  radius: number;
  
  constructor(radius: number) {
    this.radius = radius;
  }

  perimeter() {
    return 2 * Math.PI * this.radius;
  }

  surface() {
    return Math.PI * this.radius * this.radius;
  }
}

// Good
class Circle {
  constructor(private readonly radius: number) {
  }

  perimeter() {
    return 2 * Math.PI * this.radius;
  }

  surface() {
    return Math.PI * this.radius * this.radius;
  }
}
```

#### 偏好不变性
TypeScript的类型系统允许您将接口/类上的单个属性标记为只读。这允许你以一种功能性的方式工作（意外的突变是不好的）。
对于更高级的场景，有一个内置类型Readonly，它接受类型T，并使用映射类型将其所有属性标记为只读（请参见映射类型）。

``` ts
// Bad
interface Config {
  host: string;
  port: string;
  db: string;
}

// Good
interface Config {
  readonly host: string;
  readonly port: string;
  readonly db: string;
}
```
对于数组，可以使用read only Array<T>创建只读数组。不允许进行push（）和fill（）等更改，但可以使用concat（）和slice（）等不更改值的功能。

``` ts
// Bad
const array: number[] = [ 1, 3, 5 ];
array = []; // error
array.push(100); // array will updated

// Good
const array: ReadonlyArray<number> = [ 1, 3, 5 ];
array = []; // error
array.push(100); // error
```

在TypeScript3.4中声明只读参数要容易一些。
``` ts
function hoge(args: readonly string[]) {
  args.push(1); // error
}
```

对于文本值，更喜欢const断言。
``` ts
// Bad
const config = {
  hello: 'world'
};
config.hello = 'world'; // value is changed

const array  = [ 1, 3, 5 ];
array[0] = 10; // value is changed

// writable objects is returned
function readonlyData(value: number) {
  return { value };
}

const result = readonlyData(100);
result.value = 200; // value is changed

// Good
// read-only object
const config = {
  hello: 'world'
} as const;
config.hello = 'world'; // error

// read-only array
const array  = [ 1, 3, 5 ] as const;
array[0] = 10; // error

// You can return read-only objects
function readonlyData(value: number) {
  return { value } as const;
}

const result = readonlyData(100);
result.value = 200; // error
```

#### 类型与接口
当您可能需要并集或交集时，请使用类型。如果需要扩展或实现，请使用接口。然而，没有严格的规则，使用一个为你工作。
有关更详细的解释，请参阅关于TypeScript中类型和接口之间差异的回答。
// TODO
``` ts
// Bad
interface EmailConfig {
  // ...
}

interface DbConfig {
  // ...
}

interface Config {
  // ...
}

//...

type Shape = {
  // ...
}

// Good
type EmailConfig = {
  // ...
}

type DbConfig = {
  // ...
}

type Config  = EmailConfig | DbConfig;

// ...

interface Shape {
  // ...
}

class Circle implements Shape {
  // ...
}

class Square implements Shape {
  // ...
}
```

### 类
#### 类应该很小
类的规模是由它的责任来衡量的。遵循单一责任原则，一个类应该是小的。


``` ts
// Bad
class Dashboard {
  getLanguage(): string { /* ... */ }
  setLanguage(language: string): void { /* ... */ }
  showProgress(): void { /* ... */ }
  hideProgress(): void { /* ... */ }
  isDirty(): boolean { /* ... */ }
  disable(): void { /* ... */ }
  enable(): void { /* ... */ }
  addSubscription(subscription: Subscription): void { /* ... */ }
  removeSubscription(subscription: Subscription): void { /* ... */ }
  addUser(user: User): void { /* ... */ }
  removeUser(user: User): void { /* ... */ }
  goToHomePage(): void { /* ... */ }
  updateProfile(details: UserDetails): void { /* ... */ }
  getVersion(): string { /* ... */ }
  // ...
}

// Good
class Dashboard {
  disable(): void { /* ... */ }
  enable(): void { /* ... */ }
  getVersion(): string { /* ... */ }
}

// split the responsibilities by moving the remaining methods to other classes
// ...
```

#### 高内聚低耦合

内聚性定义了类成员相互关联的程度。理想情况下，类中的所有字段都应该由每个方法使用。然后我们说这个类的内聚性最大。然而，在实践中，这并不总是可能的，甚至是不可取的。然而，你应该更喜欢高凝聚力。

耦合是指两个类之间的关系或依赖程度。如果其中一个类中的更改不影响另一个，则称其为低耦合。

良好的软件设计具有高内聚性和低耦合性。

``` ts
// Bad
class UserManager {
  // Bad: each private variable is used by one or another group of methods.
  // It makes clear evidence that the class is holding more than a single responsibility.
  // If I need only to create the service to get the transactions for a user,
  // I'm still forced to pass and instance of `emailSender`.
  constructor(
    private readonly db: Database,
    private readonly emailSender: EmailSender) {
  }

  async getUser(id: number): Promise<User> {
    return await db.users.findOne({ id });
  }

  async getTransactions(userId: number): Promise<Transaction[]> {
    return await db.transactions.find({ userId });
  }

  async sendGreeting(): Promise<void> {
    await emailSender.send('Welcome!');
  }

  async sendNotification(text: string): Promise<void> {
    await emailSender.send(text);
  }

  async sendNewsletter(): Promise<void> {
    // ...
  }
}

// Good
class UserService {
  constructor(private readonly db: Database) {
  }

  async getUser(id: number): Promise<User> {
    return await this.db.users.findOne({ id });
  }

  async getTransactions(userId: number): Promise<Transaction[]> {
    return await this.db.transactions.find({ userId });
  }
}

class UserNotifier {
  constructor(private readonly emailSender: EmailSender) {
  }

  async sendGreeting(): Promise<void> {
    await this.emailSender.send('Welcome!');
  }

  async sendNotification(text: string): Promise<void> {
    await this.emailSender.send(text);
  }

  async sendNewsletter(): Promise<void> {
    // ...
  }
}
```

#### 喜欢组合胜过继承

正如“四人帮”在设计模式中所说的那样，您应该尽可能地选择组合而不是继承。使用继承有很多好的理由，使用组合也有很多好的理由。这句格言的要点是，如果你的大脑本能地去继承，那么试着去思考构图是否能更好地模拟你的问题。在某些情况下可以。
你可能会想，“我什么时候应该使用继承权？”这取决于你手头的问题，但这是一个很好的列表，说明什么时候继承比组合更有意义：
- 您的继承表示“是”关系，而不是“有”关系（人->动物vs.用户->用户详细信息）。
- 您可以重用基类中的代码（人类可以像所有动物一样移动）。
- 您希望通过更改基类对派生类进行全局更改。（改变所有动物移动时的热量消耗）。

``` ts
// Bad
class Employee {
  constructor(
    private readonly name: string,
    private readonly email: string) {
  }

  // ...
}

// Bad because Employees "have" tax data. EmployeeTaxData is not a type of Employee
class EmployeeTaxData extends Employee {
  constructor(
    name: string,
    email: string,
    private readonly ssn: string,
    private readonly salary: number) {
    super(name, email);
  }

  // ...
}

// Good
class Employee {
  private taxData: EmployeeTaxData;

  constructor(
    private readonly name: string,
    private readonly email: string) {
  }

  setTaxData(ssn: string, salary: number): Employee {
    this.taxData = new EmployeeTaxData(ssn, salary);
    return this;
  }

  // ...
}

class EmployeeTaxData {
  constructor(
    public readonly ssn: string,
    public readonly salary: number) {
  }

  // ...
}
```

#### 使用方法链接
这种模式非常有用，在许多库中都很常用。它允许您的代码具有表现力，并且不太冗长。因此，请使用方法链接并查看代码的干净程度。

``` ts
// Bad
class QueryBuilder {
  private collection: string;
  private pageNumber: number = 1;
  private itemsPerPage: number = 100;
  private orderByFields: string[] = [];

  from(collection: string): void {
    this.collection = collection;
  }

  page(number: number, itemsPerPage: number = 100): void {
    this.pageNumber = number;
    this.itemsPerPage = itemsPerPage;
  }

  orderBy(...fields: string[]): void {
    this.orderByFields = fields;
  }

  build(): Query {
    // ...
  }
}

// ...

const queryBuilder = new QueryBuilder();
queryBuilder.from('users');
queryBuilder.page(1, 100);
queryBuilder.orderBy('firstName', 'lastName');

const query = queryBuilder.build();

// Good
class QueryBuilder {
  private collection: string;
  private pageNumber: number = 1;
  private itemsPerPage: number = 100;
  private orderByFields: string[] = [];

  from(collection: string): this {
    this.collection = collection;
    return this;
  }

  page(number: number, itemsPerPage: number = 100): this {
    this.pageNumber = number;
    this.itemsPerPage = itemsPerPage;
    return this;
  }

  orderBy(...fields: string[]): this {
    this.orderByFields = fields;
    return this;
  }

  build(): Query {
    // ...
  }
}

// ...

const query = new QueryBuilder()
  .from('users')
  .page(1, 100)
  .orderBy('firstName', 'lastName')
  .build();
```

### SOLID
SOLID 是由 Robert C. Martin 在面向对象设计的（OOD）中提出的五个原则，你可以在这里更一步了解关于@UncleBob，这五个原则（SOLID）就是：

单一职责原则（Single Responsibility Principle）：当需要修改某个类的时候原因有且只有一个
开放封闭原则（Open Closed Principle）：软件实体应该是可扩展，而不能可修改的
里氏替换原则（Liskov Substitution Principle）：子类的实例应该能够替换任何其超类的实例
接口分离原则（Interface Segregation Principle）：使用多个专门的接口比使用单一的总接口总要好
依赖倒置原则（Dependency Inversion Principle）：依赖于抽象不应该依赖于细节
这些原则使得程序员可以轻松地开发易于维护和扩展的软件。它们还使开发人员的代码能够容易地避免坏气味，轻松重构代码，并且也是敏捷或自适应软件开发的一部分。

#### 单一责任原则
如干净代码中所述，“类更改的原因不应超过一个”。很容易把一个功能性很强的班级塞满，比如你在航班上只能带一个手提箱。这样做的问题是，你的类在概念上没有凝聚力，它会给它很多改变的理由。最小化您需要更改类的次数非常重要。这很重要，因为如果一个类中有太多的功能，并且您修改了其中的一部分，那么很难理解这将如何影响代码库中的其他依赖模块。
// TODO
``` ts
// Bad
class UserSettings {
  constructor(private readonly user: User) {
  }

  changeSettings(settings: UserSettings) {
    if (this.verifyCredentials()) {
      // ...
    }
  }

  verifyCredentials() {
    // ...
  }
}

// Good
class UserAuth {
  constructor(private readonly user: User) {
  }

  verifyCredentials() {
    // ...
  }
}


class UserSettings {
  private readonly auth: UserAuth;

  constructor(private readonly user: User) {
    this.auth = new UserAuth(user);
  }

  changeSettings(settings: UserSettings) {
    if (this.auth.verifyCredentials()) {
      // ...
    }
  }
}
```

#### 开闭原理
正如Bertrand Meyer所说，“软件实体（类、模块、函数等）应该开放以供扩展，但关闭以供修改。”这意味着什么？这个原则基本上是说你应该允许用户在不改变现有代码的情况下添加新的功能。




``` ts
// Bad
class AjaxAdapter extends Adapter {
  constructor() {
    super();
  }

  // ...
}

class NodeAdapter extends Adapter {
  constructor() {
    super();
  }

  // ...
}

class HttpRequester {
  constructor(private readonly adapter: Adapter) {
  }

  async fetch<T>(url: string): Promise<T> {
    if (this.adapter instanceof AjaxAdapter) {
      const response = await makeAjaxCall<T>(url);
      // transform response and return
    } else if (this.adapter instanceof NodeAdapter) {
      const response = await makeHttpCall<T>(url);
      // transform response and return
    }
  }
}

function makeAjaxCall<T>(url: string): Promise<T> {
  // request and return promise
}

function makeHttpCall<T>(url: string): Promise<T> {
  // request and return promise
}

// Good
abstract class Adapter {
  abstract async request<T>(url: string): Promise<T>;

  // code shared to subclasses ...
}

class AjaxAdapter extends Adapter {
  constructor() {
    super();
  }

  async request<T>(url: string): Promise<T>{
    // request and return promise
  }

  // ...
}

class NodeAdapter extends Adapter {
  constructor() {
    super();
  }

  async request<T>(url: string): Promise<T>{
    // request and return promise
  }

  // ...
}

class HttpRequester {
  constructor(private readonly adapter: Adapter) {
  }

  async fetch<T>(url: string): Promise<T> {
    const response = await this.adapter.request<T>(url);
    // transform response and return
  }
}
```

#### Liskov替代原理（LSP）
对于一个非常简单的概念来说，这是一个可怕的术语。它被正式定义为“如果s是T的一个子类型，那么T类型的对象可以替换为s类型的对象（即，s类型的对象可以替换T类型的对象），而不改变该程序的任何期望属性（正确性、执行的任务等）。”这是一个更可怕的定义。

最好的解释是，如果有父类和子类，那么父类和子类可以互换使用，而不会得到错误的结果。这可能仍然令人困惑，所以让我们看一看经典的正方形矩形示例。从数学上讲，正方形是一个长方形，但如果通过继承使用“is-a”关系对其建模，则很快就会遇到麻烦。

``` ts
// Bad
class Rectangle {
  constructor(
    protected width: number = 0,
    protected height: number = 0) {

  }

  setColor(color: string): this {
    // ...
  }

  render(area: number) {
    // ...
  }

  setWidth(width: number): this {
    this.width = width;
    return this;
  }

  setHeight(height: number): this {
    this.height = height;
    return this;
  }

  getArea(): number {
    return this.width * this.height;
  }
}

class Square extends Rectangle {
  setWidth(width: number): this {
    this.width = width;
    this.height = width;
    return this;
  }

  setHeight(height: number): this {
    this.width = height;
    this.height = height;
    return this;
  }
}

function renderLargeRectangles(rectangles: Rectangle[]) {
  rectangles.forEach((rectangle) => {
    const area = rectangle
      .setWidth(4)
      .setHeight(5)
      .getArea(); // BAD: Returns 25 for Square. Should be 20.
    rectangle.render(area);
  });
}

const rectangles = [new Rectangle(), new Rectangle(), new Square()];
renderLargeRectangles(rectangles);

// Good
abstract class Shape {
  setColor(color: string): this {
    // ...
  }

  render(area: number) {
    // ...
  }

  abstract getArea(): number;
}

class Rectangle extends Shape {
  constructor(
    private readonly width = 0,
    private readonly height = 0) {
    super();
  }

  getArea(): number {
    return this.width * this.height;
  }
}

class Square extends Shape {
  constructor(private readonly length: number) {
    super();
  }

  getArea(): number {
    return this.length * this.length;
  }
}

function renderLargeShapes(shapes: Shape[]) {
  shapes.forEach((shape) => {
    const area = shape.getArea();
    shape.render(area);
  });
}

const shapes = [new Rectangle(4, 5), new Rectangle(4, 5), new Square(5)];
renderLargeShapes(shapes);
```

#### 界面分离原理（ISP）
ISP声明“不应强迫客户依赖他们不使用的接口”。这一原则与单一责任原则密切相关。它的真正含义是，您应该始终以这样一种方式设计您的抽象，即使用公开方法的客户机不会得到整个饼图。这还包括强迫客户机实现他们实际上不需要的方法。

``` ts
// Bad
interface SmartPrinter {
  print();
  fax();
  scan();
}

class AllInOnePrinter implements SmartPrinter {
  print() {
    // ...
  }  
  
  fax() {
    // ...
  }

  scan() {
    // ...
  }
}

class EconomicPrinter implements SmartPrinter {
  print() {
    // ...
  }  
  
  fax() {
    throw new Error('Fax not supported.');
  }

  scan() {
    throw new Error('Scan not supported.');
  }
}

// Good
interface Printer {
  print();
}

interface Fax {
  fax();
}

interface Scanner {
  scan();
}

class AllInOnePrinter implements Printer, Fax, Scanner {
  print() {
    // ...
  }  
  
  fax() {
    // ...
  }

  scan() {
    // ...
  }
}

class EconomicPrinter implements Printer {
  print() {
    // ...
  }
}
```

#### 依赖反演原理（DIP）
这一原则规定了两件基本的事情：
- 高级模块不应依赖于低级模块。两者都应该依赖于抽象。
- 抽象不应依赖于细节。细节应该取决于抽象。
一开始这可能很难理解，但是如果您使用过Angular，那么您已经看到了以依赖注入（DI）的形式实现这一原则。虽然它们不是完全相同的概念，但DIP使高级模块无法了解其低级模块的详细信息并设置它们。它可以通过DI来实现这一点。这样做的一个巨大好处是减少了模块之间的耦合。耦合是一种非常糟糕的开发模式，因为它使您的代码难以重构。
下倾通常通过使用控制反转（IoC）容器来实现。TypeScript的强大IoC容器的一个例子是InversifyJs

``` ts
// Bad
import { readFile as readFileCb } from 'fs';
import { promisify } from 'util';

const readFile = promisify(readFileCb);

type ReportData = {
  // ..
}

class XmlFormatter {
  parse<T>(content: string): T {
    // Converts an XML string to an object T
  }
}

class ReportReader {

  // BAD: We have created a dependency on a specific request implementation.
  // We should just have ReportReader depend on a parse method: `parse`
  private readonly formatter = new XmlFormatter();

  async read(path: string): Promise<ReportData> {
    const text = await readFile(path, 'UTF8');
    return this.formatter.parse<ReportData>(text);
  }
}

// ...
const reader = new ReportReader();
await report = await reader.read('report.xml');

// Good
import { readFile as readFileCb } from 'fs';
import { promisify } from 'util';

const readFile = promisify(readFileCb);

type ReportData = {
  // ..
}

interface Formatter {
  parse<T>(content: string): T;
}

class XmlFormatter implements Formatter {
  parse<T>(content: string): T {
    // Converts an XML string to an object T
  }
}


class JsonFormatter implements Formatter {
  parse<T>(content: string): T {
    // Converts a JSON string to an object T
  }
}

class ReportReader {
  constructor(private readonly formatter: Formatter) {
  }

  async read(path: string): Promise<ReportData> {
    const text = await readFile(path, 'UTF8');
    return this.formatter.parse<ReportData>(text);
  }
}

// ...
const reader = new ReportReader(new XmlFormatter());
await report = await reader.read('report.xml');

// or if we had to read a json report
const reader = new ReportReader(new JsonFormatter());
await report = await reader.read('report.json');
```

### 单元测试
测试比运输更重要。如果你没有测试或者数量不足，那么每次你发布代码的时候，你都不会确定你没有破坏任何东西。决定什么是一个足够的数量取决于你的团队，但是100%的覆盖率（所有的声明和分支）是你如何获得非常高的信心和开发者的安心。这意味着除了有一个好的测试框架外，还需要使用一个好的覆盖工具。
没有理由不写测试。有很多很好的JS测试框架支持TypeScript的类型，所以找一个你的团队喜欢的。当您找到一个适合您的团队的功能时，请始终为您引入的每个新功能/模块编写测试。如果您首选的方法是测试驱动开发（TDD），那就太好了，但重点是在启动任何功能或重构现有功能之前，确保您达到了覆盖率目标。

TDD的三定律
- 除非要使失败的单元测试通过，否则不允许编写任何生产代码。
- 不允许您编写的单元测试超过了失败的数量；编译失败就是失败。
- 不允许您编写的生产代码超过足以通过一次失败的单元测试的数量。

#### F.I.R.S.T.规则

清洁测试应遵循以下规则：
- 快速测试应该很快，因为我们希望经常运行它们。
- 独立测试不应相互依赖。它们应该提供相同的输出，无论是独立运行还是以任何顺序一起运行。
- 可重复的测试应该在任何环境中都是可重复的，不应该有任何理由解释为什么它们会失败。
- 自验证测试的答案应为“通过”或“失败”。如果测试通过，则不需要比较日志文件来回答问题。
- 及时的单元测试应该在生产代码之前编写。如果在生产代码之后编写测试，可能会发现编写测试太难。


#### 每次测试的单一概念
测试也应遵循单一责任原则。每个单元测试只生成一个断言。

``` ts
// Bad
import { assert } from 'chai';

describe('AwesomeDate', () => {
  it('handles date boundaries', () => {
    let date: AwesomeDate;

    date = new AwesomeDate('1/1/2015');
    assert.equal('1/31/2015', date.addDays(30));

    date = new AwesomeDate('2/1/2016');
    assert.equal('2/29/2016', date.addDays(28));

    date = new AwesomeDate('2/1/2015');
    assert.equal('3/1/2015', date.addDays(28));
  });
});

// Good
import { assert } from 'chai';

describe('AwesomeDate', () => {
  it('handles 30-day months', () => {
    const date = new AwesomeDate('1/1/2015');
    assert.equal('1/31/2015', date.addDays(30));
  });

  it('handles leap year', () => {
    const date = new AwesomeDate('2/1/2016');
    assert.equal('2/29/2016', date.addDays(28));
  });

  it('handles non-leap year', () => {
    const date = new AwesomeDate('2/1/2015');
    assert.equal('3/1/2015', date.addDays(28));
  });
});
```

#### 测试的名称应该表明它的意图
当一个测试失败时，它的名字是可能出错的第一个指示。

``` ts
// Bad
describe('Calendar', () => {
  it('2/29/2020', () => {
    // ...
  });

  it('throws', () => {
    // ...
  });
});

// Good
describe('Calendar', () => {
  it('should handle leap year', () => {
    // ...
  });

  it('should throw when format is invalid', () => {
    // ...
  });
});
```

### 并发性
#### Prefer promises vs callbacks 宁可承诺也不要回调
回调是不干净的，它们导致大量的嵌套（回调地狱）。
有些实用程序使用回调样式将现有函数转换为返回promises的版本（对于Node.js，请参见util.promisify，对于一般用途，请参见pify，es6 promisify）

``` ts
// Bad
import { get } from 'request';
import { writeFile } from 'fs';

function downloadPage(url: string, saveTo: string, callback: (error: Error, content?: string) => void) {
  get(url, (error, response) => {
    if (error) {
      callback(error);
    } else {
      writeFile(saveTo, response.body, (error) => {
        if (error) {
          callback(error);
        } else {
          callback(null, response.body);
        }
      });
    }
  });
}

downloadPage('https://en.wikipedia.org/wiki/Robert_Cecil_Martin', 'article.html', (error, content) => {
  if (error) {
    console.error(error);
  } else {
    console.log(content);
  }
});

// Good
import { get } from 'request';
import { writeFile } from 'fs';
import { promisify } from 'util';

const write = promisify(writeFile);

function downloadPage(url: string, saveTo: string): Promise<string> {
  return get(url)
    .then(response => write(saveTo, response));
}

downloadPage('https://en.wikipedia.org/wiki/Robert_Cecil_Martin', 'article.html')
  .then(content => console.log(content))
  .catch(error => console.error(error));  
```
Promises supports a few helper methods that help make code more conscise:

Pattern	Description
Promise.resolve(value)	Convert a value into a resolved promise.
Promise.reject(error)	Convert an error into a rejected promise.
Promise.all(promises)	Returns a new promise which is fulfilled with an array of fulfillment values for the passed promises or rejects with the reason of the first promise that rejects.
Promise.race(promises)	Returns a new promise which is fulfilled/rejected with the result/error of the first settled promise from the array of passed promises.
Promise.all is especially useful when there is a need to run tasks in parallel. Promise.race makes it easier to implement things like timeouts for promises.

Promises支持一些帮助程序方法，这些方法有助于使代码更精确：
模式描述

承诺。解决（价值）将价值转换为已解决的承诺。

承诺。拒绝（错误）将错误转换为拒绝的承诺。

承诺。all（promises）返回一个新的承诺，该承诺通过一系列实现值来实现已传递的承诺，或者以拒绝的第一个承诺的原因拒绝。

Promise.race（promises）返回一个新的Promise，该Promise被实现/拒绝，结果/错误来自传递的promises数组中的第一个已确定的Promise。

Promise.all在需要并行运行任务时特别有用。Promise.race使实现承诺超时之类的事情变得更容易。

#### Async/Await 比 Promise 更干净
使用async/await语法，您可以编写比链式承诺更干净、更易于理解的代码。在以async关键字为前缀的函数中，可以告诉JavaScript运行时暂停wait关键字上的代码执行（当用于promise时）。
``` ts
// Bad
import { get } from 'request';
import { writeFile } from 'fs';
import { promisify } from 'util';

const write = util.promisify(writeFile);

function downloadPage(url: string, saveTo: string): Promise<string> {
  return get(url).then(response => write(saveTo, response));
}

downloadPage('https://en.wikipedia.org/wiki/Robert_Cecil_Martin', 'article.html')
  .then(content => console.log(content))
  .catch(error => console.error(error));  

// Good
import { get } from 'request';
import { writeFile } from 'fs';
import { promisify } from 'util';

const write = promisify(writeFile);

async function downloadPage(url: string, saveTo: string): Promise<string> {
  const response = await get(url);
  await write(saveTo, response);
  return response;
}

// somewhere in an async function
try {
  const content = await downloadPage('https://en.wikipedia.org/wiki/Robert_Cecil_Martin', 'article.html');
  console.log(content);
} catch (error) {
  console.error(error);
}
```

### 错误处理
抛出错误是件好事！它们意味着运行时已经成功地识别出程序中的某些错误，并通过停止当前堆栈上的函数执行、终止进程（在节点中）和在控制台中用堆栈跟踪通知您来通知您。

#### 总是使用错误来抛出或拒绝
JavaScript和TypeScript允许抛出任何对象。承诺也可以以任何理由拒绝。
建议对错误类型使用throw语法。这是因为用catch语法可能会在更高级别的代码中捕获错误。在那里捕捉字符串消息会非常混乱，并且会使调试更加痛苦。
出于同样的原因，您应该拒绝带有错误类型的承诺。
``` ts
// Bad
function calculateTotal(items: Item[]): number {
  throw 'Not implemented.';
}

function get(): Promise<Item[]> {
  return Promise.reject('Not implemented.');
}

// Good
function calculateTotal(items: Item[]): number {
  throw new Error('Not implemented.');
}

function get(): Promise<Item[]> {
  return Promise.reject(new Error('Not implemented.'));
}

// or equivalent to:

async function get(): Promise<Item[]> {
  throw new Error('Not implemented.');
}
```

使用错误类型的好处是它受语法try/catch/finally支持，并且隐式地说，所有错误都具有堆栈属性，这对于调试来说非常强大。
还有另一种选择，不使用throw语法，而是始终返回自定义错误对象。TypeScript使这更容易。考虑以下示例：
``` ts
type Result<R> = { isError: false, value: R };
type Failure<E> = { isError: true, error: E };
type Failable<R, E> = Result<R> | Failure<E>;

function calculateTotal(items: Item[]): Failable<number, 'empty'> {
  if (items.length === 0) {
    return { isError: true, error: 'empty' };
  }

  // ...
  return { isError: false, value: 42 };
}
```

#### 不要忽略捕获的错误
对捕获到的错误不做任何事情都不会给您修复或响应所述错误的能力。将错误记录到控制台（console.log）并没有比它在打印到控制台的大量内容中丢失更好。如果您在try/catch中包装任何一位代码，这意味着您认为可能会在那里发生错误，因此您应该有一个计划，或创建一个代码路径，以便在发生错误时使用。

``` ts
// Bad
try {
  functionThatMightThrow();
} catch (error) {
  console.log(error);
}

// or even worse

try {
  functionThatMightThrow();
} catch (error) {
  // ignore error
}

// Good
import { logger } from './logging'

try {
  functionThatMightThrow();
} catch (error) {
  logger.log(error);
}
```

#### 不要忽视被拒绝的承诺
出于同样的原因，您不应该忽略try/catch中捕获的错误。

``` ts
// Bad
getUser()
  .then((user: User) => {
    return sendEmail(user.email, 'Welcome!');
  })
  .catch((error) => {
    console.log(error);
  });

// Good
import { logger } from './logging'

getUser()
  .then((user: User) => {
    return sendEmail(user.email, 'Welcome!');
  })
  .catch((error) => {
    logger.log(error);
  });

// or using the async/await syntax:

try {
  const user = await getUser();
  await sendEmail(user.email, 'Welcome!');
} catch (error) {
  logger.log(error);
}
```

### 格式化
格式化是主观的。就像这里的许多规则一样，没有什么硬性规定是你必须遵守的。重点是不要在格式上争论。有很多工具可以自动完成这项工作。使用一个！对于工程师来说，就格式问题争论是浪费时间和金钱。要遵循的一般规则是保持格式规则的一致性。

对于TypeScript，有一个强大的工具TSLint。它是一个静态分析工具，可以帮助您显著提高代码的可读性和可维护性。您可以在项目中引用准备好使用的TSLint配置：
- TSLint Config Standard-标准样式规则
- TSLint配置Airbnb-Airbnb风格指南
- TSLint干净代码-TSLint规则灵感来自干净代码：敏捷软件工艺手册
- TSLint react-与react和JSX相关的lint规则
- TSLint+Prettier-Prettier代码格式化程序的lint规则
- TSLint的ESLint规则-TypeScript的ESLint规则
- 不可变-在TypeScript中禁用变异的规则
- 另请参阅这个伟大的TypeScript样式指南和编码约定源代码。

#### 使用一致的大写
大写告诉你很多关于你的变量，函数等。这些规则是主观的，所以你的团队可以选择他们想要的。关键是，无论你们选择什么，只要保持一致。

``` ts
// Bad
const DAYS_IN_WEEK = 7;
const daysInMonth = 30;

const songs = ['Back In Black', 'Stairway to Heaven', 'Hey Jude'];
const Artists = ['ACDC', 'Led Zeppelin', 'The Beatles'];

function eraseDatabase() {}
function restore_database() {}

type animal = { /* ... */ }
type Container = { /* ... */ }

// Good
const DAYS_IN_WEEK = 7;
const DAYS_IN_MONTH = 30;

const SONGS = ['Back In Black', 'Stairway to Heaven', 'Hey Jude'];
const ARTISTS = ['ACDC', 'Led Zeppelin', 'The Beatles'];

function eraseDatabase() {}
function restoreDatabase() {}

type Animal = { /* ... */ }
type Container = { /* ... */ }
```

更喜欢对类、接口、类型和命名空间名称使用PascalCase。
更喜欢对变量、函数和类成员使用camelCase。

#### 函数调用方和被调用方应关闭
如果一个函数调用另一个函数，请在源文件中垂直关闭这些函数。理想情况下，让呼叫者位于被呼叫者的正上方。我们倾向于自上而下阅读代码，就像报纸一样。因此，让您的代码以这种方式读取。

``` ts
// Bad
class PerformanceReview {
  constructor(private readonly employee: Employee) {
  }

  private lookupPeers() {
    return db.lookup(this.employee.id, 'peers');
  }

  private lookupManager() {
    return db.lookup(this.employee, 'manager');
  }

  private getPeerReviews() {
    const peers = this.lookupPeers();
    // ...
  }

  review() {
    this.getPeerReviews();
    this.getManagerReview();
    this.getSelfReview();

    // ...
  }

  private getManagerReview() {
    const manager = this.lookupManager();
  }

  private getSelfReview() {
    // ...
  }
}

const review = new PerformanceReview(employee);
review.review();

// Good
class PerformanceReview {
  constructor(private readonly employee: Employee) {
  }

  review() {
    this.getPeerReviews();
    this.getManagerReview();
    this.getSelfReview();

    // ...
  }

  private getPeerReviews() {
    const peers = this.lookupPeers();
    // ...
  }

  private lookupPeers() {
    return db.lookup(this.employee.id, 'peers');
  }

  private getManagerReview() {
    const manager = this.lookupManager();
  }

  private lookupManager() {
    return db.lookup(this.employee, 'manager');
  }

  private getSelfReview() {
    // ...
  }
}

const review = new PerformanceReview(employee);
review.review();
```

#### 组织导入
使用干净且易于阅读的导入语句，您可以快速查看当前代码的依赖项。请确保对导入语句应用以下良好做法：
- 导入语句应按字母顺序排列和分组。
- 应删除未使用的导入。
- 命名导入必须按字母顺序排列（即从'foo'导入{A，B，C}；）
- 导入源必须在组内按字母顺序排列，即：Import*as foo from'a'；Import*as bar from'b'；
- 导入组由空行划定。
- 集团必须遵守以下顺序：
  - - polyfill（即导入“reflect metadata”；）
  - - 节点内置模块（即从'fs'导入fs；）
  - - 外部模块（即从“itiriri”导入{query}；）
  - - 内部模块（即从'src/services/UserService'导入{UserService}；）
  - - 来自父目录的模块（即从'../foo'导入foo；从'../../foo/qx'导入qux；）
  - - 来自同一个或同级目录的模块（即从“./bar”导入bar；从“./bar/baz”导入baz）

``` ts
// Bad
import { TypeDefinition } from '../types/typeDefinition';
import { AttributeTypes } from '../model/attribute';
import { ApiCredentials, Adapters } from './common/api/authorization';
import fs from 'fs';
import { ConfigPlugin } from './plugins/config/configPlugin';
import { BindingScopeEnum, Container } from 'inversify';
import 'reflect-metadata';

// Good
import 'reflect-metadata';

import fs from 'fs';
import { BindingScopeEnum, Container } from 'inversify';

import { AttributeTypes } from '../model/attribute';
import { TypeDefinition } from '../types/typeDefinition';

import { ApiCredentials, Adapters } from './common/api/authorization';
import { ConfigPlugin } from './plugins/config/configPlugin';
```

#### 使用类型脚本别名
通过在tsconfig.json的compileoptions部分中定义路径和baseUrl属性创建更漂亮的导入
这将避免在进行导入时使用长的相对路径。

``` ts
// Bad
import { UserService } from '../../../services/UserService';

// Good
import { UserService } from '@services/UserService';

// tsconfig.json
...
  "compilerOptions": {
    ...
    "baseUrl": "src",
    "paths": {
      "@services": ["services/*"]
    }
    ...
  }
...
```

### 评论
使用评论意味着没有评论就无法表达。代码应该是真相的唯一来源。
不要评论坏代码重写它。
-布莱恩·W·克尼根和P·J·普劳格
#### 更喜欢自解释的代码而不是注释
评论是道歉，不是要求。好的代码大多是文档本身。

``` ts
// Bad
// Check if subscription is active.
if (subscription.endDate > Date.now) {  }

// Good
const isSubscriptionActive = subscription.endDate > Date.now;
if (isSubscriptionActive) { /* ... */ }
```

#### 不要在代码库中遗漏注释掉的代码
版本控制存在是有原因的。在你的历史中留下旧代码。

``` ts
// Bad
type User = {
  name: string;
  email: string;
  // age: number;
  // jobPosition: string;
}

// Good
type User = {
  name: string;
  email: string;
}
```

#### 没有日志评论
记住，使用版本控制！不需要死代码、注释代码，尤其是日志注释。使用git日志获取历史记录！

``` ts
// Bad
/**
 * 2016-12-20: Removed monads, didn't understand them (RM)
 * 2016-10-01: Improved using special monads (JP)
 * 2016-02-03: Added type-checking (LI)
 * 2015-03-14: Implemented combine (JR)
 */
function combine(a: number, b: number): number {
  return a + b;
}

// Good
function combine(a: number, b: number): number {
  return a + b;
}
```

#### 避免位置标记
它们通常只是增加噪音。让函数和变量名以及适当的缩进和格式为代码提供可视化结构。
大多数IDE支持代码折叠功能，允许您折叠/扩展代码块（请参见Visual Studio代码折叠区域）。

``` ts
// Bad
////////////////////////////////////////////////////////////////////////////////
// Client class
////////////////////////////////////////////////////////////////////////////////
class Client {
  id: number;
  name: string;
  address: Address;
  contact: Contact;

  ////////////////////////////////////////////////////////////////////////////////
  // public methods
  ////////////////////////////////////////////////////////////////////////////////
  public describe(): string {
    // ...
  }

  ////////////////////////////////////////////////////////////////////////////////
  // private methods
  ////////////////////////////////////////////////////////////////////////////////
  private describeAddress(): string {
    // ...
  }

  private describeContact(): string {
    // ...
  }
};

// Good
class Client {
  id: number;
  name: string;
  address: Address;
  contact: Contact;

  public describe(): string {
    // ...
  }

  private describeAddress(): string {
    // ...
  }

  private describeContact(): string {
    // ...
  }
};
```

#### 待办事项注释
当您发现需要在代码中留下注释以便以后进行一些改进时，可以使用//to do注释来完成。大多数IDE对这些注释都有特殊的支持，因此您可以快速浏览todo的整个列表。
不过，请记住，TODO注释不是错误代码的借口。


``` ts
// Bad
function getActiveSubscriptions(): Promise<Subscription[]> {
  // ensure `dueDate` is indexed.
  return db.subscriptions.find({ dueDate: { $lte: new Date() } });
}

// Good
function getActiveSubscriptions(): Promise<Subscription[]> {
  // TODO: ensure `dueDate` is indexed.
  return db.subscriptions.find({ dueDate: { $lte: new Date() } });
}
```



``` ts
// Bad


// Good

```



``` ts
// Bad


// Good

```



``` ts
// Bad


// Good

```



``` ts
// Bad


// Good

```



``` ts
// Bad


// Good

```


``` ts
// Bad


// Good

```


