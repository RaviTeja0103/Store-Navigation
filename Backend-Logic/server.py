from flask import Flask,make_response

app = Flask(__name__)



@app.route('/')
def Navigation_path():
    response = make_response("Hello World")
    response.headers['Access-Control-Allow-Origin'] = '*'
    response.headers['Access-Control-Allow-Headers'] = 'Content-Type'
    return response

if __name__ == '__main__':
    app.run()
