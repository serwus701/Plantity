import base64

import cv2
import numpy as np
import pandas as pd
from sqlalchemy import create_engine

url = 'mysql://login_manager:loginpassword123@127.0.0.1/plants'
engine = create_engine(url)
connection = engine.connect()


def get_dataframe_size(df):
    size = 0

    while True:
        try:
            df.iloc[size]
            size += 1
        except:
            return size


def blob_to_base64(blob):
    try:
        # Convert the BLOB data to a numpy array
        image = np.asarray(bytearray(blob), dtype=np.uint8)

        # Decode the image using OpenCV
        image = cv2.imdecode(image, cv2.IMREAD_UNCHANGED)

        # Encode the image data as a Base64 string
        _, encoding = cv2.imencode('.jpg', image)
        image_base64 = base64.b64encode(encoding).decode('utf-8')
    except:
        with open("image.jpg", "rb") as image_file:
            image_base64 = base64.b64encode(image_file.read()).decode('utf-8')

        return image_base64


def base64_to_blob(base64_string):
    binary_data = base64.b64decode(base64_string)
    return binary_data


def get_library_id(user_login):
    try:
        sql_query = """SELECT user_id FROM plants.users WHERE user_login = %s"""
        df = pd.read_sql_query(sql_query, connection, params=[user_login])
        user_id = df.iloc[0]["user_id"]
    except Exception as e:
        print(e)

    sql_query = """SELECT library_id FROM plants.libraries WHERE user_id = %s"""
    df = pd.read_sql_query(sql_query, connection, params=[user_id])
    library_id = df.iloc[0]["library_id"]

    return library_id

# TODO: conection manager
