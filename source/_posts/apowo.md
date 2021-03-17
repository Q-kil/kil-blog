---
title: apowo
date: 2020-06-22 13:46:28
tags:
---

# platform-client
## pkt
http://xyqh5.163.com/
https://xyh5.163.com/game/?channel=netease&bg=false

width: 56.25vh;
height: 100vh;

``` js
function setLaunch() {
  var e = document.getElementById("launch");
  if (e) {
    var n = document.documentElement
      , o = e.clientWidth
      , r = e.clientHeight
      , t = n.getBoundingClientRect()
      , i = t.width
      , a = t.height;
    o > i && (e.style.width = i + "px"),
    r != a && (e.style.height = a + "px")
  }
}
```

## ci
``` yaml

stages:
- deploy
- deploy_dev
- deploy_remote_dev
- merge_build_test

#cache:
#  key: "$CI_COMMIT_REF_SLUG"
#  paths:
#  - node_modules/


variables:
  GIT_STRATEGY: clone
  GIT_SUBMODULE_STRATEGY: recursive

BuildAndDeployToServer:
  stage: deploy
  only:
  - /^release-.*$/
  tags:
  - prod-platform-delivery
  script:
  - ansible-playbook $CI_PROJECT_DIR/playbooks/platform_site.yml -b -i $CI_PROJECT_DIR/playbooks/inventory/platform_hosts --extra-vars "project_dist_path=$CI_PROJECT_DIR/../platform_client_dist/" --limit "platform_client"


BuildForMergeMasterTest:
  stage: merge_build_test
  only:
  - merge_requests
  except:
    variables:
      - $CI_MERGE_REQUEST_TARGET_BRANCH_NAME != "master"
  tags:
    - prod-platform-delivery
  script:
    - yarn install
    - yarn deploy:prod
    - mkdir -p ../platform_client_dist && cp -r dist/* ../platform_client_dist/


BuildAndDeployToLocalServer:
  stage: deploy_dev
  only:
    - /^beta-.*$/
  except:
    - /^release-.*$/
  tags:
  - pve-ubuntu-test-runner
  script:
  - yarn install
  - yarn deploy:dev
  - ansible-playbook $CI_PROJECT_DIR/playbooks/platform_site.yml -b -i $CI_PROJECT_DIR/playbooks/inventory/platform_hosts --extra-vars "project_dist_path=$CI_PROJECT_DIR/dist/" --limit "platform_client_test"

BuildAndDeployToRemoteDevServer:
  stage: deploy_remote_dev
  only:
    - /^remote-dev-.*$/
  tags:
    - prod-platform-delivery
  script:
    - yarn install
    - yarn deploy:alpha
    - ansible-playbook $CI_PROJECT_DIR/playbooks/platform_site.yml -b -i $CI_PROJECT_DIR/playbooks/inventory/platform_hosts --extra-vars "project_dist_path=$CI_PROJECT_DIR/dist/" --limit "platform_client_dev"
```

# tooqing-webapp


# APP
## 解决异形屏适配问题（全屏模式下显示）

## 判断cordova or web-browser
cordova
<preference name="AppendUserAgent" value="Cordova" />

app
const isCordova = navigator.userAgent.match(/Cordova/i);

## 异形屏
### 刘海高度
小米
getDisplayCutout success Objectbottom: 0left: 0right: 0top: 28.952381134033203
Object 28.952381134033203

三星
getDisplayCutout success Object 36.3636360168457

华为
getDisplayCutout success {left: 0, top: 24, right: 0, bottom: 0} 24

# 用到的库
## vue-infinite-loading

## qiniu-js
### upload
返回
total: 包含loaded、total、percent三个属性:
total.loaded: number，已上传大小，单位为字节。
total.total: number，本次上传的总量控制信息，单位为字节，注意这里的 total 跟文件大小并不一致。
total.percent: number，当前上传进度，范围：0～100。