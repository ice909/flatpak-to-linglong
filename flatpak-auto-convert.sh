#!/bin/bash

set -x

# 检查是否传入 APP_ID 和 version 参数
if [[ $# -lt 2 ]]; then
  echo "usage: $0 <APP_ID> <version>"
  exit 1
fi

# 读取传入的参数
APP_ID=$1
VERSION=$2

# 清理builder 缓存
rm -rf ~/.cache/linglong-builder || true

# 执行 ll-builder build
ll-builder repo add old https://repo-dev.cicd.getdeepin.org || true
ll-builder repo set-default old || true
ll-builder build
if [[ $? -ne 0 ]]; then
  echo "failed: ll-builder build $APP_ID $VERSION failed"
  exit -1
fi

# 导出layer
ll-builder export --layer --no-develop

mkdir -p ./layer || true

# 将导出的 layer 移动到 ./layer 目录
mv ./*.layer ./layer/ || true
