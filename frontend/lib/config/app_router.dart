import 'package:flutter/material.dart';
import 'package:frontend/features/onboarding/onboarding.dart';
import 'package:go_router/go_router.dart';

///[router] serves as main router
final GoRouter router = GoRouter(
  debugLogDiagnostics: false,
  initialLocation: '/',
  errorBuilder:
      (context, state) => ErrorScreen(errorMessage: state.error.toString()),
  routes: [
    ///[OnboardingScreen] serves as main view (for testing),
    GoRoute(path: '/', builder: (context, state) => OnboardingScreen()),
  ],
);

///For undefined routes return a [ErrorScreen]
class ErrorScreen extends StatelessWidget {
  final String errorMessage;

  const ErrorScreen({super.key, required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Error! the page you are looking for does not exist'),
      ),
      body: Center(child: Text(errorMessage)),
    );
  }
}
