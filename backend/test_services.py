# test_services.py

from services.forex import fetch_exchange_rate
from services.news import fetch_news

def test_fetch_forex():
    print("Testing Forex Data Fetching...")
    from_currency = 'USD'
    to_currency = 'EUR'
    result = fetch_exchange_rate(from_currency, to_currency)
    print(result)  # Display the output

def test_fetch_news():
    print("Testing News Data Fetching...")
    query = 'nintendo'
    articles = fetch_news(query)
    for article in articles[:10]:  # Display the top 3 articles
        print(f"{article['title']} - {article['source']['name']}")

if __name__ == '__main__':
    print("Running tests...\n")
    test_fetch_forex()
    print("\n")
    test_fetch_news()
