import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:frontend/constants/route_names.dart';
import 'package:frontend/services/navigation/navigation_service.dart';

class HomeViewModel extends ChangeNotifier {
  HomeViewModel(this._navService);

  final NavigationService _navService;

  late Size size;

  void onSearchTap() {
    _navService.push(RouteNames.searchScreen);
  }
}
