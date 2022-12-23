import pandas as pd
from sqlalchemy import create_engine
import pandas

url = 'mysql://user:123password@127.0.0.1/plants'
engine = create_engine(url)
connection = engine.connect()

def do_sum_sql_request():
    sql = "SELECT firstname FROM users"
    df = pd.read_sql_query(sql, engine)
    df.head()
    print(df)

def sql_request_login(login, password):
    return 1