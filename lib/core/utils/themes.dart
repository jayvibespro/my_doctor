import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'constants/colors.dart';

/*
* Created by Jackson Stephen, jacksonsteven436@gmail.com: 25|01|2025
* */

class Themes {
  static final darkTheme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: cBlackMain,
    primaryColor: cPrimary,
    focusColor: cPrimary,
    colorScheme: const ColorScheme.dark(),
    iconTheme: IconThemeData(color: Colors.purple.shade200, opacity: 0.8),
    expansionTileTheme: ExpansionTileThemeData(
      collapsedIconColor: Colors.purple.shade200.withOpacity(0.8),
      textColor: cPrimary,
      iconColor: cPrimary,
    ),

    bottomAppBarTheme: const BottomAppBarTheme(
      color: cBlack,
      surfaceTintColor: cBlackTransparent,
    ),
    appBarTheme: const AppBarTheme(
      toolbarHeight: 70,
      backgroundColor: cPrimary,
      foregroundColor: cBlack,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: cPrimary,
      textTheme: ButtonTextTheme.primary,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      // foregroundColor: Colors.purple.shade200,
      backgroundColor: cPrimary,
      foregroundColor: Colors.white,
      focusElevation: 3,
      focusColor: Colors.lightBlue,
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith<Color>((states) {
        if (states.contains(WidgetState.disabled)) {
          return cPrimary;
        }
        return Colors.blueAccent;
      }),
      trackColor: WidgetStateProperty.resolveWith<Color>((states) {
        if (states.contains(WidgetState.disabled)) {
          return cPrimary;
        }
        return Colors.lightBlue;
      }),
    ),

