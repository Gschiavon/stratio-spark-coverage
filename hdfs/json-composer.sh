#!/bin/bash

source conf.sh

cat << EOF > hdfs/body.json
{
"action" : "CreateSubmissionRequest",
"appArgs" : ["$HDFS_PATH"],
"appResource" : "$HDFS_JAR_URL",
"clientSparkVersion" : "2.1.0",
"environmentVariables" : {
"SPARK_SCALA_VERSION" : "2.11"
},
"mainClass" : "Main",
"sparkProperties" : {
"spark.jars" : "$HDFS_JAR_URL",
"spark.mesos.executor.docker.volumes" : "/etc/pki/ca-trust/extracted/java/cacerts/:/usr/lib/jvm/jre1.8.0_112/lib/security/cacerts:ro",
"spark.driver.supervise" : "false",
"spark.secret.vault.role" : "$VAULT_ROLE",
"spark.mesos.executor.docker.network.name" : "$EXEC_CALICO_NETWORK",
"spark.mesos.driver.docker.network.name": "$DRIVER_CALICO_NETWORK",
"spark.app.name" : "AT-hdfs",
"spark.mesos.driverEnv.SPARK_SECURITY_HDFS_ENABLE" : "true",
"spark.mesos.driverEnv.SPARK_SECURITY_HDFS_CONF_URI" : "$HDFS_CONF_URI",
"spark.mesos.driverEnv.SPARK_SECURITY_KERBEROS_ENABLE" : "true",
"spark.mesos.driverEnv.SPARK_SECURITY_KERBEROS_VAULT_PATH" : "$KERBEROS_VAULT_PATH",
"spark.mesos.executor.docker.image" : "$SPARK_IMAGE",
"spark.submit.deployMode" : "cluster",
"spark.mesos.principal" : "$MESOS_PRINCIPAL",
"spark.mesos.secret" : "$MESOS_SECRET",
"spark.mesos.role" : "$MESOS_ROLE",
"spark.secret.vault.hosts" : "vault.service.paas.labs.stratio.com",
"spark.secret.vault.protocol" : "https",
"spark.secret.vault.port" : "8200",
"spark.mesos.driverEnv.VAULT_PROTOCOL" : "https",
"spark.mesos.driverEnv.VAULT_HOSTS" : "vault.service.paas.labs.stratio.com",
"spark.mesos.driverEnv.VAULT_PORT" :  "8200",
"spark.executorEnv.VAULT_PROTOCOL" : "https",
"spark.executorEnv.VAULT_HOSTS" : "vault.service.paas.labs.stratio.com",
"spark.executorEnv.VAULT_PORT" :  "8200",
"spark.mesos.executor.home" : "/opt/spark/dist",
"spark.executor.cores" : "1",
"spark.cores.max" : "1"
}
}
EOF