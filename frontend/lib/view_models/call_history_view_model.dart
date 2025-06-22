import 'package:flutter/material.dart';
import 'package:frontend/services/navigation/navigation_service.dart';
import 'package:frontend/widgets/call_history_search_bar.dart';

class CallHistoryViewModel extends ChangeNotifier {
  final NavigationService _navService;

  CallHistoryViewModel(this._navService);

  void onPressBack() {
    _navService.pop();
  }

  final TextEditingController _searchCallHistoryController =
      TextEditingController();

  List<Map<String, String>> userCallHistory = [
    {
      'name': 'carla_charm72',
      'image_url': 'lib/assets/images/user_001.png',
      'date_time': '5:35 PM, 5 Jun',
    },
    {
      'name': 'itsnatalie',
      'image_url': 'lib/assets/images/user_002.png',
      'date_time': '5:35 PM, 5 Jun',
    },
    {
      'name': 'angela323',
      'image_url': 'lib/assets/images/user_003.png',
      'date_time': '5:35 PM, 5 Jun',
    },
    {
      'name': 'user_2414',
      'image_url': 'lib/assets/images/user_004.png',
      'date_time': '5:35 PM, 5 Jun',
    },
    {
      'name': 'carla_charm72',
      'image_url': 'lib/assets/images/user_001.png',
      'date_time': '5:35 PM, 5 Jun',
    },
    {
      'name': 'itsnatalie',
      'image_url': 'lib/assets/images/user_002.png',
      'date_time': '5:35 PM, 5 Jun',
    },
    {
      'name': 'angela323',
      'image_url': 'lib/assets/images/user_003.png',
      'date_time': '5:35 PM, 5 Jun',
    },
    {
      'name': 'user_2414',
      'image_url': 'lib/assets/images/user_004.png',
      'date_time': '5:35 PM, 5 Jun',
    },
  ];

  late Widget callHistorySearchBar = CallHistorySearchBar(
    controller: _searchCallHistoryController,
  );
}
