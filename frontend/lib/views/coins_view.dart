import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// This is CoinsView, for buying coins from store
class CoinsView extends StatefulWidget {
  const CoinsView({super.key});

  @override
  State<CoinsView> createState() => _CoinsViewState();
}

class _CoinsViewState extends State<CoinsView> {
  List<Map<String, dynamic>> coinPackages = [];

  @override
  void initState() {
    super.initState();
    loadCoinPackages();
  }

  ///TODO: Config a file in firestore and fetch the packages prices
  Future<void> loadCoinPackages() async {
    final String jsonString =
        await rootBundle.loadString('lib/assets/json/coin_packages.json');
    final List<dynamic> data = json.decode(jsonString);
    setState(() {
      coinPackages = List<Map<String, dynamic>>.from(data);
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
      
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Coin Store",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              ),
              Expanded(
                child: GridView.builder(
                  itemCount: coinPackages.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // 2 per row
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 3 / 4,
                  ),
                  itemBuilder: (context, index) {
                    final pkg = coinPackages[index];
                    return CoinCard(
                      label: pkg['label'],
                      coinCount: pkg['coins'],
                      price: pkg['price'].toDouble(),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CoinCard extends StatelessWidget {
  final String label;
  final int coinCount;
  final double price;
  final String imagePath = 'lib/assets/images/coin-zuggled.png';

  const CoinCard({
    super.key,
    required this.label,
    required this.coinCount,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Theme.of(context).colorScheme.outlineVariant),
      ),
      elevation: 0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 110,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xFFF0ECF9),
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.asset(
                imagePath,
                fit: BoxFit.contain,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            label,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 2),
          Text(
            '$coinCount Coins',
            style: const TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 8),
          TextButton(
            onPressed: () {
              // Handle top-up logic here (e.g., open payment gateway)
            },
            style: TextButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
            ),
            child: Text(
              '₹${price.toStringAsFixed(0)}',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
