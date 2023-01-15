import pandas as pd

from tools import get_dataframe_size, get_library_id


def sql_request_get_users(connection):
    users_details = {"firstname": [], "lastname": [], "user_login": [], "is_expert": []}

    sql_query = """SELECT * FROM plants.users"""
    users_df = pd.read_sql_query(sql_query, connection)
    size = get_dataframe_size(users_df)

    for i in range(size):
        for key in users_details:
            users_details[key].insert(i, users_df.iloc[i][key])

    return users_details


def sql_request_edit_if_expert(connection, username, is_expert):
    sql_query = """UPDATE plants.users SET is_expert = %s WHERE user_login = %s"""

    connection.execute(sql_query, (is_expert, username))


def sql_request_delete_record(connection, plant_name):
    sql_query = """DELETE FROM plants.encyclopedia WHERE species_name = %s"""

    connection.execute(sql_query, plant_name)


def sql_request_delete_client(connection, user_login):
    sql_query = """DELETE FROM plants.plants WHERE library_id = %s"""

    connection.execute(sql_query, get_library_id(user_login))

    sql_query = """DELETE FROM plants.libraries WHERE library_id = %s"""

    connection.execute(sql_query, get_library_id(user_login))

    sql_query = """DELETE FROM plants.users WHERE user_login = %s"""

    connection.execute(sql_query, user_login)
