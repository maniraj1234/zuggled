import 'package:flutter/material.dart';
import 'package:frontend/config/app_router.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  ///load environment variables from .env file
  // await dotenv.load(fileName: "lib/config/.env");

  ///Initialize state management using Bloc or any other
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  ///pivot of the application
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(routerConfig: router);
  }
}
