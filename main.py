from shared_functionalities import start
from sqlalchemy import create_engine

from user_sql_requests import sql_request_search_for_plants, sql_request_get_plants_from_library

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