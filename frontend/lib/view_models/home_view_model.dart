import 'package:flutter/foundation.dart';
import 'package:frontend/models/creator.dart';
import 'package:frontend/repository/feed_repository.dart';

class HomeViewModel extends ChangeNotifier {
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
