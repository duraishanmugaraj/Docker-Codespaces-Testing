# Use the official Apache Spark image as a base
FROM apache/spark:3.5.2-scala2.12-java11-python3-r-ubuntu

# Set environment variables
ENV SPARK_HOME /opt/spark
ENV PATH $SPARK_HOME/bin:$PATH
ENV PYSPARK_PYTHON /usr/bin/python3
ENV PYSPARK_DRIVER_PYTHON /usr/bin/python3

# Install Python and Jupyter Notebook
RUN apt-get update && \
    apt-get install -y python3 python3-pip && \
    pip3 install --upgrade pip && \
    pip3 install jupyter ipykernel

# Set up Jupyter configuration
RUN mkdir /root/.jupyter && \
    echo "c.NotebookApp.ip = '0.0.0.0'" > /root/.jupyter/jupyter_notebook_config.py && \
    echo "c.NotebookApp.port = 8888" >> /root/.jupyter/jupyter_notebook_config.py && \
    echo "c.NotebookApp.open_browser = False" >> /root/.jupyter/jupyter_notebook_config.py

# Expose Jupyter Notebook port
EXPOSE 8888

# Default command to run Spark and Jupyter Notebook
CMD ["bash", "-c", "start-master.sh && start-worker.sh && jupyter notebook"]

