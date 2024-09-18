//

// import 'dart:developer';

import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:my_core/theming/app_colors.dart';

class TextThemeProvider {
  static TextTheme generate(String fontName) {
    return ThemeData(brightness: Brightness.light)
        .textTheme
        .apply(fontFamily: fontName);
    // return const TextTheme().apply(fontFamily: fontName);
  }

  // static TextTheme generateDynamic(bool isArabic) {
  //   return isArabic
  //       ? _dubaiFont()
  //       : GoogleFonts.poppinsTextTheme(
  //           ThemeData(brightness: Brightness.light).textTheme,
  //         );
  // }

  // static TextTheme _dubaiFont() {
  //   log('Fetch Dubai', name: 'TextThemeProvider');

  //   final textTheme = GoogleFonts.tajawalTextTheme(
  //       ThemeData(brightness: Brightness.light).textTheme);
  //   return textTheme;
  // }
}
