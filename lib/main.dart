 import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const QuoteApp());
}

class QuoteApp extends StatelessWidget {
  const QuoteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: QuoteScreen(),
    );
  }
}

class QuoteScreen extends StatefulWidget {
  const QuoteScreen({super.key});

  @override
  State<QuoteScreen> createState() => _QuoteScreenState();
}

class _QuoteScreenState extends State<QuoteScreen> {
  // ✅ Working quote API
  final String quoteURL = "https://zenquotes.io/api/random";

  String quote = "Tap button to get quote";

  Future<void> generateQuote() async {
    try {
      var res = await http.get(Uri.parse(quoteURL));

      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);

        setState(() {
          // ✅ ZenQuotes parsing
          quote = "${data[0]['q']} — ${data[0]['a']}";
        });
      } else {
        setState(() {
          quote = "Failed to load quote";
        });
      }
    } catch (e) {
      setState(() {
        quote = "No internet connection";
      });
    }
  }

  @override
  void initState() {
    super.initState();
    generateQuote(); // ✅ App open hote hi first quote
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Random Quote Generator"),
        backgroundColor: Colors.cyanAccent,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                quote,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: generateQuote,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amberAccent,
                  foregroundColor: Colors.black,
                ),
                child: const Text("Generate Quote"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}