from sqlalchemy import create_engine

url = 'mysql://user:123password@127.0.0.1/plants'
engine = create_engine(url)
connection = engine.connect()

def search_for_plant():
    print("123")
