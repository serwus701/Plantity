# import base64
# import json
# from flask import jsonify, request
# import json
# from __main__ import app
# import cv2
# import numpy as np
# import pandas as pd
# from sqlalchemy import create_engine
# from PIL import Image
#
# url = 'mysql://admin:789password@127.0.0.1/plants'
# engine = create_engine(url)
# connection = engine.connect()
# def read_file(filename):
#     # Convert digital data to binary format
#     with open(filename, 'rb') as file:
#         binaryData = file.read()
#     return binaryData
#
#
# def insertBLOB(species_id, species_name, photo_path):
#     print("Inserting BLOB into python_employee table")
#     sql_insert_blob_query = """ INSERT INTO plants.encyclopedia
#                           (species_id, species_name, photo) VALUES (%s,%s,%s)"""
#
#     plant_photo = read_file(photo_path)
#
#     # Convert data into tuple format
#     insert_blob_tuple = (species_id, species_name, plant_photo)
#     connection.execute(sql_insert_blob_query, insert_blob_tuple)
#
#
# def blob_to_base64(blob):
#     # Convert the BLOB data to a numpy array
#     image = np.asarray(bytearray(blob), dtype=np.uint8)
#
#     # Decode the image using OpenCV
#     image = cv2.imdecode(image, cv2.IMREAD_UNCHANGED)
#
#     # Encode the image data as a Base64 string
#     _, encoding = cv2.imencode('.jpg', image)
#     image_base64 = base64.b64encode(encoding).decode('utf-8')
#
#     return image_base64
#
# def send_blob_as_json(blob):
#     image_base64 = blob_to_base64(blob)
#
#     # Create a dictionary to store the image data
#     image_data = {'image': image_base64}
#
#     # Serialize the dictionary into a JSON string
#     json_data = json.dumps(image_data)
#
# def showBLOB():
#     sql_query = """SELECT * FROM plants.encyclopedia"""
#
#     df = pd.read_sql_query(sql_query, connection)
#     blob_image = df.iloc[3]["photo"]
#
#     image = np.asarray(bytearray(blob_image), dtype=np.uint8)
#
#     # Decode the image using OpenCV
#     image = cv2.imdecode(image, cv2.IMREAD_UNCHANGED)
#
#     # Display the image using OpenCV
#     cv2.imshow("Image", image)
#     cv2.waitKey(0)
#     cv2.destroyAllWindows()



