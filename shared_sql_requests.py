import pandas as pd
import hashlib

def sql_change_user_password(connection, new_password, user_name):
    sql_query = """UPDATE plants.users SET user_password = %s WHERE user_login = %s"""
    connection.execute(sql_query,
                       (hashlib.sha256(new_password.encode()).hexdigest(), user_name))


def sql_change_admin_password(connection, new_password, user_name):
    sql_query = """UPDATE plants.admins SET admin_password = %s WHERE admin_login = %s"""
    connection.execute(sql_query,
                       (hashlib.sha256(new_password.encode()).hexdigest(), user_name))


def sql_request_login(connection, login, password):
    sql_query = """SELECT * FROM users WHERE user_login = %s"""

    df = pd.read_sql_query(sql_query, connection, params=[login])

    try:
        if df.iloc[0]["user_password"] == hashlib.sha256(password.encode()).hexdigest():
            if str(df.iloc[0]["is_expert"])[5] == "1":
                return 2
            else:
                return 1
    except:
        sql_query = """SELECT * FROM admins WHERE admin_login = %s"""
        df = pd.read_sql_query(sql_query, connection, params=[login])
        try:
            if df.iloc[0]["admin_password"] == hashlib.sha256(password.encode()).hexdigest():
                return 3
        except:
            return 0

    return 0
