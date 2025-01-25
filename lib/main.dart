import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:my_doctor/presentation/screens/splash_screen/splash_screen.dart';

import 'package:provider/provider.dart';

import 'core/di/di.dart';
import 'core/providers/theme_provider.dart';
import 'core/utils/themes.dart';

/*
* Created by Jackson Stephen, jacksonsteven436@gmail.com: 25|01|2025
* */

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableProvider<ThemeProvider>(
      builder: (context, _) {
        final themeProvider = Provider.of<ThemeProvider>(context);
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: themeProvider.themeMode,
          theme: Themes.lightTheme,
          darkTheme: Themes.darkTheme,
          /*translations: LocaleStrings(),
          locale: const Locale('sw', 'TZ'),
           supportedLocales: const [
            Locale('en', 'US'),
            Locale('sw', 'TZ'),
          ],*/
          home: const SplashScreen(),
        );
      },
      create: (BuildContext context) {
        try {
          ThemeProvider();
        } catch (error) {
          rethrow;
        }
        return ThemeProvider();
      },
    );
  }
}
