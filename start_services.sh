#!/bin/bash
# Start Spark Master
/opt/spark/bin/spark-class org.apache.spark.deploy.master.Master &

# Set Jupyter Notebook configuration if it doesn't exist
if [ ! -f /$(whoami)/.jupyter/jupyter_notebook_config.py ]; then
    jupyter notebook --generate-config -y
fi

echo "c.NotebookApp.password = ''" >> /$(whoami)/.jupyter/jupyter_notebook_config.py
echo "c.NotebookApp.token = ''" >> /$(whoami)/.jupyter/jupyter_notebook_config.py
# Start Jupyter Notebook
jupyter notebook --ip='*' --port=8888 --no-browser --allow-root &

wait