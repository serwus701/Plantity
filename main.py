import hashlib

from sqlalchemy import create_engine

from shared_functionalities import change_user_password
from shared_sql_requests import sql_change_admin_password
from startup_functionalities import start
url = 'mysql://login_manager:loginpassword123@127.0.0.1/plants'
engine = create_engine(url)

if __name__ == '__main__':
    """
    try:
        start()
    except:
        print("Wooops, something went wrong")
    url = 'mysql://user:123password@127.0.0.1/plants'
    engine = create_engine(url)
    connection = engine.connect()

    print(sql_request_get_plants_from_library(connection))
    """

    start()

    #change_user_password()
