//

import 'package:color_extractor/features/home_screen/data/helpers/helpers.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ColorRGBStructure extends Equatable {
  final String hex;
  final double red;
  final double green;
  final double blue;
  final double alpha;
  final bool isSelected;

  const ColorRGBStructure({
    required this.hex,
    required this.red,
    required this.green,
    required this.blue,
    required this.alpha,
    required this.isSelected,
  });

  Color get color => Color.fromRGBO(
      (red * 255).round(), (green * 255).round(), (blue * 255).round(), alpha);

  factory ColorRGBStructure.fromDoubles(double a, double b, double c, double d,
      {bool? isSelected}) {
    final double alphaT = 0 == d ? 1 : d;
    final hex = Color.fromRGBO(
      (a * 255).round(),
      (b * 255).round(),
      (c * 255).round(),
      alphaT,
    ).value.toRadixString(16).substring(2);
    isValidNumber(a, 1, "red");
    isValidNumber(b, 1, "green");
    isValidNumber(c, 1, "blue");
    isValidNumber(alphaT, 1, "alpha");
    return ColorRGBStructure(
        hex: hex,
        red: a,
        green: b,
        blue: c,
        alpha: alphaT,
        isSelected: isSelected ?? false);
  }

  @override
  List<Object?> get props => [
        hex,
        red,
        green,
        blue,
        alpha,
      ];

  @override
  String toString() =>
      'Color(hex: $hex, red: $red, green: $green, blue: $blue, alpha: $alpha)';
}
