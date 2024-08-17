docker exec -it -u root spark-master bash -c "apt-get update && apt-get install -y python3-pip python3-dev"
docker exec -it -u root spark-master bash -c "pip3 install --upgrade pip"
docker exec -it -u root spark-master bash -c "pip3 install jupyter==1.0.0"
docker exec -it -u root spark-master bash -c "pip3 install pyspark==3.5.2"