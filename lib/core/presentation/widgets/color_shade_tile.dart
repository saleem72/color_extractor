//

import 'package:color_extractor/core/extensions/build_context_extension.dart';
import 'package:flutter/material.dart';

class ColorShadeTile extends StatelessWidget {
  const ColorShadeTile({
    super.key,
    required this.color,
    required this.label,
  });

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Text(
          label,
          style: context.textTheme.bodySmall,
        ),
      ),
    );
  }
}
