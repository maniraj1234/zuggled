import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

/// HttpService uses [Dio] to handling HTTP requestis.
///
/// This class sets up the base URL, timeout durations, and logging interceptors.
/// It allows reuse of dio instance for accessing dio instance accross the app.
class HttpService {
  final Dio _dio = Dio(
    BaseOptions(
      // The base URL for all API requests, loaded from environment variables.
      baseUrl: dotenv.env['BASE_URL']!, // Use env or config file
      connectTimeout: Duration(seconds: 240),
      receiveTimeout: Duration(seconds: 240),
    ),
  );

  /// Constructor for [HttpService].
  ///
  /// This constructor initializes the Dio instance with base options and adds interceptors.
  /// It sets up logging for all requests and responses.
  HttpService() {
    _dio.interceptors.add(
      LogInterceptor(responseBody: true),
    ); // Add token, logs, etc.
  }

  /// Returns the Dio instance.
  Dio get client => _dio;
}
