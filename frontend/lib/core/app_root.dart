import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/core/navigation/main_router.dart';
import 'package:frontend/features/auth_test/auth_bloc/auth_bloc.dart';
import 'package:frontend/features/auth_test/auth_bloc/auth_event.dart';
import 'package:frontend/features/auth_test/data/auth_service.dart';

class AppRoot extends StatelessWidget {
  const AppRoot({super.key});

  ///pivot of the application
  ///
  ///This widget is the root of the application.
  ///[MaterialApp.router] is used to set up the main router for the app.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthBloc(authService: AuthService())..add(InitEvent()),
      child: MaterialApp.router(routerConfig: mainRouter),
    );
  }
}
