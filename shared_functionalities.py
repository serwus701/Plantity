from sqlalchemy import create_engine

from shared_sql_requests import sql_change_user_password, sql_change_admin_password

url = 'mysql://login_manager:loginpassword123@127.0.0.1/plants'
engine = create_engine(url)

user_logged = ""


# TODO: Add registration option

def change_user_password():
    connection = engine.connect()

    new_password = input("Insert new password")
    new_password_2 = input("insert password again")

    if new_password == new_password_2:
        sql_change_user_password(connection, new_password, user_logged)
    else:
        print("Passwords don't match")

    connection.close()


def change_admin_password():
    connection = engine.connect()

    new_password = input("Insert new password")
    new_password_2 = input("insert password again")

    if new_password == new_password_2:
        sql_change_admin_password(connection, new_password, user_logged)
    else:
        print("Passwords don't match")

    connection.close()


def exit_app():
    quit(0)


def report_an_issue():
    print("123")
