from sqlalchemy import create_engine

from expert_sql_requests import sql_request_add_plant_to_encyclopedia

url = 'mysql://expert:456password@127.0.0.1/plants'
engine = create_engine(url)
connection = engine.connect()


def add_plant_to_encyclopedia():
    user_input = []
    user_input.insert(0, input("Insert photo ID"))
    user_input.insert(0, input("Insert species name"))
    user_input.insert(0, input("Insert species description"))
    user_input.insert(0, input("Insert how often to water"))
    user_input.insert(0, input("Insert amount of sun"))
    user_input.insert(0, input("Insert amount of water"))
    user_input.insert(0, input("Insert difficulty"))

    user_input.reverse()

    sql_request_add_plant_to_encyclopedia(connection, user_input)


def edit_plant_description():
    print("123")
