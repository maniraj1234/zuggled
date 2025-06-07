import 'package:frontend/core/navigation/root_nav_screen.dart';
import 'package:frontend/features/calling/pages/call_feature.dart';
// ignore: unused_import
import 'package:frontend/features/onboarding/onboarding.dart';
import 'package:frontend/views/coins_screen.dart';
import 'package:frontend/views/history_screen.dart';
import 'package:frontend/views/home_screen.dart';
import 'package:frontend/views/settings_screen.dart';
import 'package:frontend/widgets/transition_page.dart';
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
  initialLocation: '/home',

  /// **Application Routes**
  ///
  /// - [`OnboardingScreen`] serves as the main view (for testing purposes).
  /// - Additional screens can be added here for modular navigation.
  routes: [
    //TODO:Change HomeScreen to OnboardingScreen()
    /// ShellRoute will be RootScreen and act as container for Other main screens like
    /// HomeScreen, SettingScrren, HistoryScreen
    /// and have a NavigationBar persistant across all these screens.
    ShellRoute(
      pageBuilder:
          (context, state, child) =>
              NoTransitionPage(child: RootNavScreen(child: child)),
      routes: [
        GoRoute(
          path: '/home',
          pageBuilder:
              (context, state) =>
                  TransitionPage(child: HomeScreen(), state: state),
        ),
        GoRoute(
          path: '/history',
          pageBuilder:
              (context, state) =>
                  TransitionPage(child: HistoryScreen(), state: state),
        ),
        GoRoute(
          path: '/coins',
          pageBuilder:
              (context, state) =>
                  TransitionPage(child: CoinsScreen(), state: state),
        ),
        GoRoute(
          path: '/settings',
          pageBuilder:
              (context, state) =>
                  TransitionPage(child: SettingsScreen(), state: state),
        ),
      ],
    ),
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
