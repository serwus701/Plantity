from UI import user_interface, expert_interface, admin_interface
from sql_requests import sql_request_login

def start():
    login = input("insert login")
    password = input("insert password")
    login(login, password)

def login(login, password):
    if sql_request_login(login, password) == 1:
        user_interface()
    elif sql_request_login(login, password) == 2:
        expert_interface()
    elif sql_request_login(login, password) == 3:
        admin_interface()