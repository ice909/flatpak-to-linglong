#!/bin/bash

set -x

# 执行 ll-builder build
ll-builder repo add old https://repo-dev.cicd.getdeepin.org || true
ll-builder repo set-default old || true
ll-builder build --skip-strip-symbols --skip-output-check
if [[ $? -ne 0 ]]; then
  echo "failed: ll-builder build failed"
  exit -1
fi

# 导出layer
ll-builder export --layer

mkdir -p ./layer || true

# 将导出的 layer 移动到 ./layer 目录
mv ./*.layer ./layer/ || true
