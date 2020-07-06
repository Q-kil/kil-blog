#!/bin/bash

echo 'git auto push start...'
# msg=$1
git add .
git commit -m "${0:=update}"
# git pull origin master
git push origin master
echo 'git auto push end...'