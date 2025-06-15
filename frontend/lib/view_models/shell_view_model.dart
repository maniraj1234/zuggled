import 'package:flutter/foundation.dart';
import 'package:frontend/constants/navigation_index.dart';
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
      case NavigationIndex.CONSUMER_HOME:
        _navService.go(RouteNames.consumerHome);
      case NavigationIndex.CALL_HISTORY:
        _navService.go(RouteNames.callHistory);
      case NavigationIndex.COIN_STORE:
        _navService.go(RouteNames.coinStore);
      case NavigationIndex.SETTINGS:
        _navService.go(RouteNames.settings);
    }
    notifyListeners();
  }
}
