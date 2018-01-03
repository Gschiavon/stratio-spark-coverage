#!/bin/bash

source conf.sh

cat << EOF > hdfs/body.json
{
    "action": "CreateSubmissionRequest",
    "appArgs": ["$HDFS_PATH_FILE"],
    "appResource": "$HDFS_STREAMING_JAR_URL",
    "clientSparkVersion": "2.2.0",
    "environmentVariables": {
        "SPARK_SCALA_VERSION": "2.11"
    },
    "mainClass": "Main",
    "sparkProperties": {
        "spark.jars": "$HDFS_STREAMING_JAR_URL",
        "spark.app.name": "AT-hdfs",
        "spark.mesos.executor.docker.image": "$SPARK_IMAGE",
        "spark.mesos.executor.docker.volumes": "/etc/pki/ca-trust/extracted/java/cacerts/:/usr/lib/jvm/jre1.8.0_112/lib/security/cacerts:ro,/var/lib/spark_data:/tmp:rw,/etc/resolv.conf:/etc/resolv.conf:ro",
        "spark.driver.supervise": "false",
        "spark.secret.vault.role": "$VAULT_ROLE",
        "spark.mesos.executor.docker.network.name": "$EXEC_CALICO_NETWORK",
        "spark.mesos.driver.docker.network.name": "$DRIVER_CALICO_NETWORK",

        "spark.mesos.driverEnv.SPARK_SECURITY_HDFS_ENABLE": "true",
        "spark.mesos.driverEnv.SPARK_SECURITY_HDFS_CONF_URI": "$HDFS_CONF_URI",
        "spark.mesos.driverEnv.SPARK_SECURITY_KERBEROS_ENABLE": "true",
        "spark.mesos.driverEnv.SPARK_SECURITY_KERBEROS_VAULT_PATH": "$KERBEROS_VAULT_PATH",

        "spark.mesos.driverEnv.VAULT_PROTOCOL": "https",
        "spark.mesos.driverEnv.VAULT_HOSTS": "vault.service.paas.labs.stratio.com",
        "spark.mesos.driverEnv.VAULT_PORT": "8200",

        "spark.mesos.executor.docker.forcePullImage": "true",
        "spark.dynamicAllocation.executorIdleTimeout" :	"2s",
        "spark.shuffle.service.enabled" : "true",
        "spark.dynamicAllocation.enabled" : "true",

        "spark.submit.deployMode": "cluster",
        "spark.mesos.role": "$MESOS_ROLE",
        "spark.mesos.executor.home": "/opt/spark/dist",
        "spark.executor.cores": "1",
        "spark.cores.max": "1",

    }
}
EOF
