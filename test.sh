#!/bin/bash

set -x

APP_ID=$1

SMALLER_APPID=$(echo $APP_ID | tr '[:upper:]' '[:lower:]')
if [[ $# -lt 1 ]]; then
  echo "usage: $0 <APP_ID>"
  exit 1
fi

# 获取${APP_ID}/layer下面的layer文件
layer_file=(${APP_ID}/layer/*.layer)
if [[ -z "$layer_file" ]]; then
  echo "No layer file found in ${APP_ID}/layer"
  exit -1
fi

sudo ll-cli repo set-default dev || true

sudo ll-cli install "./${layer_file[0]}" || true


ll-cli run "$SMALLER_APPID" &

sleep 5

ps_output=$(ll-cli ps | tail -n+2 | awk '{print $1}')

if echo "$ps_output" | grep "$SMALLER_APPID" > /dev/null; then
  ll-cli kill -s9 "$SMALLER_APPID"
  sudo ll-cli uninstall "$SMALLER_APPID"
  sudo ll-cli prune
else
  echo "failed: $SMALLER_APPID no running (no match APP_ID)"
  sudo ll-cli uninstall "$SMALLER_APPID"
  sudo ll-cli prune
  exit -1
fi
