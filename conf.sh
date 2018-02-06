#!/bin/bash

#COMMON CONF VARS
SPARK_DISPATCHER_URL="https://<CLUSTER_ID>.labs.stratio.com/service/spark-fw/v1/submissions/create"
COOKIE="Cookie: SSOID=s1; dcos-acs-auth-cookie=******; dcos-acs-info-cookie=******"
SPARK_IMAGE="qa.stratio.com/stratio/stratio-spark:2.2.0.4"
INTERNAL_DOMAIN="<INTERNAL_DOMAIN>" ## LDAP+Kerberos --> paas.labs.stratio.com || ActiveDirectory --> paas.stratio.test
EXECUTOR_CALICO_NETWORK="<CALICO_NETWORK>" ## stratio
DRIVER_CALICO_NETWORK="<CALICO_NETWORK>" ## stratio
VAULT_ROLE="<VAULT_ROLE>" ## open
MESOS_ROLE="<MESOS_ROLE>" ## spark-fw
FILES_HTTP_SERVER="http://<HOST_IP>:8000" ## IP desde dónde se sirven los ficheros (JARs y configuración de HDFS)
KERBEROS_VAULT_PATH="/v1/userland/kerberos/crossdata-1"
HDFS_STRATIO="hdfs://<HDFS_STRATIO_URL>:<HDFS_STRATIO_PORT>" ## NORMAL --> hdfs://10.200.0.74:8020 || PNF y ActiveDirectory --> hdfs://stratio:8020
TEST_ARTIFACTS_VERSION="0.1.0-SNAPSHOT"
MESOS_VAULT_PATH="<MESOS_VAULT_PATH>" #v1/userland/passwords/spark-fw/mesos Este path se usará para recuperar el secret y el principal


#POSTGRES CONF VARS
PG_HOST="pg-0001-<POSTGRES_TLS_INSTANCE_NAME>.service.$INTERNAL_DOMAIN" ## postgrestls
PG_PORT="5432"
PG_JAR_URL="http://$FILES_HTTP_SERVER/postgres-$TEST_ARTIFACTS_VERSION.jar"

#ELASTICSEARCH CONF VARS
ES_HOST="coordinator-0-node.<ELASTICSEARCH_INSTANCE_NAME>.mesos" ## elasticsearchstratio
ES_PORT="31504"
ES_JAR_URL="$FILES_HTTP_SERVER/elastic-$TEST_ARTIFACTS_VERSION.jar"

#KAFKA CONF VARS
KAFKA_BROKER_LIST="gosec1.node.$INTERNAL_DOMAIN:9092"
KAFKA_TOPIC="audit"
KAFKA_JAR_URL="$FILES_HTTP_SERVER/kafka-$TEST_ARTIFACTS_VERSION.jar"

#HDFS CONF VARS
HDFS_PATH="/tmp/spark-test"
HDFS_CONF_URI="$FILES_HTTP_SERVER"
HDFS_JAR_URL="$FILES_HTTP_SERVER/hdfs-$TEST_ARTIFACTS_VERSION.jar"

#STRUCTURED CONF VARS
STRUCTURED_TOPIC="test"
STRUCTURED_JAR_URL="$FILES_HTTP_SERVER/structured-streaming-$TEST_ARTIFACTS_VERSION.jar"

#STREAMING HDFS DYNAMIC ALLOCATION CONF VARS
HDFS_PATH_FILE="hdfs:///tmp/test_qa_1GB.csv"
HDFS_STREAMING_JAR_URL="$FILES_HTTP_SERVER/streaming-hdfs-dynamic-$TEST_ARTIFACTS_VERSION.jar"
