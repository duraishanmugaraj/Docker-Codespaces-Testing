# Use the base image
FROM docker.io/apache/spark:3.5.2-scala2.12-java11-python3-r-ubuntu

# Ensure all commands are run as root
USER root

# Update and install required packages
RUN apt-get update && \
    apt-get install -y python3-pip python3-dev && \
    pip3 install --upgrade pip && \
    pip3 install jupyter==1.0.0 pyspark==3.5.2 && \
    mkdir /opt/spark/conf/

COPY spark-defaults.conf /opt/spark/conf/spark-defaults.conf