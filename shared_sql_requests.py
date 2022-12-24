import sqlite3

import pandas as pd
from sqlalchemy import create_engine
import pandas
from sqlalchemy.connectors import pyodbc
from sqlalchemy.dialects.postgresql import psycopg2

url = 'mysql://login_manager:loginpassword123@127.0.0.1/plants'
engine = create_engine(url)
connection = engine.connect()

def do_sum_sql_request():

    sql_query = "SELECT * FROM users WHERE user_login = ?"

    login = "slaby_gracz"

    df = pd.read_sql_query(sql_query, engine, login)
    #df.head()

    record = df.iloc[0]['lastname']

    print(record)

def sql_request_login(login, password):

    sql_query = """SELECT * FROM users WHERE user_login = %s"""

    df = pd.read_sql_query(sql_query, connection, params=[login])

    try:
        if df.iloc[0]["user_password"] == password:
            if(df.iloc[0]["is_expert"] == "b'\x01'"):
                return 2
            else:
                return 1
    except:
        123

    sql_query = """SELECT * FROM admins WHERE admin_login = %s"""
    df = pd.read_sql_query(sql_query, connection, params=[login])
    try:
        if df.iloc[0]["admin_password"] == password:
            return 3
    except:
        return 0