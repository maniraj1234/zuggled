import 'package:flutter/material.dart';
import 'package:frontend/services/navigation/navigation_service.dart';
import 'package:frontend/widgets/search_history_widget.dart';
import 'package:frontend/widgets/search_text_controller.dart';

class SearchScreenViewModel extends ChangeNotifier {
  final NavigationService _navService;
  late Size size;

  SearchScreenViewModel(this._navService);

  final _searchController = TextEditingController();

  late Widget textFieldWidget = SearchTextField(
    controller: _searchController,
    onPopScreen: onPopScreen,
    onClearTextField: onClearTextField,
  );

  final Map<String, bool> filters = {
    'Funny': false,
    'FriendShip': false,
    'Adventurous': false,
    'Introvert': false,
  };

  void onPopScreen() {
    _navService.pop();
    notifyListeners();
  }

  void onClearTextField() {
    _searchController.clear();
    notifyListeners();
  }

  void onFilterTapped(String key) {
    filters[key] = !filters[key]!;
    notifyListeners();
  }

  List<String> searchHistory = ['ItsElina37', 'Starlight Bloom', 'Pixel Dust'];

  late Widget searchHistoryWidget = SearchHistoryList(history: searchHistory);
}
