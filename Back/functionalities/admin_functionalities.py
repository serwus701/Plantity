import sys

from sqlalchemy import create_engine

from functionalities.user_functionalities import search_for_plant_in_encyclopedia
from sql_requests.admin_sql_requests import sql_request_edit_if_expert, sql_request_delete_client, \
    sql_request_delete_record, sql_request_get_users

url = 'mysql://admin:789password@127.0.0.1/plants'
engine = create_engine(url)


def edit_if_expert(user_login):
    connection = engine.connect()

    users = get_users()

    position = -1
    for i in range(len(users["user_login"])):
        if users["user_login"][i] == user_login:
            position = i

    print(position)

    if position == -1:
        return False

    try:
        sql_request_edit_if_expert(connection, user_login,
                                   str(users["is_expert"][position])[5] == "0")
        connection.close()
        return True
    except:
        connection.close()
        return False


def delete_client(user_login):
    connection = engine.connect()

    try:
        sql_request_delete_client(connection, user_login)
        connection.close()
        return True
    except:
        connection.close()
        return False


# TODO: Rethink hide record
def hide_record():
    print("123")


def delete_record(species_name):
    connection = engine.connect()

    try:
        sql_request_delete_record(connection, species_name)
        connection.close()
        return True
    except:
        connection.close()
        return False


def get_users():
    connection = engine.connect()

    all_users = sql_request_get_users(connection)

    connection.close()
    return all_users
