//

import 'package:flutter/material.dart';

class Pallet {
  Pallet._internal();

  static const MaterialColor primary = MaterialColor(
    0xFF90C44B,
    {
      50: Color(0xFFEDF5E1),
      100: Color(0xFFDAEBC3),
      200: Color(0xFFC7E2A5),
      300: Color(0xFFB5D887),
      400: Color(0xFFA3CE69),
      500: Color(0xFF90C44B),
      600: Color(0xFF74A336),
      700: Color(0xFF577A28),
      800: Color(0xFF3A521B),
      900: Color(0xFF1D290D),
    },
  );

  static const MaterialColor secondary = MaterialColor(
    0xFF919F87,
    {
      50: Color(0xFFEDEFEB),
      100: Color(0xFFDADFD7),
      200: Color(0xFFC8CFC3),
      300: Color(0xFFB6BFAF),
      400: Color(0xFFA3AF9B),
      500: Color(0xFF919F87),
      600: Color(0xFF738369),
      700: Color(0xFF57624E),
      800: Color(0xFF3A4134),
      900: Color(0xFF1D211A),
    },
  );

  static const MaterialColor tertiary = MaterialColor(
    0xFF54C4D4,
    {
      50: Color(0xFFE3F5F8),
      100: Color(0xFFC6EBF1),
      200: Color(0xFFAAE2EA),
      300: Color(0xFF8DD8E2),
      400: Color(0xFF71CEDB),
      500: Color(0xFF54C4D4),
      600: Color(0xFF30ACBD),
      700: Color(0xFF24818E),
      800: Color(0xFF18565F),
      900: Color(0xFF0C2B2F),
    },
  );

  static const MaterialColor error = MaterialColor(
    0xFFF64234,
    {
      50: Color(0xFFFEE0DD),
      100: Color(0xFFFCC0BB),
      200: Color(0xFFFBA19A),
      300: Color(0xFFF98178),
      400: Color(0xFFF86256),
      500: Color(0xFFF64234),
      600: Color(0xFFE41A0A),
      700: Color(0xFFAB1308),
      800: Color(0xFF720D05),
      900: Color(0xFF390603),
    },
  );

  static const MaterialColor neutralVariant = MaterialColor(
    0xFFB1AEB3,
    {
      50: Color(0xFFF2F2F2),
      100: Color(0xFFE5E4E6),
      200: Color(0xFFD8D7D9),
      300: Color(0xFFCBC9CC),
      400: Color(0xFFBEBCC0),
      500: Color(0xFFB1AEB3),
      600: Color(0xFF8E8A91),
      700: Color(0xFF6B676D),
      800: Color(0xFF474449),
      900: Color(0xFF242224),
    },
  );

  static const MaterialColor neutral = MaterialColor(
    0xFFB1B3AE,
    {
      50: Color(0xFFF2F2F2),
      100: Color(0xFFE5E6E4),
      200: Color(0xFFD8D9D7),
      300: Color(0xFFCBCCC9),
      400: Color(0xFFBEC0BC),
      500: Color(0xFFB1B3AE),
      600: Color(0xFF8E918A),
      700: Color(0xFF6B6D67),
      800: Color(0xFF474944),
      900: Color(0xFF242422),
    },
  );
}

class ColorSchemeProvider {
  static const ColorScheme darkFromCorePalette = ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFF90C44B),
    onPrimary: Color(0xFFEDF5E1),
    primaryContainer: Color(0xFFB5D887),
    onPrimaryContainer: Color(0xFFEDF5E1),
    inversePrimary: Color(0xff577a28),
    secondary: Color(0xFF919F87),
    onSecondary: Color(0xffedefeb),
    secondaryContainer: Color(0xffb6bfaf),
    onSecondaryContainer: Color(0xffedefeb),
    tertiary: Color(0xFF54C4D4),
    onTertiary: Color(0xFFE3F5F8),
    tertiaryContainer: Color(0xFF8DD8E2),
    onTertiaryContainer: Color(0xFFE3F5F8),
    error: Color(0xfff64234),
    onError: Color(0xFFFEE0DD),
    errorContainer: Color(0xFFF98178),
    onErrorContainer: Color(0xFFFEE0DD),
    background: Color(0xFF242422),
    onBackground: Color(0xFFF2F2F2),
    surface: Color(0xFF474944),
    onSurface: Color(0xFFF2F2F2),
    surfaceVariant: Color(0xFF6B6D67),
    onSurfaceVariant: Color(0xFF242422),
    outline: Color(0xFFB1B3AE),
    outlineVariant: Color(0xFFB1B3AE),
    shadow: Color(0xFFF2F2F2),
    scrim: Color(0xFF242422),
    inverseSurface: Color(0xFF6B6D67),
  );

  static const ColorScheme lightFromCorePalette = ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFF90C44B),
    onPrimary: Color(0xFFEDF5E1),
    primaryContainer: Color(0xFFB5D887),
    onPrimaryContainer: Color(0xFFEDF5E1),
    inversePrimary: Color(0xff577a28),
    secondary: Color(0xFF919F87),
    onSecondary: Color(0xffedefeb),
    secondaryContainer: Color(0xffb6bfaf),
    onSecondaryContainer: Color(0xffedefeb),
    tertiary: Color(0xFF54C4D4),
    onTertiary: Color(0xFFE3F5F8),
    tertiaryContainer: Color(0xFF8DD8E2),
    onTertiaryContainer: Color(0xFFE3F5F8),
    error: Color(0xfff64234),
    onError: Color(0xFFFEE0DD),
    errorContainer: Color(0xFFF98178),
    onErrorContainer: Color(0xFFFEE0DD),
    background: Color(0xFFE5E4E6),
    onBackground: Color(0xFF242224),
    surface: Color(0xFFD8D7D9),
    onSurface: Color(0xFF242224),
    surfaceVariant: Color(0xFFE5E4E6),
    onSurfaceVariant: Color(0xFF242224),
    outline: Color(0xFF6B676D),
    outlineVariant: Color(0xFFB1AEB3),
    shadow: Color(0xFF242224),
    scrim: Color(0xFF242224),
    inverseSurface: Color(0xFF6B676D),
  );
}

class ThemeProvider {
  ThemeProvider._internal();
  static ThemeData lightTheme() {
    const colorScheme = ColorSchemeProvider.lightFromCorePalette;
    final textTheme = ThemeData(brightness: Brightness.light).textTheme;
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: colorScheme,
      textTheme: textTheme,
      scaffoldBackgroundColor: colorScheme.background,
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF90C44B),
        foregroundColor: Color(0xFFEDF5E1),
      ),
    );
  }

  static ThemeData darkTheme() {
    const colorScheme = ColorSchemeProvider.darkFromCorePalette;
    final textTheme = ThemeData(brightness: Brightness.dark).textTheme;
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: colorScheme,
      textTheme: textTheme,
      scaffoldBackgroundColor: colorScheme.background,
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF90C44B),
        foregroundColor: Color(0xFFEDF5E1),
      ),
    );
  }
}
