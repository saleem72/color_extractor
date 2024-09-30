//

import 'package:color_extractor/core/extensions/color_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class AppColor extends Equatable {
  final String hex;
  final String rgb;
  final String token;
  final int value;

  const AppColor({
    required this.hex,
    required this.rgb,
    required this.token,
    required this.value,
  });

  @override
  List<Object?> get props => [hex];

  Color get color => Color(int.tryParse(hex) ?? 0);

  String colorSyntax(String title) =>
      'static const Color $title$value = Color($hex);';

  factory AppColor.fromColor(Color color, int value) {
    return AppColor(
      hex: '0xFF${color.hex}',
      rgb: 'RGB(red: ${color.red}, green: ${color.green}, blue: ${color.blue})',
      token: '',
      value: value,
    );
  }
}
