import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend/app_root.dart';
import 'package:frontend/repository/user_repository.dart';
import 'package:frontend/services/data/local/user__local_data_service.dart';
import 'package:frontend/services/data/remote/user_remote_data_service.dart';
import 'package:frontend/services/navigation/main_router.dart';
import 'package:frontend/services/navigation/navigation_service.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  /// This is to make status bar adjust according to app's theme.
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
  runApp(
    MultiProvider(
      providers: [
        Provider<GoRouter>(create: (_) => mainRouter),
        Provider<NavigationService>(
          create: (context) => NavigationService(context.read<GoRouter>()),
        ),
        Provider<IUserLocalDataService>(
          create: (_) => MockUserLocalDataService(),
        ),
        Provider<IUserRemoteDataService>(
          create: (_) => MockUserRemoteDataService(),
        ),
        Provider<IUserRepository>(
          create:
              (context) => MockUserRepository(
                context.read<IUserLocalDataService>(),
                context.read<IUserRemoteDataService>(),
              ),
        ),
      ],
      child:
          /// Using a Builder() to get context for [MaterialApp]'s routerConfig
          AppRoot(),
    ),
  );
}
