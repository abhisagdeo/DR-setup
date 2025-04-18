import boto3
import json

def copy_glue_catalog(source_region, target_region):
    glue_src = boto3.client('glue', region_name=source_region)
    glue_dest = boto3.client('glue', region_name=target_region)

    databases = glue_src.get_databases()['DatabaseList']
    for db in databases:
        db_input = {
            'Name': db['Name'],
            'Description': db.get('Description', ''),
            'LocationUri': db.get('LocationUri', ''),
            'Parameters': db.get('Parameters', {})
        }

        try:
            glue_dest.create_database(DatabaseInput=db_input)
        except glue_dest.exceptions.AlreadyExistsException:
            glue_dest.update_database(Name=db['Name'], DatabaseInput=db_input)

        tables = glue_src.get_tables(DatabaseName=db['Name'])['TableList']
        for table in tables:
            table_input = {
                'Name': table['Name'],
                'StorageDescriptor': table['StorageDescriptor'],
                'PartitionKeys': table['PartitionKeys'],
                'TableType': table['TableType'],
                'Parameters': table['Parameters']
            }
            glue_dest.create_table(DatabaseName=db['Name'], TableInput=table_input)

if __name__ == "__main__":
    copy_glue_catalog("us-east-1", "us-west-2")  # Change to your regions