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

## 动画
elementNode -> animations -> animationData[] 

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

## HostListener
``` ts
import { HostListener } from "@angular/core"

  @HostListener("mouseover", ["$event"])
  mouseover(event: KeyboardEvent) {
    if ((event.srcElement as any).localName === "input") {
      return;
    }
    switch (this.editorService.selectedTool) {
      case ToolBtnsEvent.MOVE:
        document.body.style.cursor = "url('assets/icon/cursor-move.png'), auto";
        break;
      case ToolBtnsEvent.SELECT:
        document.body.style.cursor = "url('assets/icon/cursor-select.png'), auto";
        break;
      case ToolBtnsEvent.BRUSH:
        document.body.style.cursor = "url('assets/icon/cursor-draw.png'), auto";
        break;
      case ToolBtnsEvent.ERASER:
        document.body.style.cursor = "url('assets/icon/cursor-eraser.png'), auto";
        break;
      case ToolBtnsEvent.GRABID:
        document.body.style.cursor = "grab";
        break;
    }
  }

  @HostListener("mouseout", ["$event"])
  mouseout(event: KeyboardEvent) {
    if ((event.srcElement as any).localName === "input") {
      return;
    }
    document.body.style.cursor = "default";
  }
```  

## 修改名字
``` html
<div>
  <ng-container *ngIf="isEditor; else editName">
    <input
      class="name-input"
      type="text"
      [(ngModel)]="elementEditorService.elementNode.name"
      (keyup.enter)="onChangeName()"
    />
    <i class="pi pi-check" (click)="onChangeName()"></i>
    <i class="pi pi-times" (click)="isEditor = false"></i>
  </ng-container>
  <ng-template #editName>
    <span>{{ elementEditorService.elementNode.name }}</span>
    <i class="pi pi-fw pi-pencil" (click)="isEditor = true"></i>
  </ng-template>
</div>
```

## 保存物件
``` ts
case ToolBtnsEvent.SAVEELEMENT:
  // 确定版本号
  const version = this.elementEditorService.currentVersion
    ? this.elementEditorService.currentVersion.version
    : "0";

  const nextversion = (parseInt(version, 10) + 1).toString();

  this.elementEditorService
    .saveElement()
    .then(() => {
      return this.componentService.uploadComponentResource(
        this.elementEditorService.component,
        nextversion
      );
    })
    .then(() => {
      const newComponentResource = scanFolderSync(
        CommonUtils.genComponentFoler(this.elementEditorService.component, nextversion),
        false
      );
      return this.componentService
        .updateComponentVersion(this.elementEditorService.component.id, {
          version: {
            version: nextversion,
            resources: newComponentResource,
          },
        })
        .toPromise();
    })
    .then(() => {
      return this.componentService
        .getComponent(this.elementEditorService.component.id)
        .toPromise();
    })
    .then((res) => {
      this.elementEditorService.component = (res as any).data;
      this.componentService.setComponentListUpdate("MINE_ELEMENTNODE");
      this.globalMessage.add("保存物件成功");
    });
  break;


  public saveElement() {
    let tasks: Promise<any>[] = [];

    // 返回：haitun/ElementNode/5ff949810f8edd1155ebe347/1
    const currentVersionPath = this.getCurrentVersionPath();

    // 必须有新版本，否则七牛会有缓存问题，导致不能使用到最新版的物件

    const nextVersionPath = this.getNextVersionPath();
    const targetDisplayTextureFile = `${nextVersionPath}/${this.component.id}.png`;
    const targetDisplayDataFile = `${nextVersionPath}/${this.component.id}.json`;

    // 版本下所有文件路径
    const files = scanFolderSync(path.join(LOCAL_HOME_PATH, currentVersionPath));

    for (const file of files) {
      if (T_LUA_REGEX.test(file)) {
        const outputFilePath = path.posix.join(
          LOCAL_HOME_PATH,
          nextVersionPath,
          "scripts",
          // 返回 path 的最后一部分; 文件.html
          path.basename(file)
        );
        fsa.ensureFileSync(outputFilePath);
        tasks.push(copyFile(file, outputFilePath));
      } else {
        const outputFilePath = path.join(LOCAL_HOME_PATH, nextVersionPath, path.basename(file));
        fsa.ensureFileSync(outputFilePath);
        tasks.push(copyFile(file, outputFilePath));
      }
    }

    tasks.push(this.saveThumb());

    this.elementNode.animations.display.texturePath = targetDisplayTextureFile;
    this.elementNode.animations.display.dataPath = targetDisplayDataFile;

    // 序列化
    const elementBuffer = this.elementConfig.serialize();
    const configPath = `${nextVersionPath}/${this.component.id}.pi`;
    tasks.push(saveFile(path.posix.join(LOCAL_HOME_PATH, configPath), elementBuffer));

    return Promise.all(tasks);
  }

  private getCurrentVersionPath() {
    // 数据库上的version || 默认
    const currentVersion = this.component.currentVersion ||
      _.last(this.component.versions) || { version: "1" };

    return path.posix.join(
      this.component.owner.username,
      this.component.type,
      this.component.id,
      currentVersion.version
    );
  }

  private getNextVersionPath() {
    const currentVersion = this.component.currentVersion ||
      _.last(this.component.versions) || { version: "0" };

    const nextversion = (parseInt(currentVersion.version, 10) + 1).toString();
    return path.posix.join(
      this.component.owner.username,
      this.component.type,
      this.component.id,
      nextversion
    );
  }

  // 存疑：递归使用同一变量{files}，有引发死循环的可能
  export function scanFolderSync(targetPath: string, absolute: boolean = true): string[] {
    let files = [];

    function _scanFolder(folderPath: string) {
      // 读取目录的内容
      // 返回：fileNameArray [ 'dir', 'test.js', 'test.ts' ]
      let fileNameArray = fs.readdirSync(folderPath);
      for (let fn of fileNameArray) {
        let fullPath = path.posix.join(folderPath, fn);
        let fileStats = fs.statSync(fullPath);
        if (fileStats.isFile()) {
          files.push(fullPath);
        } else {
          files = files.concat(_scanFolder(fullPath));
        }
      }
      return files;
    }

    _scanFolder(targetPath);

    if (absolute) {
      return files;
    } else {
      return files.map((file) => file.split(`${LOCAL_HOME_PATH}/`)[1]);
    }
  }
```

## css
### 继承
``` scss
.pixel-after {
  content: "";
  position: absolute;
  top: 0;
  left: 0;
  height: 100%;
  width: 100%;
}

.pixel-toolbar-save::after {
  @extend .pixel-after;
  background: url("~assets/icon/toolbar-save.svg") center center;
  background-size: 100%;
}
```
