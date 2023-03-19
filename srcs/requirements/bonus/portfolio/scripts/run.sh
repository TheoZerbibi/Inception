#!/bin/sh

set -e -x

cd /var/www/portfolio

cp -r /tmp/site/* .
npm i express

exec node app.js