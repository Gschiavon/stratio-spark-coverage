#!/bin/bash

##COMMON CONF VARS
SPARK_DISP_URL="https://megadev.labs.stratio.com/service/spark-fw/v1/submissions/create"
COOKIE="SSOID=s1; dcos-acs-auth-cookie=eyJhbGciOiJIUzI1NiIsImtpZCI6InNlY3JldCIsInR5cCI6IkpXVCJ9.eyJleHAiOjE1MDg3NTk5MjksInVpZCI6ImFkbWluQGRlbW8uc3RyYXRpby5jb20ifQ.bP3pUk-KaL7VVXpNYEFxDxgj-bQnIIVBwydtYNyhCUM; dcos-acs-info-cookie=eyJ1aWQiOiJhZG1pbiIsImRlc2NyaXB0aW9uIjoiYWRtaW4ifQ=="
SPARK_IMAGE="qa.stratio.com/stratio/stratio-spark:2.1.0.4"
EXEC_CALICO_NETWORK="stratio"
DRIVER_CALICO_NETWORK="stratio"
VAULT_ROLE="open"
MESOS_ROLE="spark-fw"
MESOS_PRINCIPAL="open"
MESOS_SECRET="DrE6o5r67qnf38H9K5KgGhoeRHqwU6sVNBVStHqw"
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