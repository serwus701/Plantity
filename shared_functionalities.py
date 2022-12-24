from UI import user_interface, expert_interface, admin_interface
from shared_sql_requests import sql_request_login

def start():
    app_is_open = True
    while app_is_open:
        login_input = input("insert login (type exit to quit app)")

        if login_input == 'exit':
            exit_app()

        password_input = input("insert password")

        if login(login_input, password_input) == 0:
            print("invalid login or password")

def login(login, password):
    login_result = sql_request_login(login, password)

    if login_result == 1:
        user_interface()
    elif login_result == 2:
        expert_interface()
    elif login_result == 3:
        admin_interface()
    return login_result


def exit_app():
    quit(0)

def report_an_issue():
    print("123")