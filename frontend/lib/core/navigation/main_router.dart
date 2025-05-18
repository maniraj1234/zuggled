import 'package:frontend/features/calling/pages/call_feature.dart';
import 'package:frontend/features/onboarding/onboarding.dart';
import 'package:go_router/go_router.dart';
import 'package:frontend/core/navigation/nav_error_handler.dart';

/// Defines the main **Application router**
///
/// This router is responsible for handling navigation within the app.
/// It includes predefined routes and an error handler for undefined paths.
///
/// Usage:
/// ```
/// MaterialApp.router(
///   routerConfig: router,
/// );
/// ```
final GoRouter mainRouter = GoRouter(
  /// [debugLogDiagnostics] set to true for showing debug logs
  debugLogDiagnostics: true,

  /// **Initial Route**
  ///
  /// Defines the default screen to show when the app starts.
  initialLocation: '/',

  /// **Application Routes**
  ///
  /// - [`OnboardingScreen`] serves as the main view (for testing purposes).
  /// - Additional screens can be added here for modular navigation.
  routes: [
    GoRoute(path: '/', builder: (context, state) => OnboardingScreen()),
    GoRoute(
      path: '/call_screen',
      builder: (context, state) => CallScreen(title: "call home screen"),
    ),
  ],

  /// **Error Handling**
  ///
  /// Handles navigation errors and undefined routes.
  errorBuilder: (context, state) {
    return NavErrorHandler.navErrorHandler(context, state);
  },
);
//TODO: Modify the initial route when splash screen is implemented.