    // Define the default font family.
    fontFamily: 'mark_pro',

    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontFamily: 'mark_pro',
        fontWeight: FontWeight.w800, // Bold
        fontSize: 24.0,
        color: Colors.black,
      ),
      headlineMedium: TextStyle(
        fontFamily: 'mark_pro',
        fontWeight: FontWeight.w700, // Heavy
        fontSize: 22.0,
        color: Colors.black,
      ),
      headlineSmall: TextStyle(
        fontFamily: 'mark_pro',
        fontWeight: FontWeight.w600, // Heavy
        fontSize: 18.0,
        color: Colors.black,
      ),
      displayLarge: TextStyle(
        fontFamily: 'mark_pro',
        fontWeight: FontWeight.w600, // Medium
        fontSize: 16.0,
        color: Colors.black,
      ),
      displayMedium: TextStyle(
        fontFamily: 'mark_pro',
        fontWeight: FontWeight.w400, // Normal
        fontSize: 14.0,
        color: Colors.black,
      ),
      displaySmall: TextStyle(
        fontFamily: 'mark_pro',
        fontWeight: FontWeight.w400, // Normal
        fontSize: 14.0,
        color: Colors.black,
      ),
      bodyLarge: TextStyle(
        fontFamily: 'mark_pro',
        fontWeight: FontWeight.w600, // Medium
        fontSize: 16.0,
        color: Colors.black,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'mark_pro',
        fontWeight: FontWeight.w400, // Normal
        fontSize: 14.0,
        color: Colors.black,
      ),
      bodySmall: TextStyle(
        fontFamily: 'mark_pro',
        fontWeight: FontWeight.w400, // Normal
        fontSize: 14.0,
        color: Colors.black,
      ),
    ),

    // textTheme: GoogleFonts.montserratTextTheme(),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        padding: WidgetStateProperty.all(
          const EdgeInsets.all(12),
        ),
        foregroundColor: WidgetStateProperty.all(
          Colors.white,
        ),
        backgroundColor: WidgetStateProperty.all(
          cPrimary,
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        padding: WidgetStateProperty.all(
          const EdgeInsets.all(12),
        ),
      ),
    ),
  );

  static final lightTheme = ThemeData(
    // Define the default brightness and colors.
    scaffoldBackgroundColor: cBlackMain,
    focusColor: cPrimary,
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: cPrimary,
    colorScheme: const ColorScheme.light(),
    iconTheme: const IconThemeData(color: Colors.black87),
    highlightColor: cPrimary.withOpacity(0.2),
    pageTransitionsTheme: const PageTransitionsTheme(),
    indicatorColor: cPrimary,
    bottomAppBarTheme: const BottomAppBarTheme(
      color: cBlack,
      surfaceTintColor: cBlackTransparent,
    ),

    tabBarTheme: TabBarTheme(
      indicatorColor: cPrimary,
      labelColor: cPrimary,
      overlayColor: WidgetStatePropertyAll(
        cPrimary.withOpacity(0.15),
      ),
    ),
    dividerTheme: const DividerThemeData(
      color: cPrimary,
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black87,
      toolbarHeight: 70,
      iconTheme: IconThemeData(
        color: Colors.black87,
      ),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    ),
    expansionTileTheme: const ExpansionTileThemeData(
      textColor: cPrimary,
      iconColor: Colors.black54,
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: cPrimary,
      textTheme: ButtonTextTheme.primary,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      foregroundColor: Colors.white,
      backgroundColor: cPrimary,
      focusElevation: 3,
      focusColor: cPrimary,
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith<Color>((states) {
        if (states.contains(WidgetState.disabled)) {
          return cPrimary.withOpacity(0.6);
        }
        return cPrimary;
      }),
      trackOutlineColor: WidgetStateProperty.resolveWith<Color>((states) {
        if (states.contains(WidgetState.disabled)) {
          return cPrimary.withOpacity(0.1);
        }
        return cPrimary.withOpacity(0.6);
      }),
      trackColor: WidgetStateProperty.resolveWith<Color>((states) {
        if (states.contains(WidgetState.disabled)) {
          return cPrimary.withOpacity(0.1);
        }
        return cPrimary.withOpacity(0.3);
      }),
    ),
    checkboxTheme: const CheckboxThemeData(
      fillColor: WidgetStatePropertyAll(
        cPrimary,
      ),
      overlayColor: WidgetStatePropertyAll(
        Colors.white,
      ),
    ),

    // Define the default font family.
    fontFamily: 'mark_pro',

    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontFamily: 'mark_pro',
        fontWeight: FontWeight.w800, // Bold
        fontSize: 24.0,
        color: Colors.black,
      ),
      headlineMedium: TextStyle(
        fontFamily: 'mark_pro',
        fontWeight: FontWeight.w700, // Heavy
        fontSize: 22.0,
        color: Colors.black,
      ),
      headlineSmall: TextStyle(
        fontFamily: 'mark_pro',
        fontWeight: FontWeight.w600, // Heavy
        fontSize: 18.0,
        color: Colors.black,
      ),
      displayLarge: TextStyle(
        fontFamily: 'mark_pro',
        fontWeight: FontWeight.w600, // Medium
        fontSize: 16.0,
        color: Colors.black,
      ),
      displayMedium: TextStyle(
        fontFamily: 'mark_pro',
        fontWeight: FontWeight.w400, // Normal
        fontSize: 14.0,
        color: Colors.black,
      ),
      displaySmall: TextStyle(
        fontFamily: 'mark_pro',
        fontWeight: FontWeight.w400, // Normal
        fontSize: 14.0,
        color: Colors.black,
      ),
      bodyLarge: TextStyle(
        fontFamily: 'mark_pro',
        fontWeight: FontWeight.w600, // Medium
        fontSize: 16.0,
        color: Colors.black,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'mark_pro',
        fontWeight: FontWeight.w400, // Normal
        fontSize: 14.0,
        color: Colors.black,
      ),
      bodySmall: TextStyle(
        fontFamily: 'mark_pro',
        fontWeight: FontWeight.w400, // Normal
        fontSize: 14.0,
        color: Colors.black,
      ),
    ),

    // textTheme: GoogleFonts.montserratTextTheme(),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        padding: WidgetStateProperty.all(
          const EdgeInsets.all(12),
        ),
        foregroundColor: WidgetStateProperty.all(
          Colors.white,
        ),
        backgroundColor: WidgetStateProperty.all(
          cPrimary,
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        textStyle: WidgetStateProperty.all(
          const TextStyle(
            color: cPrimary,
          ),
        ),
        padding: WidgetStateProperty.all(
          const EdgeInsets.all(12),
        ),
        foregroundColor: WidgetStateProperty.all(
          Colors.white,
        ),
        backgroundColor: WidgetStateProperty.all(
          Colors.white,
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        textStyle: WidgetStateProperty.all(
          const TextStyle(
            color: cPrimary,
          ),
        ),
        // padding: MaterialStateProperty.all(
        //   const EdgeInsets.all(12),
        // ),
        foregroundColor: WidgetStateProperty.all(
          cPrimary,
        ),
        backgroundColor: WidgetStateProperty.all(
          Colors.white,
        ),
      ),
    ),
    dividerColor: Colors.black26,
  );
}
