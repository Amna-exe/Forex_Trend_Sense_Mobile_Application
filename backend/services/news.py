import requests
from config import NEWS_API_KEY

# News API URL
NEWS_API_URL = 'https://newsapi.org/v2/everything'

def fetch_news(query):
    """
    Fetch financial news based on a query keyword.
    :param query: Keyword to search for (e.g., USD, forex)
    :return: List of news articles
    """

    #so a dictionary called params which sends a query q and other things to the external api as a request.
    params = {
        'q': query,
        'apiKey': NEWS_API_KEY,
        'language': 'en'
    }
    try:
        response = requests.get(NEWS_API_URL, params=params)
        data = response.json()
        return data.get('articles', [])
    except Exception as e:
        return {'error': f"Error fetching news: {str(e)}"}
