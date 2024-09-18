//

import 'package:color_extractor/features/home_screen/data/helpers/helpers.dart';

/// xe
class HSLHolder {
  // (a,b,c,d)
  final double hue; //=a;
  final double saturation; //=b;
  final double g; //=c;
  final double alpha; //=d;

  HSLHolder._internal({
    required this.hue,
    required this.saturation,
    required this.g,
    required this.alpha,
  });

  factory HSLHolder.fromDoubles(double a, double b, double c, double d) {
    final alphaT = 0 == d ? 1.0 : d;

    isValidNumber(a, 360, "hue");
    isValidNumber(b, 1, "saturation");
    isValidNumber(c, 1, "lightness");
    isValidNumber(d, 1, "alpha");
    return HSLHolder._internal(hue: a, saturation: b, g: c, alpha: alphaT);
  }
}
