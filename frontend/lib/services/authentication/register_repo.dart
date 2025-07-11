import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:frontend/core/network/http_client.dart';

class RegisterRepo {
  HttpService httpService = HttpService();
  Future<void> registerUser({
    required String username,
    required String bio,
    required String gender,
    List<String>? interests,
    int? coins,
    String? profilePicture,
    String? phoneNumber,
    String? birthdate,
  }) async {
    try {
      final Map<String, dynamic> body = {
        'userName': username,
        'bio': bio,
        'birthdate': birthdate,
        'coins': coins,
        'gender': gender,
        'interests': interests,
        'profilePicture': profilePicture,
        'phoneNumber': phoneNumber,
      };

      final endpoint = gender == 'Male' ? 'customer' : 'creator';
      final response = await httpService.client.post('/$endpoint', data: body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint('User registered: ${response.data}');
      } else {
        debugPrint('Failed to register user: ${response.statusCode}');
      }
    } on DioException catch (e) {
      debugPrint('Dio error: ${e.message}');
      if (e.response != null) {
        debugPrint('Server responded with: ${e.response?.data}');
      }
    } catch (e) {
      throw Exception('Registration failed: $e');
    }
  }
}
