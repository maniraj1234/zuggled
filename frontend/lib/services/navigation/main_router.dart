import 'package:flutter/material.dart';
import 'package:frontend/constants/route_names.dart';
import 'package:frontend/services/user_registration/register_view.dart';
import 'package:frontend/services/user_registration/register_view_model.dart';
import 'package:frontend/services/backend_test/view/backend_test_view.dart';
import 'package:frontend/services/navigation/navigation_service.dart';
import 'package:frontend/view_models/creator_home_vm.dart';
import 'package:frontend/view_models/home_view_model.dart';
import 'package:frontend/view_models/login_view_model.dart';
import 'package:frontend/view_models/search_view_model.dart';
import 'package:frontend/view_models/shell_view_model.dart';
import 'package:frontend/view_models/sign_up_view_model.dart';
import 'package:frontend/views/creator_view.dart';
import 'package:frontend/views/search_view.dart';
import 'package:frontend/views/shell_view.dart';
import 'package:frontend/services/auth_service/auth_service.dart';
import 'package:frontend/views/login_view.dart';
import 'package:frontend/services/calling/pages/call_feature.dart';
import 'package:frontend/views/navigation_error_view.dart';
import 'package:frontend/views/onboarding_view.dart';
import 'package:frontend/views/coins_view.dart';
import 'package:frontend/views/history_view.dart';
import 'package:frontend/views/home_view.dart';
import 'package:frontend/views/settings_view.dart';
import 'package:frontend/views/sign_up_view.dart';
import 'package:frontend/widgets/transition_page.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Defines the main **Application router**
///
/// This router is responsible for handling navigation within the app.
/// It includes predefined routes and an error handler for undefined paths.

/// To check is this is app's first launch
bool isAppLaunch = true;

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter mainRouter = GoRouter(
   
  navigatorKey: rootNavigatorKey,
  /// [debugLogDiagnostics] set to true for showing debug logs
  debugLogDiagnostics: true,

  /// ***Check for First Launch***
  /// If first launch, redirect to onboardingView
  redirect: (context, state) async {
    if (isAppLaunch) {
      isAppLaunch = false;
    } else {
      return null;
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = await AuthService().isLoggedIn();

    ///TODO:Check whether the user is customer or creator then navigate
    ///TODO:Change this conditional logic to a robust one
    if (prefs.getBool('isFirstLaunch') ?? true) {
      return '/onBoarding';
    }
    if (!isLoggedIn) {
      return '/login';
    } else {
      final _userRole=
          await AuthService().getUserRole();
      if (_userRole == 'creator') {
        return '/creator_home';
      }
      return '/home';
    }
  },

  /// **Initial Route**
  ///
  /// Defines the default screen to show when the app starts.
  initialLocation: '/home',

  /// **Application Routes**
  ///
  /// - [`OnboardingView`] serves as the main view (for testing purposes).
  /// - Additional screens can be added here for modular navigation.
  routes: [
    /// ShellRoute will be RootView and act as container for Other main screens like
    /// HomeView, SettingScrren, HistoryView
    /// and have a NavigationBar persistant across all these screens.
    GoRoute(
      path: '/onBoarding',
      name: RouteNames.onBoarding,
      builder: (context, state) => OnboardingView(),
    ),
    GoRoute(
      path: '/login',
      name: RouteNames.login,
      builder:
          (context, state) => ChangeNotifierProvider<LoginViewModel>(
            create: (_) => LoginViewModel(context.read<NavigationService>()),
            child: LoginView(),
          ),
    ),
    GoRoute(
      path: '/signup',
      name: RouteNames.signup,
      builder:
          (context, state) => ChangeNotifierProvider<SignUpViewModel>(
            create:
                (context) => SignUpViewModel(context.read<NavigationService>()),
            child: SignUpView(),
          ),
    ),
    GoRoute(
      path: '/register',
      name: RouteNames.register,
      builder:
          (context, state) => ChangeNotifierProvider<RegisterViewModel>(
            create:
                (context) =>
                    RegisterViewModel(context.read<NavigationService>()),
            child: RegisterView(),
          ),
    ),
    ShellRoute(
      pageBuilder:
          (context, state, child) => NoTransitionPage(
            child: ChangeNotifierProvider<ShellViewModel>(
              create:
                  (context) =>
                      ShellViewModel(context.read<NavigationService>()),
              child: ShellView(child: child),
            ),
          ),
      routes: [
        ///TODO:Update home route based on the current user role (implement dynamic routing)
        /// HomeView
        GoRoute(
          path: '/home',
          name: RouteNames.consumerHome,
          pageBuilder:
              (context, state) => TransitionPage(
                child: ChangeNotifierProvider<HomeViewModel>(
                  create:
                      (context) => HomeViewModel(
                        Provider.of<NavigationService>(context, listen: false),
                      ),
                  child: HomeView(),
                ),
                state: state,
              ),
        ),

        GoRoute(
          name: RouteNames.callHistory,
          path: '/call_history',
          pageBuilder:
              (context, state) =>
                  TransitionPage(child: HistoryView(), state: state),
        ),

        GoRoute(
          name: RouteNames.coinStore,
          path: '/coin_store',
          pageBuilder:
              (context, state) =>
                  TransitionPage(child: CoinsView(), state: state),
        ),

        GoRoute(
          name: RouteNames.settings,
          path: '/settings',
          pageBuilder:
              (context, state) =>
                  TransitionPage(child: SettingsView(), state: state),
        ),
      ],
    ),
    GoRoute(
      path: '/creator_home',
      name: RouteNames.creatorHome,
      builder:
          (context, state) => ChangeNotifierProvider<CreatorHomeViewModel>(
            create:
                (_) => CreatorHomeViewModel(context.read<NavigationService>()),
            child: CreatorHomeView(),
          ),
    ),
    GoRoute(
      path: '/search_screen',
      name: RouteNames.searchScreen,
      pageBuilder:
          (context, state) => TransitionPage(
            child: ChangeNotifierProvider<SearchViewModel>(
              create: (_) => SearchViewModel(context.read<NavigationService>()),
              child: SearchView(),
            ),
            state: state,
          ),
    ),
    GoRoute(path: '/', builder: (context, state) => LoginView()),

    // TODO: Redesign Call View UI
    /// CallView
    GoRoute(
      name: RouteNames.callScreen,
      path: '/call_screen',
      builder: (context, state) => CallScreen(title: "call home screen"),
    ),
    GoRoute(
      name: RouteNames.networkTest,
      path: '/network_test',
      builder: (context, state) => NetworkPage(),
    ),
  ],

  /// **Error Handling**
  ///
  /// Handles navigation errors and undefined routes.
  errorBuilder: (context, state) {
    return ErrorScreen(errorMessage: state.error!.message);
  },
);
//TODO: Modify the initial route when splash screen is implemented.
//TODO: Implement auth guards and registration guards for login routes
