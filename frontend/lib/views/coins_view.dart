import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/widgets/coin_card.dart';

/// A view that displays coin packages in a grid layout for users to purchase.
/// 
/// Loads coin package data from a local JSON file (`coin_packages.json`)
/// and displays each package using [CoinCard] widgets
class CoinsView extends StatefulWidget {
  const CoinsView({super.key});  
   
  @override
  State<CoinsView> createState() => _CoinsViewState();
}

class _CoinsViewState extends State<CoinsView> {
  /// A list of coin package maps loaded from a local JSON asset.
  List<Map<String, dynamic>> coinPackages = [];

  @override
  void initState() {
    super.initState();
    loadCoinPackages();
  }

  /// Loads coin package data from a local JSON file located in
  /// `lib/assets/json/coin_packages.json`.
  ///
  /// The JSON should be an array of objects, each containing:
  /// `label` (String), `coins` (int), and `price` (double).
  ///
  /// This function updates the [coinPackages] list via [setState].
  /// 
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
