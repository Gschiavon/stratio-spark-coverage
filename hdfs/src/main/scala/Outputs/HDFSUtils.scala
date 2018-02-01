package Outputs

import org.apache.spark.sql.{DataFrame, SparkSession}
import org.apache.spark.sql.SaveMode._

case class HDFSUtils(spark: SparkSession, hdfsPath: String) {

  def saveToHDFS(dataFrame: DataFrame): String = {
    val value = s"$hdfsPath${System.currentTimeMillis}/"
    dataFrame
      .write
      .mode(Append)
      .format("csv")
      .option("path", value)
      .save()
    value
  }

}
