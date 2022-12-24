import sys

from sqlalchemy import create_engine

from user_sql_requests import sql_request_search_for_plants

url = 'mysql://user:123password@127.0.0.1/plants'
engine = create_engine(url)
connection = engine.connect()

def search_for_plant_in_encyclopedia():
    user_input = input("Insert plant name")

    output = sql_request_search_for_plants(connection, user_input)

    for i in range(output[1]):
        sys.stdout.write(str(i))
        sys.stdout.write(": ")
        for j in range(7):
            sys.stdout.write(str(output[0][j][i]))
            sys.stdout.write(" | ")
        sys.stdout.write("\n")

def add_plant_to_library():
    print("123")

def show_library():
    print("123")

def show_plant_in_library():
    print("123")

def delete_from_library():
    print("123")
