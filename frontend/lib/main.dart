import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend/core/app_root.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // This is to make status bar adjust according to app's theme.
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.black, // Example color
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
    ),
  );

  ///**App Entry Point**
  ///
  ///
  ///load environment variables from .env file
  await dotenv.load(fileName: "lib/core/config/template.env");

  ///[AppRoot] is the entry component of the application
  runApp(AppRoot());
}
