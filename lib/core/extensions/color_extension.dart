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
  String get hex {
    return value.toRadixString(16).substring(2, 8).toUpperCase();
  }

  String toSyntaxColorWithShade(int shade) {
    return '$shade: Color(0xFF$hex),';
  }

  String toSyntaxColor() {
    return 'Color(0xFF$hex)';
  }
}

extension MaterialColorToObject on MaterialColor {
  List<String> toObject(String title) {
    final lines = <String>[];
    lines.add('static const MaterialColor $title = MaterialColor(');
    lines.add('0xFF${shade500.hex},');
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

  List<Color> get shades => [
        shade50,
        shade100,
        shade200,
        shade300,
        shade400,
        shade500,
        shade600,
        shade700,
        shade800,
        shade900,
      ];
}
