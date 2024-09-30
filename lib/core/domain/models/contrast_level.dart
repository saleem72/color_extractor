//

import 'package:flutter/material.dart';

enum ContrastLevel {
  veryPoor,
  poor,
  good,
  veryGood,
  excellent;

  factory ContrastLevel.fromValue(double value) => switch (value) {
        < 3 => ContrastLevel.veryPoor,
        < 4.5 => ContrastLevel.poor,
        < 7 => ContrastLevel.good,
        < 12 => ContrastLevel.veryGood,
        double() => ContrastLevel.excellent,
      };

  Color get color => switch (this) {
        ContrastLevel.veryPoor => const Color(0xFFFBD0DA),
        ContrastLevel.poor => const Color(0xFFFBD0DA),
        ContrastLevel.good => const Color(0xFFFBF5D0),
        ContrastLevel.veryGood => const Color(0xFFD2FBD0),
        ContrastLevel.excellent => const Color(0xFFD2FBD0),
      };

  Color get onColor => switch (this) {
        ContrastLevel.veryPoor => const Color(0xFF5F071C),
        ContrastLevel.poor => const Color(0xFF5F071C),
        ContrastLevel.good => const Color(0xFF5F5207),
        ContrastLevel.veryGood => const Color(0xFF0D5F07),
        ContrastLevel.excellent => const Color(0xFF0D5F07),
      };

  String get label => switch (this) {
        ContrastLevel.veryPoor => 'Very Poor',
        ContrastLevel.poor => 'Poor',
        ContrastLevel.good => 'Good',
        ContrastLevel.veryGood => 'Very Good',
        ContrastLevel.excellent => 'Super',
      };

  //
}
