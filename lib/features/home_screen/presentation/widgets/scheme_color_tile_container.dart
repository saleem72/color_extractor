//

import 'package:color_extractor/core/configuration/constants.dart';
import 'package:color_extractor/core/extensions/build_context_extension.dart';
import 'package:color_extractor/features/home_screen/domain/models/color_variant.dart';
import 'package:flutter/material.dart';

import 'select_color_variant_view.dart';

class SchemeColorTileContainer extends StatelessWidget {
  const SchemeColorTileContainer({
    super.key,
    required this.label,
    required this.color,
    required this.onColor,
    required this.onColorChange,
  });

  final Color color;
  final String label;
  final Color onColor;
  final Function(ColorVariant variant) onColorChange;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => _showPicker(context),
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          color: color,
          borderRadius: AppConstants.borderRadius,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Center(
          child: Text(
            label,
            style: context.textTheme.bodyMedium?.copyWith(
              color: onColor,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  _showPicker(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        titlePadding: const EdgeInsets.all(0),
        contentPadding: const EdgeInsets.all(16),
        content: SelectColorVariantView(
          onSelection: (variant) {
            return onColorChange(variant);
          },
        ),
      ),
    );
  }
}
