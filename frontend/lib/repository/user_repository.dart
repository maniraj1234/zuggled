import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:frontend/models/user.dart';

/// This class acts as abstract layer between FireStore
/// and ViewModels that will use User Data
abstract class IUserRepository {
  Future<User> getUserData();
  Future<void> saveUserData(User user);
}

/// Testing User Repository, uses local files
class MockUserRepository implements IUserRepository {
  /// Get Single Instance
  MockUserRepository._();
  static MockUserRepository? _instance;
  factory MockUserRepository() {
    _instance ??= MockUserRepository._();
    return _instance!;
  }

  @override
  Future<User> getUserData() async {
    /// Gets User's Data from Remote
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
  @override
  Future<void> saveUserData(User user) async {}
}
