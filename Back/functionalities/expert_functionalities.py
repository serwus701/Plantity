from sqlalchemy import create_engine

from functionalities.user_functionalities import search_for_plant_in_encyclopedia
from sql_requests.expert_sql_requests import sql_request_add_plant_to_encyclopedia, sql_request_edit_plant_description

url = 'mysql://expert:456password@127.0.0.1/plants'
engine = create_engine(url)


def input_check(input):
    try:
        if int(input) >= 10:
            raise Exception("Invalid number - too big number")
        else:
            return
    except:
        raise Exception("Invalid number - not integer")


def add_plant_to_encyclopedia(user_input):
    connection = engine.connect()

    try:
        sql_request_add_plant_to_encyclopedia(connection, user_input)
        connection.close()
        return True
    except:
        connection.close()
        return False


def edit_plant_description(position_input, new_plant_description, search_input):
    connection = engine.connect()
    plant_details = search_for_plant_in_encyclopedia(search_input)

    if 0 <= int(position_input) < len(plant_details["species_name"]):

        try:
            sql_request_edit_plant_description(connection, plant_details["species_name"][int(position_input)],
                                               new_plant_description)
            connection.close()
            return True
        except:
            connection.close()
            return False
