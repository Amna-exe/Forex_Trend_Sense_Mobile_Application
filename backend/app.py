# backend/app.py
from flask_cors import CORS

from flask import Flask, jsonify
from services.forex import fetch_exchange_rate
from services.news import fetch_news

app = Flask(__name__)

CORS(app)

@app.route('/')
def home():
    return "Welcome to the Forex and News API!"


@app.route('/forex/<from_currency>/<to_currency>', methods=['GET'])
def get_forex_data(from_currency, to_currency):
    exchange_rate = fetch_exchange_rate(from_currency, to_currency)
    return jsonify(exchange_rate)

@app.route('/news/<query>', methods=['GET'])
def get_news_data(query):
    news = fetch_news(query)
    return jsonify(news)

def handler(request):
    # Extract from_currency and to_currency from the URL parameters
    from_currency = request.args.get('from_currency', 'USD')
    to_currency = request.args.get('to_currency', 'EUR')

    # Fetch exchange rate data
    exchange_rate = fetch_exchange_rate(from_currency, to_currency)

    # Return the response as JSON
    return jsonify(exchange_rate)

if __name__ == '__main__':
    app.run(debug=True)
