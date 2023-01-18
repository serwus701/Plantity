from sqlalchemy import create_engine

from sql_requests.user_sql_requests import sql_request_search_for_plants, sql_request_add_plant_to_library, \
    sql_request_get_plants_from_library, sql_request_delete_from_library

url = 'mysql://user:123password@127.0.0.1/plants'
engine = create_engine(url)


def search_for_plant_in_encyclopedia(user_search):
    connection = engine.connect()

    filtered_plants = sql_request_search_for_plants(connection, user_search)

    connection.close()
    return filtered_plants


def add_plant_to_library(plant_nickname, species_name, user_logged):
    connection = engine.connect()

    try:
        sql_request_add_plant_to_library(connection, species_name,
                                         plant_nickname, user_logged)
        connection.close()
        return True
    except Exception as e:
        print(e)
    connection.close()
    return False


def show_library(user_logged):
    connection = engine.connect()

    plants_from_library = sql_request_get_plants_from_library(connection, user_logged)

    connection.close()

    return plants_from_library


def delete_from_library(plant_numer_to_delete, user_logged):
    connection = engine.connect()

    plants_from_library = sql_request_get_plants_from_library(connection, user_logged)

    try:
        plant_nickname = plants_from_library["plant_name"][int(plant_numer_to_delete)]
        sql_request_delete_from_library(connection, plant_nickname)
        connection.close()
        return True
    except:
        connection.close()
        return False
