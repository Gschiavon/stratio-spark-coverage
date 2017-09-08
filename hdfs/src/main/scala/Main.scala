import Outputs.HDFSUtils
import org.apache.spark._
import org.apache.spark.sql.SparkSession

object Main {

  def main(args: Array[String]): Unit = {

    val conf = new SparkConf().setAppName("test")
    val sc = new SparkContext(conf)

    val spark = SparkSession
      .builder()
      .appName("spark-hdfs")
      .getOrCreate()

    import spark.implicits._
    val hdfsPath = args(0)
    val hdfs = HDFSUtils(spark, hdfsPath)
    val df = spark.sparkContext.parallelize(List(1,2,3,4,5,6,7,8,9,10)).toDF()

    println("Writing to HDFS a List of 10 numbers")
    val pathToRead = hdfs.saveToHDFS(df)

    println("Reading from HDFS HDFS")
    spark.sparkContext.textFile(pathToRead).collect.foreach(println)
  }
}


