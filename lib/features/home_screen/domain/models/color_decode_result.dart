//

import 'color_rgb_with_name.dart';

class ColorDecodeResult {
  final ColorRGBWithName primary;
  final ColorRGBWithName complementary;
  final ColorRGBWithName analogous1;
  final ColorRGBWithName analogous2;
  final ColorRGBWithName triadic1;
  final ColorRGBWithName triadic2;
  ColorDecodeResult({
    required this.primary,
    required this.complementary,
    required this.analogous1,
    required this.analogous2,
    required this.triadic1,
    required this.triadic2,
  });
}
