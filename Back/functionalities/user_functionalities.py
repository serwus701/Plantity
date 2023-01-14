import sys
from sqlalchemy import create_engine

from sql_requests.user_sql_requests import sql_request_search_for_plants, sql_request_add_plant_to_library, \
    sql_request_get_plants_from_library, sql_request_delete_from_library

url = 'mysql://user:123password@127.0.0.1/plants'
engine = create_engine(url)


def search_for_plant_in_encyclopedia():
    connection = engine.connect()

    user_input = input("Insert plant name")

    filtered_plants = sql_request_search_for_plants(connection, user_input)

    size = len(filtered_plants["species_name"])

    for i in range(size):
        sys.stdout.write(str(i))
        sys.stdout.write(": ")
        for key in filtered_plants:
            sys.stdout.write(str(filtered_plants[key][i]))
            sys.stdout.write(" | ")
        sys.stdout.write("\n")

    connection.close()
    return filtered_plants


def add_plant_to_library():
    connection = engine.connect()

    filtered_plants = search_for_plant_in_encyclopedia()

    position_input = input("insert record position to add")

    if 0 <= int(position_input) < len(filtered_plants["species_name"]):
        plant_nickname = input("insert plant nickname")
        sql_request_add_plant_to_library(connection, filtered_plants["species_name"][int(position_input)],
                                         plant_nickname)

    connection.close()


def show_library():
    connection = engine.connect()

    plants_from_library = sql_request_get_plants_from_library(connection)

    print_library_plants_headers(plants_from_library)

    loop = True
    while loop:
        plant_nickname_filter = input("insert plant nickname filter to show details (type exit to leave loop)")
        if plant_nickname_filter == "exit":
            loop = False
            continue
        print_detailed_library(plant_nickname_filter)

    connection.close()


def print_detailed_library(plant_nickname_filter):
    connection = engine.connect()

    plants_from_library = sql_request_get_plants_from_library(connection)

    size = len(plants_from_library["plant_name"])

    for i in range(size):
        if plant_nickname_filter.lower() not in plants_from_library["plant_name"][i]:
            continue
        sys.stdout.write("Plant nickname: " + str(plants_from_library["plant_name"][i]) + "\n")
        sys.stdout.write("Species name: " + str(plants_from_library["species_name"][i]) + "\n")
        sys.stdout.write("Description: " + str(plants_from_library["species_description"][i]) + "\n")
        sys.stdout.write(
            "How often to water: " + str(plants_from_library["how_often_to_water"][i]) + ", Amount of sun: " + str(
                plants_from_library["amount_of_sun"][i]) + "\n")
        sys.stdout.write("Amount of water: " + str(plants_from_library["amount_of_water"][i]) + ", Difficulty: " + str(
            plants_from_library["difficulty"][i]) + "\n\n")

    connection.close()


def delete_from_library():
    connection = engine.connect()

    plants_from_library = sql_request_get_plants_from_library(connection)

    print_library_plants_headers(plants_from_library)

    plant_numer_to_delete = input("Insert plant position to delete:")
    try:
        plant_nickname = plants_from_library["plant_name"][int(plant_numer_to_delete)]
        sql_request_delete_from_library(connection, plant_nickname)
    except:
        print("invalid number")

    connection.close()


def print_library_plants_headers(plants_from_library):
    sys.stdout.write("\n")
    size = len(plants_from_library["plant_name"])

    for i in range(size):
        sys.stdout.write(str(i) + ": Plant nickname: " + str(plants_from_library["plant_name"][i]) + "\n")
        sys.stdout.write("Species name: " + str(plants_from_library["species_name"][i]) + "\n\n")
