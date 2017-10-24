package com.stratio


import org.apache.spark._
import org.apache.spark.sql.SparkSession

object Main {

  def main(args: Array[String]): Unit = {

    val conf = new SparkConf().setAppName("kafka-structured-streaming")
    val spark = SparkSession
      .builder()
      .config(conf)
      .getOrCreate()

    val bootstrapServers = args(0)
    val topic = args(1)
    import spark.implicits._
    val result = spark.sparkContext.parallelize(Seq("Demo", "Spark", "Team", "2017")).toDF()
    val kafkaParams = Map[String, String](
      "kafka.bootstrap.servers" -> bootstrapServers
    )

    val opts = extractKafkaSecurityOption(kafkaParams, conf)

    val readKafkaParams = opts ++ Map("subscribe" -> topic)
    val writeKafkaParams = opts ++ Map("topic" -> topic)

    result
      .write
      .format("kafka")
      .options(writeKafkaParams)
      .save()

    val ds1 = spark
      .read
      .format("kafka")
      .options(readKafkaParams)
      .load()

    val data = ds1.selectExpr("CAST(value AS STRING)")
      .as[String].collect()

    println("DATA READ")
    data.foreach(println)

    ds1.show()
  }

  def extractKafkaSecurityOption(kafkaParams: Map[String, String],
                                 sparkConf: SparkConf): Map[String, String] = {
    val prefixKafka = "spark.ssl.datastore."
    if (sparkConf.getOption(prefixKafka + "enabled").isDefined && sparkConf.get(prefixKafka + "enabled") == "true") {
      val configKafka = sparkConf.getAllWithPrefix(prefixKafka).toMap
      kafkaParams ++ Map[String, String](
        "kafka.security.protocol" -> "SSL",
        "kafka.ssl.key.password" -> configKafka("keyPassword"),
        "kafka.ssl.keystore.location" -> configKafka("keyStore"),
        "kafka.ssl.keystore.password"-> configKafka("keyStorePassword"),
        "kafka.ssl.truststore.location"-> configKafka("trustStore"),
        "kafka.ssl.truststore.password"-> configKafka("trustStorePassword"))

    } else kafkaParams
  }
}
