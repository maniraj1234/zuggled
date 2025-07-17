import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend/services/auth_service/auth_service.dart';
import 'package:frontend/services/navigation/main_router.dart';
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
          }else {
            // Token is missing — force redirect to login
            rootNavigatorKey.currentState?.pushNamedAndRemoveUntil(
              '/login',
              (route) => false,
            );
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
//a getter for accessing 
HttpService get http => HttpService();