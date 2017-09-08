#!/bin/bash

mvn clean package

mkdir server

mv */target/*-allinone.jar server/

cd server

rename 's/-[^.*]*(?=\.jar)//' *.*

python -m SimpleHTTPServer &

cd ..
source conf.sh

echo "Running postgres acceptance job"
bash postgres/json-composer.sh
curl -k -XPOST -H "Cookie:${COOKIE}" -d @postgres/body.json $SPARK_DISP_URL

echo "Running elastic acceptance job"
bash elastic/json-composer.sh
curl -k -XPOST -H "Cookie:${COOKIE}" -d @elastic/body.json $SPARK_DISP_URL

echo "Running kafka acceptance job"
bash kafka/json-composer.sh
curl -k -XPOST -H "Cookie:${COOKIE}" -d @kafka/body.json $SPARK_DISP_URL

sleep 30

rm -f */body.json

kill %1 > /dev/null

rm -rf server
