import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:frontend/models/user.dart';

/// This class acts as abstract layer between FireStore
/// and ViewModels that will user User Data
class UserRepository {
  /// Gets User's Data from Remote
  Future<User> getUserData() async {
    /// TODO:Implement Firebase api and fetch user data
    /// Currently using local json file
    try {
      final String response = await rootBundle.loadString(
        'lib/assets/json/user_data.json',
      );
      return User.fromJson(json.decode(response) as Map<String, dynamic>);
    } catch (e) {
      rethrow;
    }
  }

  /// TODO:Implement function to saving User data if changed
  Future<void> saveUserData(User user) async {}
}
