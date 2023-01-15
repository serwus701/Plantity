import pandas as pd

from tools import get_dataframe_size, get_library_id


def sql_request_search_for_plants(connection, search_text):
    plants_details = {"photo_id": [], "species_name": [], "species_description": [], "how_often_to_water": [],
                      "amount_of_sun": [], "amount_of_water": [], "difficulty": []}

    sql_query = """SELECT * FROM plants.encyclopedia"""

    df = pd.read_sql_query(sql_query, connection)

    size = get_dataframe_size(df)

    for i in range(size):
        if search_text.lower() in df.iloc[i]["species_name"].lower():
            for key in plants_details:
                if str(type(df.iloc[i][key])) == "<class 'numpy.int64'>":
                    plants_details[key].insert(0, int(df.iloc[i][key]))
                else:
                    plants_details[key].insert(0, df.iloc[i][key])

    return plants_details


def sql_request_add_plant_to_library(connection, species_name, plant_nickname, user_logged):
    sql_query = """SELECT species_id FROM plants.encyclopedia WHERE species_name = %s"""
    df = pd.read_sql_query(sql_query, connection, params=[species_name])
    species_id = df.iloc[0]["species_id"]

    library_id = get_library_id(user_logged)

    sql_query = """INSERT INTO plants.plants (plant_name, species_id, library_id) VALUES (%s, %s, %s)"""
    connection.execute(sql_query, (plant_nickname, species_id, library_id))


def sql_request_get_plants_from_library(connection, user_logged):
    plants_details = {"plant_name": [], "photo_id": [], "species_name": [], "species_description": [],
                      "how_often_to_water": [],
                      "amount_of_sun": [], "amount_of_water": [], "difficulty": []}

    library_id = get_library_id(user_logged)

    sql_query = """SELECT * FROM plants.plants WHERE library_id = %s"""
    library_items_df = pd.read_sql_query(sql_query, connection, params=[library_id])

    size = get_dataframe_size(library_items_df)

    for i in range(size):
        sql_query = """SELECT * FROM plants.encyclopedia WHERE species_id = %s"""
        df = pd.read_sql_query(sql_query, connection, params=[library_items_df.iloc[i]["species_id"]])
        species_name = df.iloc[0]["species_name"]

        sql_query = """SELECT * FROM plants.encyclopedia WHERE species_name = %s"""
        species_df = pd.read_sql_query(sql_query, connection, params=[species_name])

        plants_details["plant_name"].insert(i, library_items_df.iloc[i]["plant_name"])

        for key in plants_details:
            if key == "plant_name":
                continue
            if str(type(species_df.iloc[0][key])) == "<class 'numpy.int64'>":
                plants_details[key].insert(i, int(species_df.iloc[0][key]))
            else:
                plants_details[key].insert(i, species_df.iloc[0][key])

    return plants_details

#TODO: delete request deletes all plants named like this (!!!)
def sql_request_delete_from_library(connection, plant_nickname):
    sql_query = """DELETE FROM plants.plants WHERE plant_name = %s"""
    connection.execute(sql_query, plant_nickname)
