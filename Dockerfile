FROM qa.stratio.com/nginx:1.10.3-alpine
MAINTAINER Stratio Spark team "spark@stratio.com"

ARG VERSION

#Enable folders listing
RUN sed -i '/index.htm;/a autoindex on;' /etc/nginx/conf.d/default.conf
RUN sed -i 's/listen.*/listen 9000/g' /etc/nginx/conf.d/default.conf

RUN mkdir -p /usr/share/nginx/html/jobs

COPY elastic/target/elastic-${VERSION}-allinone.jar /usr/share/nginx/html/jobs/elastic-${VERSION}.jar
COPY hdfs/target/hdfs-${VERSION}-allinone.jar /usr/share/nginx/html/jobs/hdfs-${VERSION}.jar
COPY kafka/target/kafka-${VERSION}-allinone.jar /usr/share/nginx/html/jobs/kafka-${VERSION}.jar
COPY postgres/target/postgres-${VERSION}-allinone.jar /usr/share/nginx/html/jobs/postgres-${VERSION}.jar
COPY streaming-hdfs-dynamic/target/streaming-hdfs-dynamic-${VERSION}-allinone.jar /usr/share/nginx/html/jobs/streaming-hdfs-dynamic-${VERSION}.jar
COPY structured-streaming/target/structured-streaming-${VERSION}-allinone.jar /usr/share/nginx/html/jobs/structured-streaming-${VERSION}.jar

RUN mkdir -p /usr/share/nginx/html/configs/
RUN mkdir -p /usr/share/nginx/html/configs/megadev

COPY hdfs-stratio/core-site.xml /usr/share/nginx/html/configs/megadev/core-site.xml
COPY hdfs-stratio/hdfs-site.xml /usr/share/nginx/html/configs/megadev/hdfs-site.xml
COPY hdfs-stratio/krb5.conf /usr/share/nginx/html/configs/megadev/krb5.conf

RUN mkdir -p /usr/share/nginx/html/configs/pnf

COPY hdfs-stratio/core-site.xml.PNF /usr/share/nginx/html/configs/pnf/core-site.xml
COPY hdfs-stratio/hdfs-site.xml.PNF /usr/share/nginx/html/configs/pnf/hdfs-site.xml
COPY hdfs-stratio/krb5.conf.PNF /usr/share/nginx/html/configs/pnf/krb5.conf

#TODO NIGHTLY