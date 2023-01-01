import pandas as pd

from tools import get_dataframe_size


def sql_request_print_users(connection):
    column_names = ["firstname", "lastname", "user_login", "is_expert"]
    users_details = [[], [], [], []]

    sql_query = """SELECT * FROM plants.users"""
    users_df = pd.read_sql_query(sql_query, connection)
    size = get_dataframe_size(users_df)

    for i in range(size):
        for j in range(4):
            users_details[j].insert(0, users_df.iloc[i][column_names[j]])

    return users_details


def sql_request_edit_if_expert(connection, username, is_expert):
    sql_query = """UPDATE plants.users SET is_expert = %s WHERE user_login = %s"""

    connection.execute(sql_query, (is_expert, username))
