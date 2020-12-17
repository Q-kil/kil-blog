---
title: js-function
date: 2020-12-14 10:16:08
categories:
- JavaScript
tags:
- js-function
---

# function
## 复制到粘贴板
``` js
copy() {
  const input = document.createElement('input');
  document.body.appendChild(input);
  input.setAttribute('value', this.avatar._id);
  input.select();
  if (document.execCommand('copy')) {
    document.execCommand("copy");
    this.toastService.success("成功复制SN到粘贴板！");
  }
  document.body.removeChild(input);
}
```

## 下载图片资源
``` js
import * as JSZip from "jszip";
import * as FileSaver from "file-saver";
async getUrlBase64(urlRemote, ext) {
    return new Promise((resolve, reject) => {
        let canvas = document.createElement("canvas");
        let ctx = canvas.getContext("2d"); // 方法返回canvas 的上下文
        let img = new Image();
        img.crossOrigin = "Anonymous"; // 跨域
        img.src = urlRemote;
        img.onload = () => {
            canvas.width = img.width;
            canvas.height = img.height;
            ctx.drawImage(img, 0, 0); // 在Canvas上绘制图像。
            let dataURL = canvas.toDataURL("image/" + ext); // 返回一个包含图片展示的 data URI 。
            resolve(dataURL);
            canvas = null;
        };
    });
  }
  async exportZip(urls) {
      const imgList = urls;
      const proList = [];
      const zip = new JSZip();
      const cache = {};
      await imgList.forEach(item => { // 等待所有图片转换完成
          const pro = this.getUrlBase64(item, ".png").then((base64: any) => {
              const fileName = item.replace(/(.*\/)*([^.]+)/i, "$2");
              zip.file(fileName, base64.substring(base64.indexOf(",") + 1), {
                  base64: true
              });
              cache[fileName] = base64;
          });
          proList.push(pro);
      });
      Promise.all(proList).then(res => {
          zip.generateAsync({
              type: "blob"
          }).then(content => { // 生成二进制流
            FileSaver(content, `${this.avatar._id}.zip`); // 利用file-saver保存文件
            this.toastService.success("资源下载成功");
          });
      });
  }
```



