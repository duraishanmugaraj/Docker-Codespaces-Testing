#!/bin/bash

# Change directory to the repository
cd /workspaces/$RepositoryName || { echo "Failed to change directory to /workspaces/$RepositoryName"; }

# Update package lists
sudo apt-get update || { echo "Failed to update package lists"; }

# Pull the Docker image
docker pull docker.io/apache/spark:3.5.2-scala2.12-java11-python3-r-ubuntu || { echo "Failed to pull Docker image"; }

# Start Docker containers in detached mode
docker-compose up -d || { echo "Failed to start Docker containers"; }

# Install Python packages inside the spark-master container
docker exec -it -u root spark-master bash -c "apt-get update && apt-get install -y python3-pip python3-dev" || { echo "Failed to install Python packages"; }
docker exec -it -u root spark-master bash -c "pip3 install --upgrade pip" || { echo "Failed to upgrade pip"; }
docker exec -it -u root spark-master bash -c "pip3 install jupyter pyspark" || { echo "Failed to install Jupyter and PySpark"; }

# Determine Python version for Airflow constraints
python_version=$(python --version 2>&1 | cut -d ' ' -f 2 | cut -d '.' -f 1-2) || { echo "Failed to get Python version"; }

# Install Apache Airflow with constraints
pip install "apache-airflow==2.7.1" --constraint "https://raw.githubusercontent.com/apache/airflow/constraints-2.7.1/constraints-${python_version}.txt" || { echo "Failed to install Apache Airflow"; }

# Initialize Airflow database
airflow db init || { echo "Failed to initialize Airflow database"; }

# Create Airflow admin user
airflow users create \
    --username admin \
    --password admin \
    --firstname FirstName \
    --lastname LastName \
    --role Admin \
    --email admin@example.com || { echo "Failed to create Airflow admin user"; }

# Start Airflow webserver and scheduler
airflow webserver --port 8080 & || { echo "Failed to start Airflow webserver"; }
airflow scheduler & || { echo "Failed to start Airflow scheduler"; }

# Start Jupyter notebook server inside the spark-master container
docker exec -it -u root spark-master bash -c "nohup jupyter notebook --ip='*' --port=8888 --no-browser --allow-root > /tmp/jupyter.log 2>&1 &" || { echo "Failed to start Jupyter notebook server"; }

echo "Setup completed successfully"
