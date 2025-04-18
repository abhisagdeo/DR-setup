from airflow import DAG
from airflow.operators.python_operator import PythonOperator
from datetime import datetime
import boto3
import json

def run_pipeline():
    secret_name = "primary-or-dr-secret"
    region = "us-west-2"

    client = boto3.client('secretsmanager', region_name=region)
    response = client.get_secret_value(SecretId=secret_name)
    secret_data = json.loads(response['SecretString'])

    if secret_data["active"] == "dr":
        print("Running DR pipeline with MRAP access")
    else:
        print("Running Primary logic (should not run from DR)")

dag = DAG('dr_enabled_pipeline',
          start_date=datetime(2023, 1, 1),
          schedule_interval='@daily',
          catchup=False)

task = PythonOperator(
    task_id='run_data_pipeline',
    python_callable=run_pipeline,
    dag=dag
)