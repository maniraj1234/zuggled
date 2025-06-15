import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:frontend/models/creator.dart';

/// This class acts as abstraction between ViewModel and Firestore service
class FeedRepository {
  /// Get single instance of [FeedRepository]
  FeedRepository._();
  static FeedRepository? _instance;
  factory FeedRepository() {
    _instance ??= FeedRepository._();
    return _instance!;
  }

  /// Gets List of Creators for Customer Home Screen Feed
  Future<List<Creator>> getFeedData() async {
    try {
      /// TODO:Get Feed Data from Firestore
      /// Currently loaded data from local json file
      final String response = await rootBundle.loadString(
        'lib/assets/json/feed_data.json',
      );
      List<dynamic> jsonList = json.decode(response);
      return jsonList.map((element) => Creator.fromJson(element)).toList();
    } catch (e) {
      rethrow;
    }
  }

  /// TODO: implement refreshFeedData
  // Future<List<Creator>> refreshFeedData() {}
}
