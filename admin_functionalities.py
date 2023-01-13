import sys

from sqlalchemy import create_engine

from admin_sql_requests import sql_request_print_users, sql_request_edit_if_expert, sql_request_delete_record, \
    sql_request_delete_client
from user_functionalities import search_for_plant_in_encyclopedia

url = 'mysql://admin:789password@127.0.0.1/plants'
engine = create_engine(url)


def edit_if_expert():
    connection = engine.connect()

    name_to_search = input("Input username")
    users = print_and_return_users(name_to_search)

    chosen_position = input("Insert position to make or unmake expert")

    try:
        if 0 <= int(chosen_position) < len(users["user_login"]):
            sql_request_edit_if_expert(connection, users["user_login"][int(chosen_position)],
                                       str(users["is_expert"][int(chosen_position)])[5] == "0")
        else:
            print("Invalid input - not in range")
    except:
        print("Invalid input - not int")

    connection.close()


def delete_client():
    connection = engine.connect()

    name_to_search = input("Input username")
    users = print_and_return_users(name_to_search)

    chosen_position = input("Insert position to delete client")

    try:
        if 0 <= int(chosen_position) < len(users["user_login"]):
            sql_request_delete_client(connection, users["user_login"][int(chosen_position)])
        else:
            print("Invalid input - not in range")
    except:
        print("Invalid input - not int")

    connection.close()


# TODO: Rethink hide record
def hide_record():
    print("123")


def delete_record():
    connection = engine.connect()

    filtered_plants = search_for_plant_in_encyclopedia()
    position_input = input("insert record position to delete")

    try:
        if 0 <= int(position_input) < len(filtered_plants["species_name"]):
            sql_request_delete_record(connection, filtered_plants["species_name"][int(position_input)])
        else:
            print("Invalid input - not in range")
    except:
        print("Invalid input - not int")

    connection.close()


def print_and_return_users(name):
    connection = engine.connect()

    all_users = sql_request_print_users(connection)

    size = len(all_users["user_login"])

    for i in range(size):
        if name.lower() in all_users["user_login"][i].lower():
            sys.stdout.write(str(i) + ": " + all_users["firstname"][i] + " " + all_users["lastname"][i] + "\n")
            sys.stdout.write(all_users["user_login"][i])
            if str(all_users["is_expert"][i])[5] == "1":
                sys.stdout.write(" Expert\n\n")
            else:
                sys.stdout.write(" User\n\n")

    connection.close()
    return all_users
