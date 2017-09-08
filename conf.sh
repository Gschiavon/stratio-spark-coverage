#!/bin/bash

##COMMON CONF VARS
SPARK_DISP_URL="https://megadev.labs.stratio.com/service/spark-fw/v1/submissions/create"
COOKIE="SSOID=s1;dcos-acs-auth-cookie=eyJhbGciOiJIUzI1NiIsImtpZCI6InNlY3JldCIsInR5cCI6IkpXVCJ9.eyJleHAiOjE1MDQ4MDAzOTMsInVpZCI6ImFkbWluQGRlbW8uc3RyYXRpby5jb20ifQ.aoJybGRFCMyHXD4JL31Y8FeT7kGU6mMgrmbCU3HNK9c;dcos-acs-info-cookie=eyJ1aWQiOiJhZG1pbiIsImRlc2NyaXB0aW9uIjoiYWRtaW4ifQ=="
SPARK_IMAGE="qa.stratio.com/stratio/stratio-spark:2.1.0.5-RC1-SNAPSHOT"
EXEC_CALICO_NETWORK="stratio"
DRIVER_CALICO_NETWORK="stratio"
VAULT_ROLE="open"
MESOS_ROLE="open"
MESOS_PRINCIPAL="open"
MESOS_SECRET="DrE6o5r67qnf38H9K5KgGhoeRHqwU6sVNBVStHqw"

##POSTGRES CONF VARS
PG_HOST="pg_0001-postgrestls.service.paas.labs.stratio.com"
PG_PORT="5432"
PG_JAR_URL="http://HOST:PORT/postgres-0.1.0.jar"

##ELASTIC CONF VARS
ES_HOST="coordinator-0-node.elasticsearchstratio.mesos"
ES_PORT="31504"
ES_JAR_URL="http://HOST:PORT/elastic-0.1.0.jar"

##KAFKA CONF VARS
KAFKA_BROKER_LIST="gosec1.node.paas.labs.stratio.com:9092"
TOPIC="audit"
KAFKA_JAR_URL="http://HOST:PORT/kafka-0.1.0.jar"

##HDFS CONF VARS
HDFS_PATH="/spark/test"
HDFS_CONF_URI="http://HOST:PORT"
HDFS_JAR_URL="http://HOST:PORT/spark-hdfs.jar"
KERBEROS_VAULT_PATH="/v1/userland/kerberos/crossdata-1"