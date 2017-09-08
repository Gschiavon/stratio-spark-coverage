import Outputs.HDFSUtils
import org.apache.spark._
import org.apache.spark.sql.SparkSession

object Main {

  def main(args: Array[String]): Unit = {

    val conf = new SparkConf().setAppName("test")
    val sc = new SparkContext(conf)

    val spark = SparkSession
      .builder()
      .getOrCreate()

    import spark.implicits._
    val hdfsPath = args(0)
    val hdfs = HDFSUtils(spark, hdfsPath)
    val numbers = List(1,2,3,4,5,6,7,8,9,10)
    val df = spark.sparkContext.parallelize(numbers).toDF()

    println("Writing to HDFS a List of 10 numbers")
    val pathToRead = hdfs.saveToHDFS(df)

    println("Reading from HDFS")
    val check = spark.sparkContext.textFile(pathToRead).collect.toList.sameElements(numbers)

    println(s"Checking if elements read are the same that elements written: $check")
  }
}


