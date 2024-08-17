# Project Setup Guide

This document provides step-by-step instructions for setting up and running the project using Docker and Apache Airflow. Follow the commands below to get your environment up and running.

## 1. Start Docker Containers

To start the Docker containers, run the following command:

```bash
docker-compose up -d || { echo "Failed to start Docker containers"; }
```

This command will start all the Docker containers defined in your `docker-compose.yml` file. If the containers fail to start, an error message will be displayed.

## 2. Start Apache Airflow

Start the Airflow webserver and scheduler with the following commands:

```bash
airflow webserver --port 8088 &
airflow scheduler &
```

- `airflow webserver --port 8080 &` starts the Airflow webserver on port 8080.
- `airflow scheduler &` starts the Airflow scheduler in the background.

## 3. Install Python Packages in Spark Master Container

Execute the following commands to install required Python packages inside the Spark Master container:

```bash
docker exec -it -u root spark-master bash -c "apt-get update && apt-get install -y python3-pip python3-dev"
docker exec -it -u root spark-master bash -c "pip3 install --upgrade pip"
docker exec -it -u root spark-master bash -c "pip3 install jupyter==1.0.0"
docker exec -it -u root spark-master bash -c "pip3 install pyspark==3.5.2"
```

- `apt-get update && apt-get install -y python3-pip python3-dev` updates the package list and installs `python3-pip` and `python3-dev`.
- `pip3 install --upgrade pip` upgrades `pip` to the latest version.
- `pip3 install jupyter==1.0.0` installs Jupyter Notebook version 1.0.0.
- `pip3 install pyspark==3.5.2` installs PySpark version 3.5.2.

## 4. Start Jupyter Notebook

To start a Jupyter Notebook server inside the Spark Master container, run:

```bash
docker exec -it -u root spark-master jupyter notebook --ip='*' --port=8888 --no-browser --allow-root
```

This command will start Jupyter Notebook on port 8888, accessible from any IP address, and will not open a browser. The `--allow-root` flag allows Jupyter to run as the root user.