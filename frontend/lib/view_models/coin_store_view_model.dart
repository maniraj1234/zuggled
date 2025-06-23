import 'package:flutter/material.dart';
import 'package:frontend/services/navigation/navigation_service.dart';

class CoinStoreViewModel extends ChangeNotifier {
  final NavigationService _navService;

  CoinStoreViewModel(this._navService);

  void pop() {
    _navService.pop();
  }

  List<Map<String, dynamic>> coinDataList = [
    {'coins_count': 25, 'coins_value': 12.5},
    {'coins_count': 25, 'coins_value': 12.5},
    {'coins_count': 25, 'coins_value': 12.5},
    {'coins_count': 25, 'coins_value': 12.5},
    {'coins_count': 25, 'coins_value': 12.5},
    {'coins_count': 25, 'coins_value': 12.5},
    {'coins_count': 25, 'coins_value': 12.5},
    {'coins_count': 25, 'coins_value': 12.5},
    {'coins_count': 25, 'coins_value': 12.5},
    {'coins_count': 25, 'coins_value': 12.5},
  ];
}
