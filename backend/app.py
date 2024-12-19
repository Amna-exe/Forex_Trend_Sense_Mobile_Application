# backend/app.py
from flask_cors import CORS

from flask import Flask, jsonify
from services.forex import fetch_exchange_rate
from services.news import fetch_news

app = Flask(__name__)

CORS(app)
@app.route('/forex/<from_currency>/<to_currency>', methods=['GET'])
def get_forex_data(from_currency, to_currency):
    exchange_rate = fetch_exchange_rate(from_currency, to_currency)
    return jsonify(exchange_rate)

@app.route('/news/<query>', methods=['GET'])
def get_news_data(query):
    news = fetch_news(query)
    return jsonify(news)

if __name__ == '__main__':
    app.run(debug=True)
