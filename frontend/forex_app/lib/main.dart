import 'package:flutter/material.dart';
import 'forex_api.dart'; // Import the forex_api.dart file
// HomeScreen file
import 'sentiment_screen.dart'; // SentimentScreen file

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(), // Directly navigate to the HomeScreen
      routes: {
        '/home': (context) => const HomeScreen(),
        '/sentiment': (context) =>
            const SentimentScreen(), // Route for the Sentiment screen
        '/profile': (context) =>
            const ProfileScreen(), // Route for the Profile screen
        '/forexTrends': (context) =>
            const ForexTrendsScreen(), // Route for the Forex Trends screen
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forex Trend Sense'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/sentiment'); // Navigate to SentimentScreen
            },
            child: const Text("Go to Sentiment Analysis"),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/forexTrends'); // Navigate to ForexTrendsScreen
            },
            child: const Text("Go to Forex Trends"),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/profile'); // Navigate to ProfileScreen
            },
            child: const Text("Go to Profile"),
          ),
        ],
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: const Center(
        child: Text('Profile Screen'),
      ),
    );
  }
}

class ForexTrendsScreen extends StatefulWidget {
  const ForexTrendsScreen({super.key});

  @override
  _ForexTrendsScreenState createState() => _ForexTrendsScreenState();
}

class _ForexTrendsScreenState extends State<ForexTrendsScreen> {
  String exchangeRate =
      "Loading..."; // Default value while waiting for the API response

  // Function to fetch Forex data using ForexAPI
  Future<void> fetchForexData() async {
    try {
      String rate = (await ForexAPI.fetchExchangeRate("USD", "EUR")) as String;
      setState(() {
        exchangeRate = rate; // Update state with fetched exchange rate
      });
    } catch (e) {
      setState(() {
        exchangeRate = "Failed to fetch data."; // Handle error
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchForexData(); // Call the function when the screen is initialized
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forex Trends'),
      ),
      body: Center(
        child: Text('Exchange Rate (USD to EUR): $exchangeRate'),
      ),
    );
  }
}
