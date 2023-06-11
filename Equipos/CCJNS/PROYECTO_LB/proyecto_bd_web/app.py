from flask import Flask
from config import config


app= Flask(__name__)

@app.route("/")
def hello_world():
    return "<p>Hola mundooooo</p>"

if __name__ == "__main__":
    app.config.from_object(config['development'])
    app.run()