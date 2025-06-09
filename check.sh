#!/bin/bash

set -xe

REPO_URL=$1
REPO_NAME=$2
APP_ID=$3
VERSION=$4

# 将APP_ID转换为小写
APP_ID=$(echo "$APP_ID" | tr '[:upper:]' '[:lower:]')

# 检查仓库是否已存在相同版本的应用
result=$(linglong-tools search -i "$APP_ID" -v "$VERSION" -r "$REPO_URL" -n "$REPO_NAME" | jq '. | length')

if [ "$result" -eq 0 ]; then
    echo "app $APP_ID version $VERSION not found, proceeding with push operation"
    exit 0  # 返回成功状态码
else
    echo "::warning::app $APP_ID version $VERSION already exists in repository $REPO_NAME, skipping push operation"
    exit 1  # 返回错误状态码
fi