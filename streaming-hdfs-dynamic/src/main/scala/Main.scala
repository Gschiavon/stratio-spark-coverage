import org.apache.spark._
import org.apache.spark.rdd.RDD
import org.apache.spark.sql.SparkSession
import org.apache.spark.streaming._

import scala.collection.mutable

object Main {

  def main(args: Array[String]): Unit = {

    val sparkConf = new SparkConf().setAppName("Shuffle")
    val ssc = new StreamingContext(sparkConf, Seconds(4))
    val spark = SparkSession
      .builder()
      .config(sparkConf)
      .getOrCreate()

    val rdd  = spark.sparkContext.textFile(args(0))
    val wordsRDD = rdd
      .flatMap(_.split(" "))
      .map(word => (word, 1))
      .groupByKey()

    val rddQueue: mutable.Queue[RDD[(String, Iterable[Int])]] = mutable.Queue()
    rddQueue += wordsRDD
    val dstream = ssc.queueStream(rddQueue)
    dstream.print

    ssc.start()
    ssc.awaitTermination()

  }
}
