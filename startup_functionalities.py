from sqlalchemy import create_engine

import shared_functionalities
from UI import user_interface, expert_interface, admin_interface
from shared_functionalities import exit_app
from shared_sql_requests import sql_request_login, sql_request_register


def start():
    app_is_open = True
    while app_is_open:
        login_input = input("insert login (type exit to quit app, type register to create account)")

        if login_input == 'exit':
            exit_app()

        if login_input == "register":
            register()
            continue

        password_input = input("insert password")

        if login(login_input, password_input) == 0:
            print("invalid login or password")


def login(login, password):
    url = 'mysql://login_manager:loginpassword123@127.0.0.1/plants'
    engine = create_engine(url)
    connection = engine.connect()

    login_result = sql_request_login(connection, login, password)

    connection.close()

    if login_result == 1:
        shared_functionalities.user_logged = login
        user_interface()
    elif login_result == 2:
        shared_functionalities.user_logged = login
        expert_interface()
    elif login_result == 3:
        shared_functionalities.user_logged = login
        admin_interface()
    return login_result


def register():
    url = 'mysql://login_manager:loginpassword123@127.0.0.1/plants'
    engine = create_engine(url)
    connection = engine.connect()

    firstname = input("Insert your firstname")
    lastname = input("Insert your lastname")
    user_login = input("Insert your login")
    password = input("Insert your password")

    try:
        sql_request_register(connection, firstname, lastname, user_login, password)
    except:
        print("username taken")

    connection.close()


