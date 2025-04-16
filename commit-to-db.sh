#!/bin/bash

set -x

URL=$1
APP_ID=$2
VERSION=$3

if [[ $# -lt 3 ]]; then
  echo "usage: $0 <URL> <APP_ID> <version>"
  exit 1
fi
echo "{\"app_id\": \"$APP_ID\", \"version\": \"$VERSION\"}"
curl --location --request POST "http://$URL/insert" \
--header 'Content-Type: application/json' \
--header 'Accept: */*' \
--header 'Host: 10.20.33.65:3000' \
--header 'Connection: keep-alive' \
--data-raw "{\"app_id\": \"$APP_ID\", \"version\": \"$VERSION\"}"