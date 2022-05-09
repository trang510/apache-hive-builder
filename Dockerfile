FROM ubuntu:latest
ARG HIVE_VERSION="3.1.3"
ARG HADOOP_VERSION="3.3.2"
ENV HIVE_VERSION=${HIVE_VERSION}
ENV HADOOP_VERSION=${HADOOP_VERSION}

RUN apt-get update && echo y | apt-get install openjdk-8-jdk curl
RUN mkdir /opt/app && mkdir /opt/app/work

#Offline 
#COPY apache-hive-${HIVE_VERSION}-bin.tar.gz /opt/app/apache-hive-${HIVE_VERSION}-bin.tar.gz
#COPY hadoop-${HADOOP_VERSION}.tar.gz /opt/app/hadoop-${HADOOP_VERSION}.tar.gz

#Online
RUN curl -o /opt/app/apache-hive-${HIVE_VERSION}-bin.tar.gz https://downloads.apache.org/hive/hive-${HIVE_VERSION}/apache-hive-${HIVE_VERSION}-bin.tar.gz
RUN curl -o /opt/app/hadoop-${HADOOP_VERSION}.tar.gz https://archive.apache.org/dist/hadoop/core/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz

RUN tar zxf /opt/app/apache-hive-${HIVE_VERSION}-bin.tar.gz -C /opt/app && \
    tar zxf /opt/app/hadoop-${HADOOP_VERSION}.tar.gz -C /opt/app
RUN rm /opt/app/apache-hive-${HIVE_VERSION}-bin/lib/guava-19.0.jar && \
    cp /opt/app/hadoop-${HADOOP_VERSION}/share/hadoop/hdfs/lib/guava-27.0-jre.jar /opt/app/apache-hive-${HIVE_VERSION}-bin/lib/ && \
    cp /opt/app/hadoop-${HADOOP_VERSION}/share/hadoop/tools/lib/hadoop-aws-${HADOOP_VERSION}.jar /opt/app/apache-hive-${HIVE_VERSION}-bin/lib/ && \
    cp /opt/app/hadoop-${HADOOP_VERSION}/share/hadoop/tools/lib/aws-java-sdk-bundle-*.jar /opt/app/apache-hive-${HIVE_VERSION}-bin/lib/ && \
    rm /opt/app/*.gz
RUN echo y|apt-get remove curl

ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64
ENV HADOOP_HOME /opt/app/hadoop-${HADOOP_VERSION}
ENV HIVE_HOME /opt/app/apache-hive-${HIVE_VERSION}-bin
ENV PATH $HADOOP_HOME/bin:$HIVE_HOME/bin:$JAVA_HOME/bin:$PATH


WORKDIR /opt/app/work
COPY run.sh /opt/app/work/hive-start.sh
CMD ["/opt/app/work/hive-start.sh"]
