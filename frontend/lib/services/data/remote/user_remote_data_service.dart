import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:frontend/models/user.dart';

/// Interface for UserRepository
abstract class IUserRemoteDataService {
  /// Get Remote user data
  Future<User> getUserData();

  /// Create a new [User]
  Future<void> createUser();

  /// Save User data to remote
  Future<void> updateUserData(User user);

  /// Saves or updates the user's bio.
  Future<void> updateBio(String userId, String bio);

  /// Saves or updates user's profile picture path
  Future<void> updateProfilePicture(String userID, String path);

  /// Adds a new interest to User's interest list
  Future<void> addInterest(String userID, String interest);

  /// Removes an interest from User's interest list
  Future<void> removeInterest(String userID, String interest);
}

// TODO:Implement all methods for User remote data service
/// This class provides [User] data services from remote source
class MockUserRemoteDataService implements IUserRemoteDataService {
  @override
  Future<User> getUserData() async {
    try {
      final String response = await rootBundle.loadString(
        'lib/assets/json/user_data.json',
      );
      return User.fromJson(json.decode(response) as Map<String, dynamic>);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> createUser() async {}

  @override
  Future<void> updateUserData(User user) async {}

  @override
  Future<void> updateBio(String userId, String bio) async {}

  @override
  Future<void> addInterest(String userID, String interest) async {}

  @override
  Future<void> removeInterest(String userID, String interest) async {}

  @override
  Future<void> updateProfilePicture(String userID, String path) async {}
}
