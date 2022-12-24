from sqlalchemy import create_engine

from user_sql_requests import sql_request_search_for_plants

url = 'mysql://user:123password@127.0.0.1/plants'
engine = create_engine(url)
connection = engine.connect()

def search_for_plant():
    user_input = input("Insert plant name")

    print(sql_request_search_for_plants(connection, user_input))
