from pyspark.sql import SparkSession

def main():
    spark = SparkSession.builder.appName("SyamBigDataPipeline").getOrCreate()

    print("Spark session started")

    data = [
        ("New York", 100),
        ("California", 200),
        ("Texas", 150)
    ]

    df = spark.createDataFrame(data, ["State", "Sales"])
    df.show()

    result = df.groupBy("State").sum("Sales")
    result.show()

    spark.stop()

if __name__ == "__main__":
    main()
