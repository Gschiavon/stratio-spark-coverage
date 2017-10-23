#!/bin/bash

##COMMON CONF VARS
SPARK_DISP_URL="https://megadev.labs.stratio.com/service/spark-fw/v1/submissions/create"
COOKIE="COOKIE:COOKIE:COOKIE"
SPARK_IMAGE="qa.stratio.com/stratio/stratio-spark:2.1.0.4"
EXEC_CALICO_NETWORK="CALICO"
DRIVER_CALICO_NETWORK="CALICO"
VAULT_ROLE="VAULT-ROLE"
MESOS_ROLE="MESOS-ROLE"
MESOS_PRINCIPAL="PRINCIPAL"
MESOS_SECRET="SECRET"
HOST_PORT="HOST_IP:HOST_PORT"
HDFS_FILES_HOST_PORT="HOST_IP:HOST_PORT"

#POSTGRES CONF VARS
PG_HOST="pg_0001-postgrestls.service.paas.labs.stratio.com"
PG_PORT="5432"
PG_JAR_URL="http://$HOST_PORT/postgres-0.1.0-SNAPSHOT-allinone.jar"

#ELASTIC CONF VARS
ES_HOST="coordinator-0-node.elasticsearchstratio-2.mesos"
ES_PORT="31504"
ES_JAR_URL="http://$HOST_PORT/elastic-0.1.0-SNAPSHOT-allinone.jar"

#KAFKA CONF VARS
KAFKA_BROKER_LIST="gosec1.node.paas.labs.stratio.com:9092"
TOPIC="audit"
KAFKA_JAR_URL="http://$HOST_PORT/kafka-0.1.0-SNAPSHOT-allinone.jar"

##HDFS CONF VARS
HDFS_PATH="/spark/test"
HDFS_CONF_URI="http://$HDFS_FILES_HOST_PORT"
HDFS_JAR_URL="http://$HOST_PORT/hdfs-0.1.0-SNAPSHOT-allinone.jar"
KERBEROS_VAULT_PATH="/v1/userland/kerberos/crossdata-1"

##STRUCTURED CONF VARS
STRUCTURED_TOPIC="test"
STRUCTURED_JAR_URL="http://$HOST_PORT/kafka-0.1.0.jar"