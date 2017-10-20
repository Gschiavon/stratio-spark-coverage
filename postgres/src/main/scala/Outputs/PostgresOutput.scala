package Outputs

import org.apache.spark.sql.{DataFrame, SparkSession}
import org.apache.spark.sql.SaveMode._


case class PostgresOutput(spark: SparkSession, url: String, tableName: String,
                          user: String, password: String) {

  val sslCert = spark.conf.get("spark.ssl.datastore.certPem.path")
  val sslKey = spark.conf.get("spark.ssl.datastore.keyPKCS8.path")
  val sslRootCert = spark.conf.get("spark.ssl.datastore.caPem.path")

  def saveWithoutKeyAndTrust(dataFrame: DataFrame): Unit = {
    val value = s"jdbc:postgresql://${url}?ssl=true&sslmode=verify-full&sslcert=$sslCert&sslrootcert=$sslRootCert&sslkey=$sslKey"
    println(s"PSQL CHAIN: $value")

    spark.conf.getAll.filter{
      case (key, _) => key.contains("ssl")
    }.foreach(println)

    println("WRITING")
    dataFrame.write
      .format("jdbc")
      .option("url", value)
      .option("dbtable", tableName)
      .option("user", user)
      .option("password", password)
      .option("driver", "org.postgresql.Driver")
      .save()
  }

  def readFromPSQL: DataFrame = {
    val value = s"jdbc:postgresql://${url}?ssl=true&sslmode=verify-full&sslcert=$sslCert&sslrootcert=$sslRootCert&sslkey=$sslKey"
    println("READING DATA")
    spark.read
      .format("jdbc")
      .option("url", value)
      .option("dbtable", tableName)
      .option("user", user)
      .option("driver", "org.postgresql.Driver")
      .load()
  }




}
