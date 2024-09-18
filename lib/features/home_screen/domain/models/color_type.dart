//

enum ColorType {
  primary,
  secondary,
  tertiary,
  error,
  neutralVariant,
  neutral;

  String get title => switch (this) {
        ColorType.primary => 'Primary',
        ColorType.secondary => 'Secondary',
        ColorType.tertiary => 'Tertiary',
        ColorType.error => 'Error',
        ColorType.neutral => 'Neutral',
        ColorType.neutralVariant => 'N Variant',
      };
}

enum ColorShade {
  shade50,
  shade100,
  shade200,
  shade300,
  shade400,
  shade500,
  shade600,
  shade700,
  shade800,
  shade900;
}
