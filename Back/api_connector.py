from flask import Flask, request

app = Flask(__name__)

@app.route('/data', methods=['POST'])
def data():
    data = request.get_json()
    print(data)
    return 'Data received'