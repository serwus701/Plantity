from sqlalchemy import create_engine

from expert_sql_requests import sql_request_add_plant_to_encyclopedia, sql_request_edit_plant_description
from user_functionalities import search_for_plant_in_encyclopedia

url = 'mysql://expert:456password@127.0.0.1/plants'
engine = create_engine(url)


def add_plant_to_encyclopedia():
    connection = engine.connect()

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

    connection.close()


def edit_plant_description():
    connection = engine.connect()
    plant_details = search_for_plant_in_encyclopedia()

    position_input = input("insert position to edit description")
    if 0 <= int(position_input) < len(plant_details["species_name"]):
        new_plant_description = input("insert new plant description: ")
        sql_request_edit_plant_description(connection, plant_details["species_name"][int(position_input)],
                                           new_plant_description)

    connection.close()
