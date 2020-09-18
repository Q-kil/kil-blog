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