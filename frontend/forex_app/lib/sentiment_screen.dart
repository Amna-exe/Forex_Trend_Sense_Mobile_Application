import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'forex_api.dart';

class SentimentScreen extends StatefulWidget {
  const SentimentScreen({super.key});

  @override
  _SentimentScreenState createState() => _SentimentScreenState();
}

class _SentimentScreenState extends State<SentimentScreen> {
  String selectedCurrency = "USD";
  Map<String, double> sentimentData = {};
  List<String> currencyList = ['USD', 'EUR', 'GBP', 'JPY', 'AUD'];
  bool isLoading = false;

  // Function to fetch sentiment data for the selected currency
  Future<void> fetchSentiment(String currency) async {
    setState(() {
      isLoading = true;
      sentimentData = {}; // Clear previous data
    });
    try {
      final sentiment = await ForexAPI.fetchSentiment(currency);
      setState(() {
        sentimentData = {
          "Positive": sentiment['sentiment']['positive'] ?? 0.0,
          "Negative": sentiment['sentiment']['negative'] ?? 0.0,
          "Neutral": sentiment['sentiment']['neutral'] ?? 0.0,
        };
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        sentimentData = {
          "Error": 1.0,
        };
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchSentiment(selectedCurrency); // Initial fetch for default currency
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sentiment Analysis'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Dropdown menu for selecting a currency
            DropdownButton<String>(
              value: selectedCurrency,
              items: currencyList.map((currency) {
                return DropdownMenuItem<String>(
                  value: currency,
                  child: Text(currency),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedCurrency = value!;
                });
                fetchSentiment(value!);
              },
            ),

            const SizedBox(height: 20),

            // Pie chart or loading indicator
            isLoading
                ? const Center(child: CircularProgressIndicator())
                : sentimentData.isNotEmpty
                    ? PieChart(
                        dataMap: sentimentData,
                        chartType: ChartType.ring,
                        legendOptions: const LegendOptions(
                          showLegendsInRow: true,
                          legendPosition: LegendPosition.bottom,
                        ),
                      )
                    : const Center(child: Text("No sentiment data available")),
          ],
        ),
      ),
    );
  }
}
