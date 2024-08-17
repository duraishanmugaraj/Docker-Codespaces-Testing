# Project Setup Guide

Follow the commands below to get your environment up and running.

## 1. Start Docker Containers

To start the Docker containers, run the following command:

```bash
docker-compose up -d
```

This command will start all the Docker containers defined in your `docker-compose.yml` file. If the containers fail to start, an error message will be displayed.

## 2. Start Apache Airflow

Start the Airflow webserver and scheduler with the following commands:

```bash
airflow webserver --port 8080 >> /tmp/airflow_webserver.log 2>&1 &
airflow scheduler >> /tmp/airflow_scheduler.log 2>&1 &
```

- `airflow webserver --port 8080 &` starts the Airflow webserver on port 8080 and redirect output to log file.
- `airflow scheduler &` starts the Airflow scheduler in the background and redirect output to log file.