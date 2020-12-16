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

```



