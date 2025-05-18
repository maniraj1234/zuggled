import 'package:flutter/material.dart';
import 'package:frontend/core/navigation/main_router.dart';

class AppRoot extends StatelessWidget {
  const AppRoot({super.key});

  ///pivot of the application
  ///
  ///This widget is the root of the application.
  ///[MaterialApp.router] is used to set up the main router for the app.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(routerConfig: mainRouter);
  }
}
