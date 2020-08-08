---
title: editor
date: 2020-08-05 17:20:05
caregories:
- work
tags:
- TypeScript
- Angular
---

# electron
## use
https://github.com/KilFront/electron-app

## electron&&angular
https://github.com/KilFront/electron-app/tree/angular

# angular

# primeNG
[praɪm]
angular UI 框架

## dialog
对话框
dynamic  [daɪˈnæmɪk] 动态
### 打开对话框
``` ts
import { DialogService } from "primeng/dynamicdialog";
providers: [DialogService],
this.dialogService.open(GameVersionListComponent, {
  header: `${this.game.name}-历史版本`,
  width: "550px",
  style: { top: "30%" },
  data: {
    game: this.game,
  },
});
```

### 对话框传值
``` ts
import { DynamicDialogConfig, DynamicDialogRef } from "primeng/dynamicdialog";
private ref: DynamicDialogRef,
this.ref.close(1);
```
