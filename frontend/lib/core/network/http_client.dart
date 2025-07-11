import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend/services/auth_service/auth_service.dart';

class HttpService {
  static final HttpService _instance = HttpService._internal();

  late final Dio _dio;

  /// Private named constructor
  HttpService._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: dotenv.env['BASE_URL']!,
        connectTimeout: Duration(seconds: 240),
        receiveTimeout: Duration(seconds: 240),
        headers: {'Content-Type': 'application/json'},
      ),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final _token = await AuthService().getUserToken();

          if (_token != null) {
            options.headers['Authorization'] =
                'Bearer $_token'; //pass token for each request
          }
          return handler.next(
            options,
          ); //optionally add exception routes via options.path
        },
      ),
    );
    _dio.interceptors.add(
      LogInterceptor(
        responseBody: true,
      ), //logs the response body for each req, res from backend
    );
  }

  /// Factory constructor to return the same instance
  factory HttpService() => _instance;

  /// Getter to access Dio client
  Dio get client => _dio;
}
