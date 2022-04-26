from flask import Flask

app = Flask(__name__)

@app.route('/login')
def hello_world():
    return 'Hello World123!'