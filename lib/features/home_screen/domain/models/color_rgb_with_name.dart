//

import 'package:color_extractor/features/home_screen/domain/models/color_type.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'color_rgb_structure.dart';

class ColorRGBWithName extends Equatable {
  final ColorRGBStructure rgb;
  final String name;
  final List<ColorRGBStructure> shades;
  const ColorRGBWithName({
    required this.rgb,
    required this.name,
    required this.shades,
  });

  @override
  List<Object?> get props => [rgb, name, shades];

  MaterialColor toMaterialColor() {
    // final degrees = [50, 100, 200, 300, 400, 500, 600, 700, 800, 900];
    final swatch = colorDegrees
        .asMap()
        .map((key, degree) => MapEntry(degree, shades[key].color));

    return MaterialColor(shades[5].color.value, swatch);
  }
}
