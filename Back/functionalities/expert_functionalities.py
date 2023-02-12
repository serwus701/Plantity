from sqlalchemy import create_engine

from sql_requests.expert_sql_requests import sql_request_add_plant_to_encyclopedia, sql_request_edit_plant_description

url = 'mysql://expert:456password@127.0.0.1/plants'
engine = create_engine(url)


def add_plant_to_encyclopedia(user_input):
    connection = engine.connect()

    try:
        sql_request_add_plant_to_encyclopedia(connection, user_input)
        connection.close()
        return True
    except:
        connection.close()
        return False


def edit_plant_description(species_name, new_plant_description):
    connection = engine.connect()

    try:
        sql_request_edit_plant_description(connection, species_name,
                                           new_plant_description)
        connection.close()
        return True
    except:
        connection.close()
        return False


def edit_plant_photo(species_name, photo):
    connection = engine.connect()

    try:
        sql_request_edit_plant_photo(connection, species_name,
                                     photo)
        connection.close()
        return True
    except:
        connection.close()
        return False
