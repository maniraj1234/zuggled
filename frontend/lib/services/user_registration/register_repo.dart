import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:frontend/core/network/http_client.dart';
import 'package:http_status_code/http_status_code.dart';

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
      ///TODO:Replace with user model
      final Map<String, dynamic> body = {
        'userName': username,
        'bio': bio,
        'birthdate': birthdate,
        'coins': coins,
        'gender': gender,
        'interests': interests,
        'profilePictureURL': profilePicture,
        'phoneNumber': phoneNumber,
      };

      ///TODO:Change this method of register to a robust one
        final response = await httpService.client.post('/user/register', data: body);
      if (response.statusCode == StatusCode.OK ||
          response.statusCode == StatusCode.CREATED) {
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
