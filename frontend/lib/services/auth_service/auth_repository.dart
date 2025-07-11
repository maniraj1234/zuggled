// auth_repository.dart
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:frontend/core/network/http_client.dart';
import 'auth_service.dart';

class AuthRepository {
  final AuthService _authService = AuthService();
  final HttpService _httpService = HttpService();
  Future<List<dynamic>> checkUserRegistration() async {
    final user = _authService.currentUser;
    if (user == null) throw Exception('User not logged in');
    final idToken = await user.getIdToken();
    debugPrint("ID Token: $idToken");
    final response = await _httpService.client.get(
      '/auth/checkIfExists',
      options: Options(headers: {'Authorization': 'Bearer $idToken'}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to check registration');
    }
    bool isRegistered = response.data['registered'] ?? false;
    String userType = response.data['userType'] ?? 'unknown';
    return [isRegistered, userType];
  }
}
