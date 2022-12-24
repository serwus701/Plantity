from UI import user_interface, expert_interface, admin_interface
from shared_sql_requests import sql_request_login

def start():
    app_is_open = True
    while app_is_open:
        login_input = input("insert login")

        if login_input == 'exit':
            exit_app()

        password_input = input("insert password")

        login(login_input, password_input)

def login(login, password):
    if sql_request_login(login, password) == 1:
        user_interface()
    elif sql_request_login(login, password) == 2:
        expert_interface()
    elif sql_request_login(login, password) == 3:
        admin_interface()

def exit_app():
    quit(0)