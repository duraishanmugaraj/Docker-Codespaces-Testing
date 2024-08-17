sudo apt-get update
sudo apt-get install -y awscli

docker pull docker.io/apache/spark:3.5.2-scala2.12-java11-python3-r-ubuntu
docker-compose up -d

docker exec -it -u root spark-master bash -c "apt-get update && apt-get install -y python3-pip python3-dev"
docker exec -it -u root spark-master bash -c "pip3 install --upgrade pip"
docker exec -it -u root spark-master bash -c "pip3 install jupyter pyspark"

python_version=$(python --version 2>&1 | cut -d ' ' -f 2 | cut -d '.' -f 1-2)

airflow db init
airflow users create \
    --username admin \
    --password admin \
    --firstname FirstName \
    --lastname LastName \
    --role Admin \
    --email admin@example.com

airflow webserver --port 8080 &
airflow scheduler &

docker exec -it -u root spark-master jupyter notebook --ip='*'  --port=8888 --no-browser --allow-root