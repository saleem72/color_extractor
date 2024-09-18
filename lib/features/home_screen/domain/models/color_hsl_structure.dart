//

class ColorHSLStructure {
  final String hex;
  final double hue;
  final double saturation;
  final double value;
  final double alpha;
  ColorHSLStructure({
    required this.hex,
    required this.hue,
    required this.saturation,
    required this.value,
    required this.alpha,
  });

  @override
  String toString() =>
      'Be(hex: $hex, hue: $hue, saturation: $saturation, value: $value, alpha: $alpha)';
}
