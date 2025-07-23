import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:frontend/core/network/http_client.dart';
import 'package:http_status_code/http_status_code.dart';

class StreamTokenRepo {
  Future<String?> getStreamUserToken() async {
    try {
      final response = await http.client.get('/userToken');

      if (response.statusCode == StatusCode.OK) {
        final token = response.data['token'] as String?;
        debugPrint('Stream user token: $token');
        return token;
      } else {
        debugPrint('Failed to get Stream user token: ${response.statusCode}');
        return null;
      }
    } on DioException catch (e) {
      debugPrint('Dio error: ${e.message}');
      if (e.response != null) {
        debugPrint('Server responded with: ${e.response?.data}');
      }
      return null;
    } catch (e) {
      debugPrint('Unexpected error: $e');
      return null;
    }
  }
}
