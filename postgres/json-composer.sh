#!/bin/bash -x

source conf.sh

cat << EOF > postgres/body.json


{
"action": "CreateSubmissionRequest",
"appArgs": ["$PG_HOST:$PG_PORT/postgres","postgres","postgres","postgres"],
"appResource": "$PG_JAR_URL",
"clientSparkVersion": "2.1.0",
"environmentVariables": {
"SPARK_SCALA_VERSION": "2.11"
},
    "mainClass" : " com.stratio.Main",
    "sparkProperties" : {
      "spark.mesos.driverEnv.SPARK_DATASTORE_SSL_ENABLE" : "true",
      "spark.executorEnv.SPARK_DATASTORE_SSL_ENABLE" : "true",
      "spark.mesos.driverEnv.APP_NAME" : "job-sparktest",
      "spark.jars" : "$PG_JAR_URL",
      "spark.mesos.executor.docker.volumes" : "/etc/pki/ca-trust/extracted/java/cacerts/:/etc/ssl/certs/java/cacerts:ro",
      "spark.driver.supervise" : "false",
      "spark.mesos.executor.docker.network.name" : "$EXEC_CALICO_NETWORK",
      "spark.mesos.driver.docker.network.name": "$DRIVER_CALICO_NETWORK",
      "spark.app.name" : "test-spark",
      "spark.secret.vault.role" : "$VAULT_ROLE",
      "spark.mesos.driverEnv.APP_NAME" : "job-sparktest",
      "spark.executorEnv.APP_NAME" : "job-sparktest",
      "spark.mesos.driverEnv.CA_NAME" : "ca",
      "spark.executorEnv.CA_NAME" : "ca",

      "spark.mesos.executor.docker.image" : "$SPARK_IMAGE",

      "spark.secret.vault.hosts" : "vault.service.paas.labs.stratio.com",
      "spark.mesos.driverEnv.VAULT_HOST" : "vault.service.paas.labs.stratio.com",
      "spark.executorEnv.VAULT_HOST" : "vault.service.paas.labs.stratio.com",
      "spark.secret.vault.protocol" : "https",
      "spark.secret.vault.port" : "8200",
      "spark.mesos.driverEnv.VAULT_PORT" :  "8200",
      "spark.mesos.driverEnv.VAULT_PROTOCOL" : "https",
      "spark.executorEnv.VAULT_PROTOCOL" : "https",
      "spark.executorEnv.VAULT_PORT" : "8200",

      "spark.mesos.principal" : "$MESOS_PRINCIPAL",
      "spark.mesos.secret" : "$MESOS_SECRET",
      "spark.mesos.role" : "$MESOS_ROLE",

      "spark.submit.deployMode" : "cluster",
      "spark.mesos.executor.home" : "/opt/spark/dist",
      "spark.executor.cores" : "1",
      "spark.cores.max" : "1"
      }
   }

EOF
