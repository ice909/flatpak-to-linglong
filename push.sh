#!/bin/bash

set -xe

REPO_URL=$1
REPO_NAME=$2

# 获取${APP_ID}/layer下面的layer文件
layer_file=(${APP_ID}/layer/*.layer)
if [[ -z "$layer_file" ]]; then
  echo "No layer file found in ${APP_ID}/layer"
  exit -1
fi

linglong-tools push -f "${layer_file[0]}" -r "$REPO_URL" -n "$REPO_NAME"
