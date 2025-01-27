import os
import typing as tp

from airflow.providers.common.sql.operators.sql import SQLExecuteQueryOperator
from airflow.operators.python_operator import PythonOperator
from datetime import datetime
from airflow import DAG

def process_table_names(ti: object) -> bool | tp.List[str]:
    """Gera uma query para exportar as tabelas do banco de dados em formato CSV.

    Args:
        ti: Xcom com os nomes das tabelas.

    Returns:
        querys: Query para exportar as tabelas em formato CSV.
        false: Caso não haja tabelas.
    """
    table_names: tp.List[str] = ti.xcom_pull(task_ids='extract_table_names')

    if table_names:
        querys: tp.List[str] = [f"COPY {table[0]} TO '/temp/{table[0].title()}-Export-{datetime.now().strftime('D%d%m%YT%H%M')}.csv' DELIMITER ',' CSV HEADER;" for table in table_names]
        querys = '\n'.join(querys)
        return querys

    return False

def delete_temp_files() -> None:
    """Deleta os arquivos temporários gerados durante a execução do DAG.

    Returns:
        None
    """
    files: tp.List[str] = os.listdir('/temp')
    
    for f in files:
        os.remove(f'/temp/{f}')
    
    return

with DAG (
    dag_id='Postgres_Partial_Backup',
    start_date=datetime.now(),
    schedule_interval='@weekly',
    catchup=False 
) as dag:
    extract_table_names = SQLExecuteQueryOperator(
        task_id='extract_table_names',
        sql="SELECT table_name FROM information_schema.tables where table_schema like 'public'",
        conn_id='banco_teste',
    )

    read_table_names = PythonOperator(
        task_id='read_table_names',
        python_callable=process_table_names,
    )

    do_backup = SQLExecuteQueryOperator(
        task_id='do_backup',
        conn_id='banco_teste',
        sql="{{ task_instance.xcom_pull(task_ids='read_table_names') }}",
    )

    verify_and_delete_temp_files = PythonOperator(
        task_id='verify_and_delete_temp_files',
        python_callable=delete_temp_files,
    )

    # 1. Verifica e deleta os arquivos temporários
    # 2. Extrai os nomes das tabelas do banco de dados
    # 3. Gera querys para exportar as tabelas em formato CSV
    # 4. Executa as querys geradas
    verify_and_delete_temp_files >> extract_table_names >> read_table_names >> do_backup