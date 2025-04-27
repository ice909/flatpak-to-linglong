#!/bin/bash

set -x

APP_ID=$1
VERSION=$2
if [[ $# -lt 2 ]]; then
  echo "usage: $0 <APP_ID> <version>"
  exit 1
fi

# 获取${APP_ID}/layer下面的layer文件
layer_file=$(ls ${APP_ID}/layer 2>/dev/null)
if [[ -z "$layer_file" ]]; then
  echo "No layer file found in ${APP_ID}/layer"
  exit -1
fi

echo 1 | sudo -S ll-cli repo set-default old || true

echo 1 | sudo -S ll-cli install "./${APP_ID}/layer/${layer_file}" || true


export DISPLAY=:1 && ll-cli run "$APP_ID" &

sleep 5

ps_output=$(ll-cli ps | tail -n+2 | awk '{print $1}')

if echo "$ps_output" | grep "$APP_ID" > /dev/null; then
  ll-cli kill "$APP_ID"
  sudo ll-cli uninstall "$APP_ID"
  sudo ll-cli prune
else
  echo "failed: $APP_ID $VERSION no running (no match APP_ID)"
  sudo ll-cli uninstall "$APP_ID"
  sudo ll-cli prune
  exit -1
fi
