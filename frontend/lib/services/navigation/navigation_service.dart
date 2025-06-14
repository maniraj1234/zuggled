import 'package:go_router/go_router.dart';

/// This class handles Navigation Logic and Services
/// like go(), pop(), etc. It can be used by ViewModels and other
/// classes to use navigation services directly instead of
/// using BuildContext.
/// The NavigationService() will always give a single instance of [NavigationService]
/// so calling it multiple times won't affect system resources.
class NavigationService {
  /// Private constructor for single instance
  NavigationService._(this._router);

  /// Private single instance
  static NavigationService? _instance;

  /// Get instance
  factory NavigationService(GoRouter router) {
    _instance ??= NavigationService._(router);
    return _instance!;
  }

  /// A private instance of GoRouter, it's value will be
  /// taken as parameter when creating NavigationService's First instance
  final GoRouter _router;

  /// Navigation methods bellow, to navigate to different screens

  /// Navigate to a named route
  void go(String name) {
    _router.goNamed(name);
  }

  /// Push a route onto the stack
  void push(String name) {
    _router.pushNamed(name);
  }

  /// if canPop(), Pop current route
  void pop() {
    if (_router.canPop()) {
      _router.pop();
    }
  }
}
