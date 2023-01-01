import sys

from sqlalchemy import create_engine

from admin_sql_requests import sql_request_print_users, sql_request_edit_if_expert

url = 'mysql://admin:789password@127.0.0.1/plants'
engine = create_engine(url)


def edit_if_expert():
    connection = engine.connect()

    name_to_search = input("Input username")
    users = print_and_return_users(name_to_search)

    chosen_position = input("Insert position to make or unmake expert")

    sql_request_edit_if_expert(connection, users[2][int(chosen_position)],
                               str(users[3][int(chosen_position)])[5] == "0")

    connection.close()


def delete_client():
    print("123")


# TODO: Rethink hide record
def hide_record():
    print("123")


def delete_record():
    print("123")


def print_and_return_users(name):
    connection = engine.connect()

    all_users = sql_request_print_users(connection)

    for i in range(len(all_users[0])):
        if name.lower() in all_users[2][i].lower():
            sys.stdout.write(str(i) + ": " + all_users[0][i] + " " + all_users[1][i] + "\n")
            sys.stdout.write(all_users[2][i])
            if str(all_users[3][i])[5] == "1":
                sys.stdout.write(" Expert\n\n")
            else:
                sys.stdout.write(" User\n\n")

    connection.close()
    return all_users
