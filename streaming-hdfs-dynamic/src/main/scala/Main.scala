import org.apache.spark._
import org.apache.spark.rdd.RDD
import org.apache.spark.sql.SparkSession
import org.apache.spark.streaming._

import scala.collection.mutable

object Main {

  def main(args: Array[String]): Unit = {
    val sparkConf = new SparkConf().setAppName("AT-hdfs-dynamic")
    val ssc = new StreamingContext(sparkConf, Seconds(20))
    val spark = SparkSession
      .builder()
      .config(sparkConf)
      .getOrCreate()

    val dstream = ssc.textFileStream(args(0))
      .flatMap(_.split(" "))
      .map(word => (word, 1))
      .groupByKey()

    dstream.foreachRDD(rdd => println(s"****** Imprimiendo RDD ${rdd.collect.mkString(",")}"))

    ssc.start()
    ssc.awaitTermination()
  }

}
