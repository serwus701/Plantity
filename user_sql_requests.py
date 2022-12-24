import pandas as pd

from tools import get_dataframe_size


def sql_request_search_for_plants(connection, search_text):
    column_names = ["photo_id", "species_name", "species_description", "how_often_to_water", "amount_of_sun", "amount_of_water", "difficulty"]
    result_array = [[], [], [], [], [], [], []]

    sql_query = """SELECT * FROM plants.encyclopedia WHERE species_name = %s"""

    df = pd.read_sql_query(sql_query, connection, params=[search_text])

    size = get_dataframe_size(df)

    for i in range(size):
        for j in range(7):
            result_array[j].insert(0, df.iloc[i][column_names[j]])

    return result_array




