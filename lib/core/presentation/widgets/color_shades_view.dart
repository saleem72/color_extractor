//

import 'package:flutter/material.dart';

import 'color_shade_tile.dart';

class ColorShadesView extends StatelessWidget {
  const ColorShadesView({
    super.key,
    required this.color,
    required this.label,
  });
  final MaterialColor color;
  final String label;
  @override
  Widget build(BuildContext context) {
    // final shades = [50, 100, 200, 300, 400, 500, 600, 700, 800, 900];
    return SizedBox(
      width: 100,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ColorShadeTile(color: color.shade50, label: '$label 50'),
          const SizedBox(height: 8),
          ColorShadeTile(color: color.shade100, label: '$label 100'),
          const SizedBox(height: 8),
          ColorShadeTile(color: color.shade200, label: '$label 200'),
          const SizedBox(height: 8),
          ColorShadeTile(color: color.shade300, label: '$label 300'),
          const SizedBox(height: 8),
          ColorShadeTile(color: color.shade400, label: '$label 400'),
          const SizedBox(height: 8),
          ColorShadeTile(color: color.shade500, label: '$label 500'),
          const SizedBox(height: 8),
          ColorShadeTile(color: color.shade600, label: '$label 600'),
          const SizedBox(height: 8),
          ColorShadeTile(color: color.shade700, label: '$label 700'),
          const SizedBox(height: 8),
          ColorShadeTile(color: color.shade800, label: '$label 800'),
          const SizedBox(height: 8),
          ColorShadeTile(color: color.shade900, label: '$label 900'),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
