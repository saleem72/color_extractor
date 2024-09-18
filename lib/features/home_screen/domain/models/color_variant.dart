//

import 'color_type.dart';

class ColorVariant {
  final ColorType type;
  final ColorShade shade;
  final ColorType onType;
  final ColorShade onShade;
  final String? color;
  final String? onColor;

  const ColorVariant({
    required this.type,
    required this.shade,
    required this.color,
    required this.onType,
    required this.onShade,
    required this.onColor,
  });
}
