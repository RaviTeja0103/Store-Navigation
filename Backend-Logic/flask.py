from flask import Flask

app = Flask(__name__)



@app.route('/')
def Navigation_path():
    return "Hello world"

if __name__ == '__main__':
    app.run()