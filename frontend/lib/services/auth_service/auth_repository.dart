// auth_repository.dart
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:frontend/core/network/http_client.dart';
import 'package:http_status_code/http_status_code.dart';
import 'auth_service.dart';

class AuthRepository {
  final AuthService _authService = AuthService();
  final HttpService _httpService = HttpService();

  ///TODO:Add docstrings to each methods
  Future<List<dynamic>> checkIfUserRegisteredAndReturnRole() async {
    final bool isLogged = await _authService.isLoggedIn();
    if (isLogged == false) throw Exception('User not logged in');
    final response = await _httpService.client.get('/auth/checkIfExists');
    if (response.statusCode != StatusCode.OK) {
      throw Exception('Failed to check registration');
    }
    bool isRegistered = response.data['registered'] ?? false;
    String userRole = response.data['userType'] ?? 'unknown';
    return [isRegistered, userRole];
  }
}
