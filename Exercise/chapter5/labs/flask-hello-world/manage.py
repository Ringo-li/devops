from flask import Flask
import os

app = Flask(__name__)


@app.route('/')
def hello():
    print 'hello world'

if __name__ == "__main__":
    app.run()
