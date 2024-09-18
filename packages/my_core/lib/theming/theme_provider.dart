//

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'color_scheme_provider.dart';
import 'pallet.dart';
import 'text_theme_provider.dart';

class ThemeProvider {
  ThemeProvider._internal();

  static void setStatusBarAndNavigationBarColor(ThemeMode themeMode) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness:
          themeMode == ThemeMode.light ? Brightness.dark : Brightness.light,
      systemNavigationBarIconBrightness:
          themeMode == ThemeMode.light ? Brightness.light : Brightness.dark,
      systemNavigationBarColor: themeMode == ThemeMode.light
          ? Pallet.neutral.shade700
          : Pallet.neutral.shade300,
      systemNavigationBarDividerColor: Colors.transparent,
    ));
  }

  static ThemeData lightTheme(String fontName) {
    final colorScheme = ColorSchemeProvider.lightFromCorePalette;
    final textTheme = TextThemeProvider.generate(fontName);
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: colorScheme,
      fontFamily: fontName,
      // textTheme: textTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
      ),
      // filledButtonTheme: FilledButtonThemeData(
      //   style: FilledButton.styleFrom(
      //     backgroundColor: colorScheme.primary,
      //     foregroundColor: colorScheme.onPrimary,
      //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      //     // textStyle: textTheme.titleLarge?.copyWith(
      //     //   color: colorScheme.onPrimary,
      //     //   fontWeight: FontWeight.bold,
      //     // ),
      //     minimumSize: const Size.fromHeight(46),
      //   ),
      // ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) {
                return colorScheme.primaryContainer.withOpacity(0.5);
              }
              return colorScheme.primaryContainer;
            },
          ),
          shape: MaterialStateProperty.resolveWith<OutlinedBorder?>((states) =>
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
          textStyle: MaterialStateProperty.resolveWith(
              (states) => textTheme.titleLarge?.copyWith(
                    color: colorScheme.onPrimaryContainer,
                    fontWeight: FontWeight.bold,
                  )),
        ),
      ),
    );
  }

  static ThemeData darkTheme(String fontName) => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: ColorSchemeProvider.darkFromCorePalette,
        textTheme: TextThemeProvider.generate(fontName),
        // canvasColor: Pallet.neutral.shade700,
        // fontFamily: 'Poppins',
        // BottomNavigationBar
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          elevation: 4,
          backgroundColor: Colors.white,
        ),
      );
}
