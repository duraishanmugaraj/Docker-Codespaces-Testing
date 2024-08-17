#!/bin/bash

# Change directory to the repository
cd /workspaces/$RepositoryName || { echo "Failed to change directory to /workspaces/$RepositoryName"; }

# Update package lists
sudo apt-get update || { echo "Failed to update package lists"; }

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

# Start Airflow webserver in the background and redirect output to log file
airflow webserver --port 8080 >> /tmp/codespaces_setup.log 2>&1 &

# Start Airflow scheduler in the background and redirect output to log file
airflow scheduler >> /tmp/codespaces_setup.log 2>&1 &

echo "Setup completed successfully"