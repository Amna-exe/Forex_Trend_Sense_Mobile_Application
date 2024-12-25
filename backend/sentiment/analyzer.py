from flask import app, jsonify, request
from textblob import TextBlob

def analyze_sentiment(text):
    """
    Analyze the sentiment of the given text using TextBlob.

    Args:
        text (str): The text to analyze.

    Returns:
        str: The sentiment classification ('positive', 'negative', or 'neutral').
    """
    blob = TextBlob(text)
    polarity = blob.sentiment.polarity

    # Classify sentiment based on polarity score
    if polarity > 0:
        return "positive"
    elif polarity < 0:
        return "negative"
    else:
        return "neutral"

