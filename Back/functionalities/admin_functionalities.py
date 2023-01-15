import sys

from sqlalchemy import create_engine

from functionalities.user_functionalities import search_for_plant_in_encyclopedia
from sql_requests.admin_sql_requests import sql_request_edit_if_expert, sql_request_delete_client, \
    sql_request_delete_record, sql_request_get_users

url = 'mysql://admin:789password@127.0.0.1/plants'
engine = create_engine(url)


def edit_if_expert(name_to_search, chosen_position):
    connection = engine.connect()

    users = get_users(name_to_search)

    try:
        sql_request_edit_if_expert(connection, users["user_login"][int(chosen_position)],
                                   str(users["is_expert"][int(chosen_position)])[5] == "0")
        connection.close()
        return True
    except:
        connection.close()
        return False


def delete_client(name_to_search, chosen_position):
    connection = engine.connect()

    users = get_users(name_to_search)

    try:
        sql_request_delete_client(connection, users["user_login"][int(chosen_position)])
        connection.close()
        return True
    except:
        connection.close()
        return False


# TODO: Rethink hide record
def hide_record():
    print("123")


def delete_record(position_input, search_text):
    connection = engine.connect()

    filtered_plants = search_for_plant_in_encyclopedia(search_text)

    try:
        sql_request_delete_record(connection, filtered_plants["species_name"][int(position_input)])
        connection.close()
        return True
    except:
        connection.close()
        return False


def get_users(name):
    connection = engine.connect()

    all_users = sql_request_get_users(connection)

    connection.close()
    return all_users
