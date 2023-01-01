import pandas as pd
from sqlalchemy import create_engine

url = 'mysql://login_manager:loginpassword123@127.0.0.1/plants'
engine = create_engine(url)
connection = engine.connect()


def sql_request_login(login, password):
    sql_query = """SELECT * FROM users WHERE user_login = %s"""

    df = pd.read_sql_query(sql_query, connection, params=[login])

    try:
        if df.iloc[0]["user_password"] == password:
            if str(df.iloc[0]["is_expert"])[5] == "1":
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
