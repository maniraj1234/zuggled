import 'package:flutter/material.dart';
import 'package:frontend/core/navigation/main_router.dart';

void main() async {
  ///**App Entry Point**
  ///
  ///
  ///load environment variables from .env file
  // await dotenv.load(fileName: "lib/config/.env");

  ///Initialize state management using Bloc or any other
  runApp(AppRoot());
}

class AppRoot extends StatelessWidget {
  const AppRoot({super.key});

  ///pivot of the application
  ///
  ///This widget is the root of your application.
  ///[MaterialApp.router] is used to set up the main router for the app.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(routerConfig: mainRouter);
  }
}
