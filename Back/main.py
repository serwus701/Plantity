import json

from flask import Flask, jsonify, request
import json
from functionalities.startup_functionalities import login

app = Flask(__name__)


@app.route('/login', methods=['POST'])
def get_data():
    data = json.loads(request.data)
    username = data['username']
    password = data['password']

    answer = {'approval': login(username, password)}
    return jsonify(answer)


if __name__ == '__main__':
    app.run(debug=True)
