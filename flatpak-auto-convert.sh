#!/bin/bash

# 检查是否传入 APP_ID 和 version 参数
if [[ $# -lt 2 ]]; then
  echo "usage: $0 <APP_ID> <version>"
  exit 1
fi

# 读取传入的参数
APP_ID=$1
VERSION=$2

# 定义成功和失败文件
failed_file="failed_list"
success_file="success_list"

# 执行 ll-builder build
ll-builder build --skip-pull-depend
if [[ $? -ne 0 ]]; then
  echo "failed: ll-builder build $APP_ID $VERSION failed"
  echo "$APP_ID $VERSION" >> "$failed_file"
  exit -1
fi

# 设置环境变量并运行 ll-builder
export LINGLONG_DEBUG=1 WAYLAND_DISPLAY=wayland-0 DISPLAY=:0
ll-builder run &

# 等待运行
sleep 5

# 检查运行中的进程
ps_output=$(ll-box list | tail -n+2 | awk '{print $1}')

if echo "$ps_output" | grep "$APP_ID" > /dev/null; then
  echo "$APP_ID $VERSION" >> "$success_file"
  echo "success: $APP_ID $VERSION save to $success_file"
  ll-box kill "$ps_output"
else
  echo "failed: $APP_ID $VERSION no running（no match APP_ID）"
  echo "$APP_ID" >> "$failed_file"
  exit -1
fi
