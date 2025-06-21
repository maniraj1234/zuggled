import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:frontend/constants/route_names.dart';
import 'package:frontend/services/navigation/navigation_service.dart';
import 'package:flutter/foundation.dart';
import 'package:frontend/models/creator.dart';
import 'package:frontend/repository/feed_repository.dart';

class HomeViewModel extends ChangeNotifier {
  HomeViewModel(this._navService);

  final NavigationService _navService;

  late Size size;

  void onSearchTap() {
    _navService.push(RouteNames.searchScreen);
  }

  /// Private FeedRepository to handle Feed Data
  final FeedRepository _feedRepository = FeedRepository();

  /// bool to check if feed is initialized
  bool _isInitialized = false;
  bool get isInitialized => _isInitialized;

  /// Private List of Creators for Feed
  late List<Creator> _feed;

  /// Gettr
  List<Creator> get feed => _feed;

  /// Initialize Feed using [FeedRepository]
  Future<void> initializeFeed() async {
    _feed = await _feedRepository.getFeedData();
    _isInitialized = true;
    notifyListeners();
  }
}
