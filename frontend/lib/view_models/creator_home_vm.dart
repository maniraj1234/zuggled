import 'package:flutter/material.dart';
import 'package:frontend/constants/route_names.dart';
import 'package:frontend/services/auth_service/auth_service.dart';
import 'package:frontend/services/navigation/navigation_service.dart';

class CreatorHomeViewModel extends ChangeNotifier {
  CreatorHomeViewModel(this._navService);

  final NavigationService _navService;
  final _authService = AuthService();
  void signout() async {
    await _authService.signOut().then((_) {
      _navService.go(RouteNames.login);
      return;
    });
  }
}
