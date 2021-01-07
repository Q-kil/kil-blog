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

# idea
## 画布鼠标
1、点击物件时，更新选择工具
this.updateSelectedTool(ToolBtnsEvent.BRUSH);


# data
``` ts
export default class Metadata {
  private _id: number = Helpers.genId();
  private _name: string;
  private _parent: number = 0;
  private _sn: string = "";
  private _version: string = "1";
  private _is_moss?: boolean;
  protected _type = 0;
  protected _cap: Capsule;
}  
```

# code
## 会员对应特权
``` ts
// 普通，基础，经典，进阶，专业
export const MaxituanBenefitsConfig = {
  GAME_TEMPLATES: [["图形化聊天室", "空白世界"], null, null, null, null],
  CREATE_SCENE_NUMBER: [3, 10, 20, 30, null],
  SCENE_SIZE: [
    [30, 30],
    [30, 30],
    [50, 50],
    [100, 100],
    [200, 200],
  ], // 场景尺寸
  CAN_SAVE_GAME: [false, true, true, true, true], // 允许保存游戏
  GAME_PUBLISHED_NUMBER: [1, 3, 5, 8, null], // 游戏发布
  AVATAR_PUT_ON_SHELF_NUMBER: [0, 0, 0, 200, null], // 装扮上架
};

public get userMaxituanBenefits() {
  let benefit = {};
  if (this.currentUser.maxituan_card && this.currentUser.maxituan_card.source_target_entity) {
    const vipLevel = this.currentUser.maxituan_card.source_target_entity.vip_level || 0;
    for (const key of Object.keys(MaxituanBenefitsConfig)) {
      benefit[key] = MaxituanBenefitsConfig[key][vipLevel];
    }
  } else {
    for (const key of Object.keys(MaxituanBenefitsConfig)) {
      benefit[key] = MaxituanBenefitsConfig[key][0];
    }
  }

  return benefit;
}

public hasPermission(benefitType: MaxituanBenefits, checkData: any) {
  const benefit = this.userMaxituanBenefits[benefitType];
  if (benefit === undefined) {
    return false;
  }
  switch (benefitType) {
    case MaxituanBenefits.GAME_TEMPLATES:
      if (benefit === null) {
        return true;
      }
      if (benefit.indexOf(checkData) < 0) {
        return false;
      } else {
        return true;
      }
    case MaxituanBenefits.SCENE_SIZE:
      const [width, height] = benefit;
      const [w, h] = checkData;
      if (w > width || h > height) {
        return false;
      } else {
        return true;
      }
    case MaxituanBenefits.CREATE_SCENE_NUMBER:
      if (benefit === null) {
        return true;
      }
      if (benefit <= checkData) {
        return false;
      } else {
        return true;
      }
    case MaxituanBenefits.GAME_PUBLISHED_NUMBER:
      if (benefit === null) {
        return true;
      }
      if (benefit <= checkData) {
        return false;
      } else {
        return true;
      }
    case MaxituanBenefits.AVATAR_PUT_ON_SHELF_NUMBER:
      if (benefit === null) {
        return true;
      }
      if (benefit <= checkData) {
        return false;
      } else {
        return true;
      }
  }
}
```

## 类封装
``` ts
export class Game implements IGame {
  _id: string;
  serverStatus: number;
  cover: string; // 封面图
  tags: string[];
  visibility: Visibility;
  template: boolean = true;
  thumbnails: string[];
  version: string; // 当前运行的发布版本
  lastVersion: string; // 最后修改版本
  liked_count: number;
  unliked_count: number;
  recommendedLevel: number;
  owner: Partial<User>;
  name: string = "空白游戏";
  description: string;
  createdAt?: string;
  updatedAt?: string;
  releaseVersions: GameVersion[];
  pastVersions: GameVersion[];
  visitsUpdateAt: string;
  positiveRateUpdateAt: string;
  incomeTuDingUpdateAt: string;

  forkedGame?: string;
  forkedGameVer?: string;

  constructor(data?: Partial<Game>) {
    Object.assign(this, data);
  }

  public get gameCover() {
    return this.cover
      ? url.resolve(WEB_HOME_PATH, this.cover)
      : "./assets/images/ui/empty_template_thumb.png";
  }
}  
```
