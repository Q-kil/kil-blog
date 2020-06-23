#!/bin/bash

echo 'git auto push start...'
# msg=$1
git add .
# git commit -m "${$1}"
git commit -m 'update'
# echo 'git 提交注释:$1'
git pull origin master
git push origin master
echo 'git auto push end...'