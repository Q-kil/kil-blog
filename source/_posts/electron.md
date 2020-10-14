---
title: electron
date: 2020-09-17 17:19:29
caregories:
- Hybrid
tags:
- Electron
---

# basic

# MacOS
## 问题
### 复制功能
main.js
``` js
if (serve) {
  win.webContents.openDevTools();
}

// globaShortcut wil be rewrote by another electron app, just use menu accelerator for each app
globalShortcut.register("Ctrl+Shift+I", () => {
  win.webContents.openDevTools();
});

// MacOS
if (process.platform === "darwin") {
  const template = [
    {
      label: "Application",
      submenu: [
        { label: "Quit", accelerator: "Command+Q", click: () => app.quit()}
      ]
    },
    {
      label: "Edit",
      submenu: [
        { label: "Copy", accelerator: "CmdOrCtrl+C", selector: "copy:" },
        { label: "Paste", accelerator: "CmdOrCtrl+V", selector: "paste:" },
        { label: "Select All", accelerator: "CmdOrCtrl+A", selector: "selectAll:" }
      ]
    }
  ];
  Menu.setApplicationMenu(Menu.buildFromTemplate(template));
} else {
  Menu.setApplicationMenu(null);
}
```

### electron 安装失败
``` zsh
> electron@8.2.1 postinstall /usr/local/lib/node_modules/electron
> node install.js

(node:6406) UnhandledPromiseRejectionWarning: HTTPError: Response code 404 (Not Found) for http://npm.taobao.org/mirrors/electron/9.1.0/electron-v8.2.1-darwin-x64.zip
```

解决：
I solved the problem, if you're using taobao mirror, you should config like this in your `~/.npmrc` file:
```
electron_mirror=https://npm.taobao.org/mirrors/electron/
electron_custom_dir=7.0.0
```