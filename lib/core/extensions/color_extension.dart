//

import 'package:flutter/material.dart';

extension HexColor on String {
  Color toColorLocal() {
    var hexColor = toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    final hex = int.parse(hexColor, radix: 16);
    return Color(hex);
  }

  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

extension ColorToMaterial on Color {
  MaterialColor toMaterialColor() {
    final hslColor = HSLColor.fromColor(this);
    final lightness = hslColor.lightness;

    /// if [500] is the default color, there are at LEAST five
    /// steps below [500]. (i.e. 400, 300, 200, 100, 50.) A
    /// divisor of 5 would mean [50] is a lightness of 1.0 or
    /// a color of #ffffff. A value of six would be near white
    /// but not quite.
    const lowDivisor = 6;

    /// if [500] is the default color, there are at LEAST four
    /// steps above [500]. A divisor of 4 would mean [900] is
    /// a lightness of 0.0 or color of #000000
    const highDivisor = 5;

    final lowStep = (1.0 - lightness) / lowDivisor;
    final highStep = lightness / highDivisor;
    final primary = (hslColor.withLightness(lightness)).toColor().value;
    return MaterialColor(
      primary,
      {
        50: (hslColor.withLightness(lightness + (lowStep * 5))).toColor(),
        100: (hslColor.withLightness(lightness + (lowStep * 4))).toColor(),
        200: (hslColor.withLightness(lightness + (lowStep * 3))).toColor(),
        300: (hslColor.withLightness(lightness + (lowStep * 2))).toColor(),
        400: (hslColor.withLightness(lightness + lowStep)).toColor(),
        500: (hslColor.withLightness(lightness)).toColor(),
        600: (hslColor.withLightness(lightness - highStep)).toColor(),
        700: (hslColor.withLightness(lightness - (highStep * 2))).toColor(),
        800: (hslColor.withLightness(lightness - (highStep * 3))).toColor(),
        900: (hslColor.withLightness(lightness - (highStep * 4))).toColor(),
      },
    );
  }

  String toHex() {
    return value.toRadixString(16).substring(2, 8).toUpperCase();
  }

  String toSyntaxColorWithShade(int shade) {
    return '$shade: Color(0xFF${toHex()}),';
  }

  String toSyntaxColor() {
    return 'Color(0xFF${toHex()})';
  }
}

extension MaterialColorToObject on MaterialColor {
  List<String> toObject(String title) {
    final lines = <String>[];
    lines.add('static const MaterialColor $title = MaterialColor(');
    lines.add('0xFF${shade500.toHex()},');
    lines.add('{');
    lines.add(shade50.toSyntaxColorWithShade(50));
    lines.add(shade100.toSyntaxColorWithShade(100));
    lines.add(shade200.toSyntaxColorWithShade(200));
    lines.add(shade300.toSyntaxColorWithShade(300));
    lines.add(shade400.toSyntaxColorWithShade(400));
    lines.add(shade500.toSyntaxColorWithShade(500));
    lines.add(shade600.toSyntaxColorWithShade(600));
    lines.add(shade700.toSyntaxColorWithShade(700));
    lines.add(shade800.toSyntaxColorWithShade(800));
    lines.add(shade900.toSyntaxColorWithShade(900));
    lines.add('},');
    lines.add(');');

    return lines;
  }
}
