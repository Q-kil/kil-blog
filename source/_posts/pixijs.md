---
title: pixijs
date: 2020-05-29 10:18:32
categories:
- Frame
tags:
- Pixijs
---

why
图轻avatar 渲染使用了 pixijs
移动端我的装扮页和商场页使用了同一个组件，两个页面切换时，pixijs渲染异常
# 教程
[官方教程](https://github.com/Zainking/learningPixi)
### 创建Pixi应用 和 舞台
``` js
//Create a Pixi Application
let app = new PIXI.Application({width: 256, height: 256});

//Add the canvas that Pixi automatically created for you to the HTML document
document.body.appendChild(app.view);
```

使用Canvas引擎绘制
forceCanvas: true,

改变背景色
设置 app.renderer对象的backgroundColor属性为一个任何的十六进制颜色
``` js
app.renderer.backgroundColor = 0x061639;
```

改变画布大小
``` js
app.renderer.autoResize = true;
app.renderer.resize(512, 512);
```

全屏
``` js
app.renderer.view.style.position = "absolute";
app.renderer.view.style.display = "block";
app.renderer.autoResize = true;
app.renderer.resize(window.innerWidth, window.innerHeight);
```

``` css
* {padding: 0; margin: 0}
```

### Pixi精灵
创建了画布，可以放图像了
如果想在画布上显示东西，必须被加进一个`stage 舞台` 的Pixi对象中。使用舞台对象
``` js
app.stage
```

所以你可以放些什么到舞台上呢？那就是被称作 精灵 的特殊图像对象。精灵是你能用代码控制图像的基础。你能够控制他们的位置，大小，和许多其他有用的属性来产生交互和动画。学习怎样创建和控制精灵是学习Pixi最重要的部分。如果你知道怎么创建精灵和把他们添加进舞台，离做出一个游戏就仅仅剩下一步之遥！

### 将图片加载到纹理缓存中
可以被GPU处理的图像被称作 纹理 
在你让精灵显示图片之前，需要将普通的图片转化成WebGL纹理。
为了让所有工作执行的快速有效率，Pixi使用 纹理缓存 来存储和引用所有你的精灵需要的纹理。

纹理被以WEBGL兼容的格式存储起来，它可以使Pixi的渲染有效率的进行。你现在可以使用Pixi的`Sprite`类来创建一个新的精灵，让它使用纹理。
``` js
let texture = PIXI.utils.TextureCache["images/anySpriteImage.png"];
let sprite = new PIXI.Sprite(texture);
```

怎么加载图像并将它转化成纹理？答案是用Pixi已经构建好的loader对象。
``` js
//Create a Pixi Application
let app = new PIXI.Application({
    width: 256,
    height: 256,                       
    antialias: true,
    transparent: false,
    resolution: 1
  }
);

//Add the canvas that Pixi automatically created for you to the HTML document
document.body.appendChild(app.view);

//load an image and run the `setup` function when it's done
PIXI.loader
  .add("images/cat.png")
  .load(setup);

//This `setup` function will run when the image has loaded
function setup() {

  //Create the cat sprite
  let cat = new PIXI.Sprite(PIXI.loader.resources["images/cat.png"].texture);

  //Add the cat to the stage
  app.stage.addChild(cat);
}
```

把一个精灵从舞台上挪走，就可以使用removeChild方法：
``` js
app.stage.removeChild(anySprite)
```

通常，我们都把精灵的visible属性设置成false来让精灵简单的隐藏。
``` js
anySprite.visible = false;
```

### 关于加载的其他知识
##### 使用普通的javaScript Img对象或canvas创建一个精灵
需要从JavaScript的Image对象之中创建，你可以使用Pixi的BaseTexture和Texture类：
``` js
let base = new PIXI.BaseTexture(anyImageObject),
    texture = new PIXI.Texture(base),
    sprite = new PIXI.Sprite(texture);
```

##### 监视加载进程
``` js
PIXI.loader
  .add([
    "images/one.png",
    "images/two.png",
    "images/three.png"
  ])
  .on("progress", loadProgressHandler)
  .load(setup);

function loadProgressHandler() {
  console.log("loading");
}
```

哪个文件被加载了以及有百分之多少的文件被加载了
``` js
function LoadProgressHandler(loader, resource) {
  console.log('loading');

  //Display the file `url` currently being loaded
  console.log("loading: " + resource.url);

  //Display the percentage of files currently loaded
  console.log("progress: " + loader.progress + "%");

  //If you gave your files names as the first argument
  //of the `add` method, you can access them like this
  //console.log("loading: " + resource.name);
}

loading: ./images/eyes.png
pixi.html:57 progress: 50%
pixi.html:51 loading
pixi.html:54 loading: ./images/hair.png
pixi.html:57 progress: 100%
```

### 精灵位置
定位他们的位置和改变他们的大小
``` js
function setup() {
  const sprite = new PIXI.Sprite(
    PIXI.loader.resources["./images/eyes.png"].texture
  );
  // spriteCopy = sprite;
  sprite.x = 96;
  sprite.y = 96;

  // 一句话设置
  sprite.position.set(96, 96);
  app.stage.addChild(sprite);
}
```

### 大小和比例
``` js
function setup() {

  //Create the `cat` sprite
  let cat = new Sprite(resources["images/cat.png"].texture);

  //Change the sprite's size
  cat.width = 80;
  cat.height = 120;

  //Add the cat to the stage so you can see it
  app.stage.addChild(cat);
}
```

精灵都有scale.x 和 scale.y属性，他们可以成比例的改变精灵的宽高
``` js
cat.scale.x = 0.5;
cat.scale.y = 0.5;
```

### 旋转
``` js
cat.rotation = 0.5;
```

设置中心点
anchor.x和anchor.y的值如果是从0到1，就会被认为是整个纹理的长度或宽度百分比。设置他们都为0.5，锚点就处在了图像中心。
``` js
cat.anchor.x = 0.5;
cat.anchor.y = 0.5;

// 在一行内设置
cat.anchor.set(x, y)
```

### 雪碧图
``` js
 function setup() {
  let texture = PIXI.utils.TextureCache["./images/like_unlike.png"];

  // let rectangle = new Rectangle(0, 0, 34, 34);
  let rectangle = new PIXI.Rectangle(0, 0, 34, 34);
  texture.frame = rectangle;

  let rocket = new PIXI.Sprite(texture);

  rocket.x = 32;
  rocket.y = 32;

  app.stage.addChild(rocket);
}
```

### 移动精灵
使用Pixi的ticker。这被称为 游戏循环 。任何在游戏循环里的代码都会1秒更新60次。你可以用下面的代码让 cat 精灵以每帧1像素的速率移动。
``` js
function setup() {

  //Start the game loop by adding the `gameLoop` function to
  //Pixi's `ticker` and providing it with a `delta` argument.
  app.ticker.add(delta => gameLoop(delta));
}

function gameLoop(delta){

  //Move the cat 1 pixel
  cat.x += 1;
}
```


