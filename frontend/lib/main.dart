import 'package:flutter/material.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend/core/app_root.dart';

void main() async {
  ///**App Entry Point**
  ///
  ///
  ///load environment variables from .env file
  await dotenv.load(fileName: "lib/core/config/.env");

  ///[AppRoot] is the entry component of the application
  runApp(AppRoot());
}
