import 'package:http/http.dart' as http;
import 'dart:convert';

class ForexAPI {
  // Fetch exchange rate
  static Future<Map<String, dynamic>> fetchExchangeRate(String fromCurrency, String toCurrency) async {
    final url = 'https://forex-trend-sense-mobile-application.vercel.app/forex?from_currency=$fromCurrency&to_currency=$toCurrency'; // Updated Vercel URL
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      if (data.containsKey('error')) {
        throw Exception("API Error: ${data['error']}");
      }

      return data; // Return the entire JSON object (e.g., exchange rate and other details)
    } else {
      throw Exception("Failed to load Forex data");
    }
  }

  // Fetch sentiment analysis for a specific text
  static Future<Map<String, dynamic>> fetchSentiment(String text) async {
    const url = 'https://forex-trend-sense-mobile-application.vercel.app/sentiment';
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'text': text}),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      if (data.containsKey('error')) {
        throw Exception("API Error: ${data['error']}");
      }

      return data; // Return sentiment analysis result
    } else {
      throw Exception("Failed to analyze sentiment");
    }
  }
}
