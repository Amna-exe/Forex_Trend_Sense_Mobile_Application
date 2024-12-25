from flask import Flask, request, jsonify
from flask_cors import CORS
from services.forex import fetch_exchange_rate
from services.news import fetch_news
from sentiment.analyzer import analyze_sentiment

app = Flask(__name__)
CORS(app)  # Allow requests from frontend

@app.route('/forex', methods=['GET'])
def get_forex_rate():
    from_currency = request.args.get('from_currency')
    to_currency = request.args.get('to_currency')
    if not from_currency or not to_currency:
        return jsonify({'error': 'Both from_currency and to_currency are required'}), 400
    data = fetch_exchange_rate(from_currency, to_currency)
    return jsonify(data)

@app.route('/news', methods=['GET'])
def get_news():
    query = request.args.get('query', 'forex trading')
    articles = fetch_news(query)
    return jsonify({'articles': articles})


@app.route('/sentiment', methods=['POST'])
def get_sentiment():
    data = request.json
    if not data or 'text' not in data:
        return jsonify({'error': 'Text is required'}), 400

    # Perform sentiment analysis
    sentiment = analyze_sentiment(data['text'])

    # Return result
    return jsonify({'text': data['text'], 'sentiment': sentiment})

if __name__ == '__main__':
    app.run(debug=True)

