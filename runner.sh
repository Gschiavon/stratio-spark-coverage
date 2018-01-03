#!/bin/bash

mvn clean package

mkdir server

cp */target/*-allinone.jar server/

cp hdfs-stratio/* server/

cd server

for file in *-allinone.jar
do
    mv "$file" "${file/-allinone.jar/.jar}"
done

sudo python -m SimpleHTTPServer &

cd ..
source conf.sh

echo "Running postgres acceptance job"
bash postgres/json-composer.sh
curl -k -XPOST -H "Cookie:${COOKIE}" -d @postgres/body.json $SPARK_DISP_URL

echo "Running structured streaming acceptance job"
bash structured-streaming/json-composer.sh
curl -k -XPOST -H "Cookie:${COOKIE}" -d @structured-streaming/body.json $SPARK_DISP_URL

echo "Running elastic acceptance job"
bash elastic/json-composer.sh
curl -k -XPOST -H "Cookie:${COOKIE}" -d @elastic/body.json $SPARK_DISP_URL

echo "Running kafka acceptance job"
bash kafka/json-composer.sh
curl -k -XPOST -H "Cookie:${COOKIE}" -d @kafka/body.json $SPARK_DISP_URL

echo "Running hdfs acceptance job"
bash hdfs/json-composer.sh
curl -k -XPOST -H "Cookie:${COOKIE}" -d @hdfs/body.json $SPARK_DISP_URL

echo "Running hdfs dynamic acceptance job"
bash streaming-hdfs-dynamic/json-composer.sh
curl -k -XPOST -H "Cookie:${COOKIE}" -d @streaming-hdfs-dynamic/body.json $SPARK_DISP_URL

sleep 120

rm -f */body.json

kill %1 > /dev/null

rm -rf server

mvn clean
