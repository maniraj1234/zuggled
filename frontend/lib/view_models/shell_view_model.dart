import 'package:flutter/foundation.dart';
import 'package:frontend/constants/route_names.dart';
import 'package:frontend/services/navigation/navigation_service.dart';

/// [ShellViewModel] is ViewModel for [ShellView],
/// the root view which holds [NavigationBar] and other screens.
class ShellViewModel extends ChangeNotifier {
  final NavigationService _navService;
  ShellViewModel(this._navService);
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  void changeDestination(int index) {
    _selectedIndex = index;
    switch (index) {
      case 0:
        _navService.go(RouteNames.consumerHome);
      case 1:
        _navService.go(RouteNames.callHistory);
      case 2:
        _navService.go(RouteNames.coinStore);
      case 3:
        _navService.go(RouteNames.settings);
    }
    notifyListeners();
  }
}
