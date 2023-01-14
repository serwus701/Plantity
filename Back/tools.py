import pandas as pd
from sqlalchemy import create_engine

url = 'mysql://login_manager:loginpassword123@127.0.0.1/plants'
engine = create_engine(url)
connection = engine.connect()


def get_dataframe_size(df):
    size = 0

    while True:
        try:
            df.iloc[size]
            size += 1
        except:
            return size


def get_library_id(user_login):
    sql_query = """SELECT user_id FROM plants.users WHERE user_login = %s"""
    df = pd.read_sql_query(sql_query, connection, params=[user_login])
    user_id = df.iloc[0]["user_id"]

    sql_query = """SELECT library_id FROM plants.libraries WHERE user_id = %s"""
    df = pd.read_sql_query(sql_query, connection, params=[user_id])
    library_id = df.iloc[0]["library_id"]

    return library_id
