from sqlalchemy import create_engine

from functionalities import shared_functionalities
from sql_requests.shared_sql_requests import sql_request_login, sql_request_register



def login(login, password):
    url = 'mysql://login_manager:loginpassword123@127.0.0.1/plants'
    engine = create_engine(url)
    connection = engine.connect()

    login_result = sql_request_login(connection, login, password)

    if login_result != 0:
        shared_functionalities.user_logged = login

    connection.close()

    return login_result


def register(firstname, lastname, user_login, password):
    url = 'mysql://login_manager:loginpassword123@127.0.0.1/plants'
    engine = create_engine(url)
    connection = engine.connect()

    try:
        sql_request_register(connection, firstname, lastname, user_login, password)
        connection.close()
        return True
    except:
        connection.close()
        return False



