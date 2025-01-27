from airflow import DAG
from airflow.operators.python_operator import PythonOperator
from datetime import datetime
from airflow.hooks.S3_hook import S3Hook
from time import sleep
import os
import typing as tp

def files() -> tp.List[str]:
    """Retorna o nome dos arquivos gerados pela query de extração/backup parcial.

    Returns:
        os.listdir: Lista com os nomes dos arquivos gerados.
    """
    return os.listdir('/temp')

def deploy(bucket_name: str, ti: object) -> None:
    files: tp.List[str] = ti.xcom_pull(task_ids='read_files_name')
    # print('FEITO')
    # files = files[0]
    for f in range(len(files)):
        file_path: str = f'/temp/{files[f]}'
        s3_key: str = f'backups/{datetime.now().strftime('%d%m%Y')}/{files[f]}'
        hook: object = S3Hook('partial-backup-s3')
        hook.load_file(filename=file_path, 
                    key=s3_key,
                    bucket_name=bucket_name,
                    replace=True)

def delete_temp_files() -> None:
    files: tp.List[str] = os.listdir('/temp')

    for f in files:
        os.remove(f'/temp/{f}')

with DAG (
    dag_id='Deploy_to_S3',
    start_date=datetime.now(),
    schedule_interval='@weekly',
    catchup=False 
) as dag:
    read_files_name = PythonOperator(
        task_id='read_files_name',
        python_callable=files,
    )

    deploy_files_to_s3 = PythonOperator(
        task_id='deploy_files_to_s3',
        python_callable=deploy,
        op_kwargs={
            'bucket_name': 'partial-backup'
                   },
    )

    delete_temp_files = PythonOperator(
        task_id='delete_temp_files',
        python_callable=delete_temp_files,
    )

    # Lê os arquivos gerados pela extração/backup parcial
    # Envia os arquivos para o bucket S3
    # Deleta os arquivos temporários gerados durante a execução da DAG anterior
    read_files_name >> deploy_files_to_s3 >> delete_temp_files