from flask import Flask

app = Flask(__name__)
import api_handling.shared_api_handling
import api_handling.user_api_handling
import api_handling.expert_api_handling
import api_handling.admin_api_handling

if __name__ == '__main__':
    app.run(debug=True)
