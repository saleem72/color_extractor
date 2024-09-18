//

import 'package:flutter/material.dart';

extension ContextDetails on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  NavigatorState get navigator => Navigator.of(this);
}
