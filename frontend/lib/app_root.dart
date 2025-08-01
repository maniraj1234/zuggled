import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:frontend/constants/locales.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class AppRoot extends StatelessWidget {
  const AppRoot({super.key});

  ///pivot of the application
  ///
  ///This widget is the root of the application.
  ///[MaterialApp.router] is used to set up the main router for the app.
  @override
  Widget build(BuildContext context) {
    /// MultiProvder for providing NavigationService, GoRoute context values
    return Builder(
      builder:
          (context) => MaterialApp.router(
            supportedLocales: locales,
            localizationsDelegates: [
              CountryLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            debugShowCheckedModeBanner: false,
            themeMode: ThemeMode.system,
            darkTheme: ThemeData(
              brightness: Brightness.dark,
              colorScheme: ColorScheme.fromSeed(
                brightness: Brightness.dark,
                seedColor: Colors.purple,
              ),
            ),
            theme: ThemeData(
              brightness: Brightness.light,
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
            ),
            routerConfig: context.read<GoRouter>(),
          ),
    );
  }
}
