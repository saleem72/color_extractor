//

import 'package:equatable/equatable.dart';

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
}
