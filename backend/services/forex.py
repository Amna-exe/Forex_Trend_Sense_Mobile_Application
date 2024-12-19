import requests
#to get post, etc http requests from an external api

from config import ALPHA_VANTAGE_API_KEY

# Alpha Vantage URL
BASE_URL = 'https://www.alphavantage.co/query'

def fetch_exchange_rate(from_currency, to_currency):
    """
    Fetch real-time exchange rate between two currencies.
    :param from_currency: Base currency (e.g., USD)
    :param to_currency: Target currency (e.g., EUR)
    :return: JSON containing exchange rate
    """

    #parms is a python dictionar
    params = {
        'function': 'CURRENCY_EXCHANGE_RATE',
        'from_currency': from_currency,
        'to_currency': to_currency,
        'apikey': ALPHA_VANTAGE_API_KEY
    }
    try:
        response = requests.get(BASE_URL, params=params)
        #convert recieved data to python dictionary from the json format 
        data = response.json()
        return data.get('Realtime Currency Exchange Rate', {})
    except Exception as e:
        return {'error': f"Error fetching exchange rate: {str(e)}"}
