#!/bin/sh

set -e -x

cd /usr/src/app/info/
cp /tmp/site/package.json .

pnpm install

cp -r /tmp/site/* .

exec pnpm start