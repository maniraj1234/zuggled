import 'package:frontend/core/navigation/root_nav_screen.dart';
import 'package:frontend/features/auth_test/view/login.dart';
import 'package:frontend/features/Authentication/presentation/pages/signin1.dart';
import 'package:frontend/features/Authentication/presentation/pages/signin2.dart';
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
import 'package:shared_preferences/shared_preferences.dart';

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

/// To check is this is app's launch
bool isAppLaunch = true;

final GoRouter mainRouter = GoRouter(
  /// [debugLogDiagnostics] set to true for showing debug logs
  debugLogDiagnostics: true,

  /// ***Check for First Launch***
  /// If first launch, redirect to onboardingScreen
  redirect: (context, state) async {
    if (isAppLaunch) {
      isAppLaunch = false;
    } else {
      return null;
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('isFirstLaunch') ?? true) {
      return '/onBoarding';
    } else {
      return '/home';
    }
  },

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
    GoRoute(
      path: '/onBoarding',
      builder: (context, state) => OnboardingScreen(),
    ),
    GoRoute(path: '/login', builder: (context, state) => LoginPage()),
    ShellRoute(
      pageBuilder:
          (context, state, child) =>
              NoTransitionPage(child: RootNavScreen(child: child)),
      routes: [
        /// HomeScreen
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
    // TODO: Redesign Call Screen UI
    /// CallScreen
    GoRoute(path: '/', builder: (context, state) => SignIn1()),
    GoRoute(path: '/signin2', builder: (context, state) => SignIn2()),
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
